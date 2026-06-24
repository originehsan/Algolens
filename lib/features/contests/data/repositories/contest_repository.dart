import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/core/local/hive_service.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/features/contests/data/models/contest_model.dart';

final contestRepositoryProvider = Provider<ContestRepository>((ref) {
  return ContestRepository(ref.watch(dioClientProvider));
});

class ContestRepository {
  ContestRepository(this._client);
  final DioClient _client;

  Future<List<ContestModel>> getUpcomingContests() async {
    final box = HiveService.cachedContests;

    // Check cache first
    final raw = box.get('upcoming') as String?;
    if (raw != null) {
      try {
        final map = jsonDecode(raw) as Map<String, dynamic>;
        final cachedAt = DateTime.parse(map['cachedAt'] as String);
        final isValid = DateTime.now().difference(cachedAt).inHours < 1;
        if (isValid) {
          final list = map['data'] as List;
          return list
              .map((e) => ContestModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      } catch (_) {
        // Cache corrupted — fall through to API
      }
    }

    try {
      final data = await _client.get(ApiEndpoints.upcomingContests);

      // Handle all response shapes:
      // Mock List → DioClient wraps as {'data': [...]}
      // Real API Map → may have 'contests' key
      // Real API List → DioClient wraps as {'data': [...]}
      final List<dynamic> list = _extractList(data);

      final contests = list
          .map((e) => ContestModel.fromJson(e as Map<String, dynamic>))
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
      throw const ApiException(
        message: 'Failed to load contests. Please try again.',
        type: ApiExceptionType.unknown,
      );
    }
  }

  Future<Map<String, dynamic>> getAllContests({
    int page = 0,
    int size = 20,
  }) async {
    try {
      return await _client.get(
        ApiEndpoints.allContests,
        queryParameters: {'page': page, 'size': size},
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw const ApiException(
        message: 'Failed to load contests. Please try again.',
        type: ApiExceptionType.unknown,
      );
    }
  }

  Future<void> clearCache() async {
    await HiveService.cachedContests.delete('upcoming');
    await HiveService.cachedContests.delete('all');
  }

  // ────────────────────────────
  // EXTRACT LIST
  // Handles all response shapes
  // ────────────────────────────

  List<dynamic> _extractList(Map<String, dynamic> data) {
    // Real API: {'contests': [...]}
    if (data['contests'] is List) return data['contests'] as List;
    // DioClient wrapped list: {'data': [...]}
    if (data['data'] is List) return data['data'] as List;
    return [];
  }
}