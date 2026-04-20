import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/core/network/api_endpoints.dart';
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
      return UserProfile.fromJson(
        response as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RatingPoint>> getRatingGraph(String handle) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.ratingGraph(handle),
      );
      return (response as List)
          .map((json) => RatingPoint.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<SubmissionStats> getSubmissionStats(String handle) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.submissionStats(handle),
      );
      return SubmissionStats.fromJson(
        response as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ContestHistoryItem>> getContestHistory(String handle) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.contestHistory(handle),
      );
      return (response as List)
          .map((json) =>
              ContestHistoryItem.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
