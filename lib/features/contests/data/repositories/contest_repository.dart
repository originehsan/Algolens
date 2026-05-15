import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/core/local/hive_service.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/features/contests/data/models/contest_model.dart';

// ─────────────────────────────────
// PROVIDER
// ─────────────────────────────────

final contestRepositoryProvider = Provider<ContestRepository>((ref) {
  return ContestRepository(
    ref.watch(dioClientProvider),
  );
});

// ─────────────────────────────────
// REPOSITORY
// ─────────────────────────────────

class ContestRepository {
  ContestRepository(this._client);
  final DioClient _client;

  // ───────────────────────────────
  // GET UPCOMING CONTESTS
  // Hive cache 1 hour
  // ───────────────────────────────

  Future<List<ContestModel>> getUpcomingContests() async {
    final box = HiveService.cachedContests;

    // Check cache first
    final raw = box.get('upcoming') as String?;
    if (raw != null) {
      try {
        final map = jsonDecode(raw) as Map<String, dynamic>;
        final cachedAt = DateTime.parse(
          map['cachedAt'] as String,
        );
        final isValid = DateTime.now().difference(cachedAt).inHours < 1;
        if (isValid) {
          final list = map['data'] as List;
          return list
              .map(
                (e) => ContestModel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList();
        }
      } catch (_) {
        // Cache corrupted
        // Fall through to API
      }
    }

    // Fetch from API
    try {
      final data = await _client.get(
        ApiEndpoints.upcomingContests,
      );

      final list = (data['contests'] ?? data) as List;

      final contests = list
          .map(
            (e) => ContestModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();

      // Save to cache
      await box.put(
        'upcoming',
        jsonEncode({
          'data': contests.map((c) => c.toJson()).toList(),
          'cachedAt': DateTime.now().toIso8601String(),
        }),
      );

      return contests;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: e.toString(),
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ───────────────────────────────
  // GET ALL CONTESTS
  // Paginated — no cache
  // ───────────────────────────────

  Future<Map<String, dynamic>> getAllContests({
    int page = 0,
    int size = 20,
  }) async {
    try {
      final data = await _client.get(
        ApiEndpoints.allContests,
        queryParameters: {
          'page': page,
          'size': size,
        },
      );

      return data;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: e.toString(),
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ───────────────────────────────
  // CLEAR CACHE
  // Called on logout
  // ───────────────────────────────

  Future<void> clearCache() async {
    await HiveService.cachedContests.delete('upcoming');
    await HiveService.cachedContests.delete('all');
  }
}
