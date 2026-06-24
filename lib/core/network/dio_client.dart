import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/config/env_config.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/core/network/auth_interceptor.dart';
import 'package:algolens/core/network/connectivity_interceptor.dart';
import 'package:algolens/core/network/mock_interceptor.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: EnvConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 10),
      headers: const {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Mock intercepts before connectivity check
  // so app works offline in mock mode
  if (EnvConfig.useMock) {
    dio.interceptors.add(MockInterceptor());
  } else {
    dio.interceptors.add(ConnectivityInterceptor());
  }

  dio.interceptors.add(AuthInterceptor());

  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: false,
      error: true,
    ),
  );

  return dio;
});

final dioClientProvider = Provider<DioClient>((ref) {
  final dio = ref.watch(dioProvider);
  return DioClient(dio);
});

class DioClient {
  DioClient(this._dio);
  final Dio _dio;

  // ────────────────────────────
  // GET
  // Returns Map — if response is
  // List, wraps in {'data': list}
  // ────────────────────────────

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final res = await _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
      );
      return _normalize(res.data);
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw const ApiException(
        message: 'Something went wrong. Please try again.',
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ────────────────────────────
  // POST
  // ────────────────────────────

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final res = await _dio.post<dynamic>(
        path,
        data: body,
      );
      return _normalize(res.data);
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw const ApiException(
        message: 'Something went wrong. Please try again.',
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ────────────────────────────
  // DELETE
  // ────────────────────────────

  Future<Map<String, dynamic>> delete(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final res = await _dio.delete<dynamic>(
        path,
        data: body,
      );
      return _normalize(res.data);
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw const ApiException(
        message: 'Something went wrong. Please try again.',
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ────────────────────────────
  // NORMALIZE
  // Handles both Map and List
  // responses from mock + real API
  // List → {'data': list}
  // Map  → as-is
  // null → {}
  // ────────────────────────────

  Map<String, dynamic> _normalize(dynamic data) {
    if (data == null) return <String, dynamic>{};
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    if (data is List) return <String, dynamic>{'data': data};
    return <String, dynamic>{};
  }

  // ────────────────────────────
  // ERROR HANDLER
  // User-friendly messages only
  // No raw exception text to UI
  // ────────────────────────────

  ApiException _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionError:
        return const ApiException(
          message: 'No internet connection. Check your network.',
          type: ApiExceptionType.noInternet,
        );
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const ApiException(
          message: 'Connection timed out. Please try again.',
          type: ApiExceptionType.timeout,
        );
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        final msg = _extractMessage(e.response?.data) ??
            'Something went wrong. Please try again.';
        return switch (code) {
          400 => ApiException(
              message: msg,
              type: ApiExceptionType.badRequest,
              statusCode: code,
            ),
          401 => ApiException(
              message: msg,
              type: ApiExceptionType.unauthorized,
              statusCode: code,
            ),
          403 => ApiException(
              message: msg,
              type: ApiExceptionType.forbidden,
              statusCode: code,
            ),
          404 => ApiException(
              message: msg,
              type: ApiExceptionType.notFound,
              statusCode: code,
            ),
          429 => ApiException(
              message: msg,
              type: ApiExceptionType.rateLimited,
              statusCode: code,
            ),
          _ => ApiException(
              message: msg,
              type: ApiExceptionType.serverError,
              statusCode: code,
            ),
        };
      default:
        return const ApiException(
          message: 'Something went wrong. Please try again.',
          type: ApiExceptionType.unknown,
        );
    }
  }

  // ────────────────────────────
  // EXTRACT MESSAGE
  // Safely read 'message' from
  // error response body
  // ────────────────────────────

  String? _extractMessage(dynamic data) {
    if (data == null) return null;
    if (data is Map) return data['message'] as String?;
    return null;
  }
}
