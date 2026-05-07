import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/core/local/hive_service.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/features/profile/data/models/profile_model.dart';
import 'package:algolens/features/profile/data/models/rating_graph_model.dart';
import 'package:algolens/features/profile/data/models/submission_stats_model.dart';
import 'package:algolens/features/profile/data/models/contest_history_model.dart';

// ─────────────────────────────────
// PROVIDER
// ─────────────────────────────────

final profileRepositoryProvider =
    Provider<ProfileRepository>((ref) {
  return ProfileRepository(
    ref.watch(dioClientProvider),
  );
});

// ─────────────────────────────────
// REPOSITORY
// ─────────────────────────────────

class ProfileRepository {
  ProfileRepository(this._client);

  final DioClient _client;

  // ───────────────────────────────
  // GET PROFILE
  // Checks Hive cache first (5 min)
  // Falls back to API
  // ───────────────────────────────

  Future<ProfileModel> getProfile(
    String handle,
  ) async {
    final box = HiveService.cachedProfiles;

    // Check cache first
    final raw = box.get(handle) as String?;
    if (raw != null) {
      try {
        final map =
            jsonDecode(raw) as Map<String, dynamic>;
        final cachedAt = DateTime.parse(
          map['cachedAt'] as String,
        );
        final isValid = DateTime.now()
                .difference(cachedAt)
                .inMinutes <
            5;
        if (isValid) {
          return ProfileModel.fromJson(map);
        }
      } catch (_) {
        // Cache corrupted — fall through to API
      }
    }

    // Fetch from API
    try {
      final data = await _client.get(
        ApiEndpoints.profile(handle),
      );
      final profile = ProfileModel.fromJson(data);

      // Save to cache with timestamp
      await box.put(
        handle,
        jsonEncode({
          ...profile.toJson(),
          'cachedAt': DateTime.now().toIso8601String(),
        }),
      );

      return profile;
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
  // GET RATING GRAPH
  // No cache — always fresh
  // ───────────────────────────────

  Future<List<RatingGraphModel>> getRatingGraph(
    String handle,
  ) async {
    try {
      final data = await _client.get(
        ApiEndpoints.ratingGraph(handle),
      );
      final list = data['data'] as List<dynamic>? ??
          (data is List ? data as List<dynamic> : <dynamic>[]);
      return list
          .map(
            (e) => RatingGraphModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();
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
  // GET SUBMISSION STATS
  // No cache — always fresh
  // ───────────────────────────────

  Future<SubmissionStatsModel> getSubmissionStats(
    String handle,
  ) async {
    try {
      final data = await _client.get(
        ApiEndpoints.submissionStats(handle),
      );
      return SubmissionStatsModel.fromJson(data);
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
  // GET CONTEST HISTORY
  // No cache — always fresh
  // ───────────────────────────────

  Future<List<ContestHistoryModel>> getContestHistory(
    String handle,
  ) async {
    try {
      final data = await _client.get(
        ApiEndpoints.contestHistory(handle),
      );
      final list = data['data'] as List<dynamic>? ??
          (data is List ? data as List<dynamic> : <dynamic>[]);
      return list
          .map(
            (e) => ContestHistoryModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();
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
  // CLEAR PROFILE CACHE
  // Called on logout
  // ───────────────────────────────

  Future<void> clearCache(String handle) async {
    await HiveService.cachedProfiles.delete(handle);
  }
}
