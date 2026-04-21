import 'dart:convert';
import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/local/hive_service.dart';
import 'package:algolens/features/analysis/data/models/analysis_model.dart';

class AnalysisRepository {
  final DioClient _dioClient;

  AnalysisRepository(this._dioClient);

  Future<AiAnalysisResponse> getAiAnalysis(String handle) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.aiAnalysis(handle),
      );
      final analysis = AiAnalysisResponse.fromJson(response);

      // Cache as JSON string
      await HiveService.cachedProfiles.put(
        'analysis_$handle',
        jsonEncode(response),
      );

      return analysis;
    } catch (e) {
      // Try cache fallback
      final cached = HiveService.cachedProfiles.get('analysis_$handle');
      if (cached != null) {
        try {
          return AiAnalysisResponse.fromJson(jsonDecode(cached as String));
        } catch (_) {
          rethrow;
        }
      }
      rethrow;
    }
  }
}
