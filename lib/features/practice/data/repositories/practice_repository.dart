import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/features/practice/data/models/problem_model.dart';
import 'package:algolens/features/practice/data/models/weak_topic_model.dart';

// ─────────────────────────────────
// PROVIDER
// ─────────────────────────────────

final practiceRepositoryProvider = Provider<PracticeRepository>(
  (ref) => PracticeRepository(
    ref.watch(dioClientProvider),
  ),
);

// ─────────────────────────────────
// REPOSITORY
// ─────────────────────────────────

class PracticeRepository {
  PracticeRepository(this._client);
  final DioClient _client;

  // GET /insights/{handle}/weak-topics
  // No cache — always fresh
  Future<List<WeakTopicModel>> getWeakTopics(String handle) async {
    try {
      final data = await _client.get(
        ApiEndpoints.weakTopics(handle),
      );
      final List<dynamic> list = (data['topics'] as List?) ??
          (data['weakTopics'] as List?) ??
          (data is List ? data as List : const <dynamic>[]);
      return list
          .map(
            (e) => WeakTopicModel.fromJson(
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

  // GET /insights/{handle}/recommendations
  // No cache — always fresh
  Future<List<ProblemModel>> getRecommendations(String handle) async {
    try {
      final data = await _client.get(
        ApiEndpoints.recommendations(handle),
      );
      final List<dynamic> list = (data['problems'] as List?) ??
          (data['recommendations'] as List?) ??
          (data is List ? data as List : const <dynamic>[]);
      return list
          .map(
            (e) => ProblemModel.fromJson(
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
}
