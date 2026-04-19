import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/features/profile/data/models/profile_model.dart';
import 'package:algolens/features/profile/data/models/rating_graph_model.dart';
import 'package:algolens/features/profile/data/models/submission_stats_model.dart';
import 'package:algolens/features/profile/data/models/contest_history_model.dart';

class ProfileRepository {
  final DioClient _dioClient;

  ProfileRepository({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient.instance;

  Future<UserProfile> getProfile(String handle) async {
    try {
      final response = await _dioClient.dio.get(
        ApiEndpoints.userProfile(handle),
      );
      return UserProfile.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RatingPoint>> getRatingGraph(String handle) async {
    try {
      final response = await _dioClient.dio.get(
        ApiEndpoints.ratingGraph(handle),
      );
      return (response.data as List)
          .map((item) => RatingPoint.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<SubmissionStats> getSubmissionStats(String handle) async {
    try {
      final response = await _dioClient.dio.get(
        ApiEndpoints.submissionStats(handle),
      );
      return SubmissionStats.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ContestHistoryItem>> getContestHistory(String handle) async {
    try {
      final response = await _dioClient.dio.get(
        ApiEndpoints.contestHistory(handle),
      );
      return (response.data as List)
          .map((item) =>
              ContestHistoryItem.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
