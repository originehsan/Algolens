import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/core/local/hive_service.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/features/analysis/data/models/analysis_model.dart';

final analysisRepositoryProvider = Provider<AnalysisRepository>(
  (ref) => AnalysisRepository(
    ref.watch(dioProvider),
  ),
);

class AnalysisRepository {
  AnalysisRepository(this._dio);
  final Dio _dio;

  // GET /analysis/upsolve/{handle}
  // Groq AI takes 5-30s — extended timeout via raw Dio
  Future<AnalysisResponse> getAnalysis(String handle) async {
    try {
      // Raw Dio used — DioClient.get() doesn't support options
      final res = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.aiAnalysis(handle),
        options: Options(
          receiveTimeout: const Duration(seconds: 60),
          sendTimeout: const Duration(seconds: 30),
        ),
      );

      final data = res.data ?? <String, dynamic>{};

      // Cache in Hive for fallback on next timeout
      await HiveService.cachedProfiles.put(
        'analysis_$handle',
        jsonEncode(data),
      );

      return AnalysisResponse.fromJson(data);
    } on DioException catch (e) {
      // Timeout — try cache before throwing
      if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.connectionTimeout) {
        final cached = HiveService.cachedProfiles.get('analysis_$handle');
        if (cached != null) {
          return AnalysisResponse.fromJson(
            jsonDecode(cached as String) as Map<String, dynamic>,
          );
        }
        throw const ApiException(
          message: 'Analysis timed out. Please try again.',
          type: ApiExceptionType.timeout,
        );
      }
      throw ApiException(
        message: e.message ?? 'Analysis failed',
        type: ApiExceptionType.serverError,
        statusCode: e.response?.statusCode,
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      // Try cache fallback on any error
      final cached = HiveService.cachedProfiles.get('analysis_$handle');
      if (cached != null) {
        try {
          return AnalysisResponse.fromJson(
            jsonDecode(cached as String) as Map<String, dynamic>,
          );
        } catch (_) {}
      }
      throw ApiException(
        message: e.toString(),
        type: ApiExceptionType.unknown,
      );
    }
  }
}