import 'dart:convert';
import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/local/hive_service.dart';
import 'package:algolens/features/profile/data/models/profile_model.dart';
import 'package:algolens/features/profile/data/models/rating_graph_model.dart';
import 'package:algolens/features/profile/data/models/submission_stats_model.dart';
import 'package:algolens/features/profile/data/models/contest_history_model.dart';

class ProfileRepository {
  final DioClient _dioClient;

  ProfileRepository(this._dioClient);

  Future<UserProfile> getProfile(String handle) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.profile(handle),
      );
      final profile = UserProfile.fromJson(response);

      // Cache as JSON
      await HiveService.cachedProfiles.put(
        handle,
        jsonEncode(response),
      );

      return profile;
    } catch (e) {
      // Try to load from cache on error
      final cached = HiveService.cachedProfiles.get(handle);
      if (cached != null) {
        try {
          return UserProfile.fromJson(jsonDecode(cached as String));
        } catch (_) {
          rethrow;
        }
      }
      rethrow;
    }
  }

  Future<List<RatingPoint>> getRatingGraph(String handle) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.ratingGraph(handle),
      );
      final data = (response as List)
          .map((json) => RatingPoint.fromJson(json as Map<String, dynamic>))
          .toList();

      // Cache as JSON
      await HiveService.cachedProfiles.put(
        'rating_$handle',
        jsonEncode(response),
      );

      return data;
    } catch (e) {
      // Try cache fallback
      final cached = HiveService.cachedProfiles.get('rating_$handle');
      if (cached != null) {
        try {
          return (jsonDecode(cached as String) as List)
              .map((json) => RatingPoint.fromJson(json as Map<String, dynamic>))
              .toList();
        } catch (_) {
          rethrow;
        }
      }
      rethrow;
    }
  }

  Future<SubmissionStats> getSubmissionStats(String handle) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.submissionStats(handle),
      );
      final stats = SubmissionStats.fromJson(response);

      // Cache as JSON
      await HiveService.cachedProfiles.put(
        'stats_$handle',
        jsonEncode(response),
      );

      return stats;
    } catch (e) {
      // Try cache fallback
      final cached = HiveService.cachedProfiles.get('stats_$handle');
      if (cached != null) {
        try {
          return SubmissionStats.fromJson(jsonDecode(cached as String));
        } catch (_) {
          rethrow;
        }
      }
      rethrow;
    }
  }

  Future<List<ContestHistoryItem>> getContestHistory(String handle) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.contestHistory(handle),
      );
      final history = (response as List)
          .map((json) =>
              ContestHistoryItem.fromJson(json as Map<String, dynamic>))
          .toList();

      // Cache as JSON
      await HiveService.cachedProfiles.put(
        'history_$handle',
        jsonEncode(response),
      );

      return history;
    } catch (e) {
      // Try cache fallback
      final cached = HiveService.cachedProfiles.get('history_$handle');
      if (cached != null) {
        try {
          return (jsonDecode(cached as String) as List)
              .map((json) =>
                  ContestHistoryItem.fromJson(json as Map<String, dynamic>))
              .toList();
        } catch (_) {
          rethrow;
        }
      }
      rethrow;
    }
  }
}
