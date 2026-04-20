import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/features/practice/data/models/weak_topic_model.dart';
import 'package:algolens/features/practice/data/models/problem_model.dart';

class PracticeRepository {
  final DioClient _dioClient;

  PracticeRepository(this._dioClient);

  Future<List<WeakTopic>> getWeakTopics(String handle) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.weakTopics(handle),
      );
      return (response as List)
          .map((item) => WeakTopic.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Problem>> getRecommendations(String handle) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.recommendations(handle),
      );
      return (response as List)
          .map((item) => Problem.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
