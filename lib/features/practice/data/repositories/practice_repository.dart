import 'dart:convert';
import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/local/hive_service.dart';
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
      final topics = (response as List)
          .map((item) => WeakTopic.fromJson(item as Map<String, dynamic>))
          .toList();

      // Cache as JSON
      await HiveService.cachedContests.put(
        'weak_topics_$handle',
        jsonEncode(response),
      );

      return topics;
    } catch (e) {
      // Try cache fallback
      final cached = HiveService.cachedContests.get('weak_topics_$handle');
      if (cached != null) {
        try {
          return (jsonDecode(cached as String) as List)
              .map((item) => WeakTopic.fromJson(item as Map<String, dynamic>))
              .toList();
        } catch (_) {
          rethrow;
        }
      }
      rethrow;
    }
  }

  Future<List<Problem>> getRecommendations(String handle) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.recommendations(handle),
      );
      final problems = (response as List)
          .map((item) => Problem.fromJson(item as Map<String, dynamic>))
          .toList();

      // Cache as JSON
      await HiveService.cachedContests.put(
        'recommendations_$handle',
        jsonEncode(response),
      );

      return problems;
    } catch (e) {
      // Try cache fallback
      final cached = HiveService.cachedContests.get('recommendations_$handle');
      if (cached != null) {
        try {
          return (jsonDecode(cached as String) as List)
              .map((item) => Problem.fromJson(item as Map<String, dynamic>))
              .toList();
        } catch (_) {
          rethrow;
        }
      }
      rethrow;
    }
  }
}
