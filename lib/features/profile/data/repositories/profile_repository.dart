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

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref.watch(dioClientProvider));
});

class ProfileRepository {
  ProfileRepository(this._client);
  final DioClient _client;

  Future<ProfileModel> getProfile(String handle) async {
    final box = HiveService.cachedProfiles;

    // Check cache first
    final raw = box.get(handle) as String?;
    if (raw != null) {
      try {
        final map = jsonDecode(raw) as Map<String, dynamic>;
        final cachedAt = DateTime.parse(map['cachedAt'] as String);
        final isValid =
            DateTime.now().difference(cachedAt).inMinutes < 5;
        if (isValid) {
          return ProfileModel.fromJson(map);
        }
      } catch (_) {
        // Cache corrupted — fall through to API
      }
    }

    try {
      final data = await _client.get(ApiEndpoints.profile(handle));
      final profile = ProfileModel.fromJson(data);

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
      throw const ApiException(
        message: 'Failed to load profile. Please try again.',
        type: ApiExceptionType.unknown,
      );
    }
  }

  Future<List<RatingGraphModel>> getRatingGraph(String handle) async {
    try {
      final data = await _client.get(ApiEndpoints.ratingGraph(handle));
      // Mock returns List → DioClient wraps as {'data': [...]}
      // Real API may return {'data': [...]} or direct list
      final list = _extractList(data, keys: ['data']);
      return list
          .map((e) => RatingGraphModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw const ApiException(
        message: 'Failed to load rating history. Please try again.',
        type: ApiExceptionType.unknown,
      );
    }
  }

  Future<SubmissionStatsModel> getSubmissionStats(String handle) async {
    try {
      final data =
          await _client.get(ApiEndpoints.submissionStats(handle));
      return SubmissionStatsModel.fromJson(data);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw const ApiException(
        message: 'Failed to load submission stats. Please try again.',
        type: ApiExceptionType.unknown,
      );
    }
  }

  Future<List<ContestHistoryModel>> getContestHistory(
      String handle) async {
    try {
      final data =
          await _client.get(ApiEndpoints.contestHistory(handle));
      // Mock returns List → DioClient wraps as {'data': [...]}
      // Real API may return {'data': [...]} or direct list
      final list = _extractList(data, keys: ['data']);
      return list
          .map(
              (e) => ContestHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw const ApiException(
        message: 'Failed to load contest history. Please try again.',
        type: ApiExceptionType.unknown,
      );
    }
  }

  Future<void> clearCache(String handle) async {
    await HiveService.cachedProfiles.delete(handle);
  }

  // ────────────────────────────
  // EXTRACT LIST
  // Handles DioClient wrapped
  // list responses
  // ────────────────────────────

  List<dynamic> _extractList(
    Map<String, dynamic> data, {
    required List<String> keys,
  }) {
    for (final key in keys) {
      if (data[key] is List) return data[key] as List;
    }
    return [];
  }
}