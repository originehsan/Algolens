import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/features/practice/data/models/problem_model.dart';
import 'package:algolens/features/practice/data/models/weak_topic_model.dart';

final practiceRepositoryProvider = Provider<PracticeRepository>(
  (ref) => PracticeRepository(ref.watch(dioClientProvider)),
);

class PracticeRepository {
  PracticeRepository(this._client);
  final DioClient _client;

  Future<List<WeakTopicModel>> getWeakTopics(String handle) async {
    try {
      final data = await _client.get(ApiEndpoints.weakTopics(handle));
      // Mock returns List → DioClient wraps as {'data': [...]}
      // Real API may return {'topics': [...]} or {'weakTopics': [...]}
      final list = _extractList(data, keys: ['topics', 'weakTopics', 'data']);
      return list
          .map((e) => WeakTopicModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw const ApiException(
        message: 'Failed to load weak topics. Please try again.',
        type: ApiExceptionType.unknown,
      );
    }
  }

  Future<List<ProblemModel>> getRecommendations(String handle) async {
    try {
      final data = await _client.get(ApiEndpoints.recommendations(handle));
      // Mock returns List → DioClient wraps as {'data': [...]}
      // Real API may return {'problems': [...]} or {'recommendations': [...]}
      final list = _extractList(
        data,
        keys: ['problems', 'recommendations', 'data'],
      );
      return list
          .map((e) => ProblemModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw const ApiException(
        message: 'Failed to load recommendations. Please try again.',
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ────────────────────────────
  // EXTRACT LIST
  // Tries multiple keys to find
  // the list in response
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