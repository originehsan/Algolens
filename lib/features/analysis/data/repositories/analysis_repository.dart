import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/features/analysis/data/models/analysis_model.dart';

class AnalysisRepository {
  final DioClient _dioClient;

  AnalysisRepository({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient.instance;

  Future<AiAnalysisResponse> getAiAnalysis(String handle) async {
    try {
      final response = await _dioClient.dio.get(
        ApiEndpoints.aiAnalysis(handle),
      );
      return AiAnalysisResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      throw AppException.fromDioException(e);
    }
  }
}
