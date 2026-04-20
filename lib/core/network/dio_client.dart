import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/config/env_config.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/core/network/auth_interceptor.dart';
import 'package:algolens/core/network/connectivity_interceptor.dart';
import 'package:algolens/core/network/mock_interceptor.dart';

// ──────────────────────────────
// DIO PROVIDER
// App-wide singleton
// ──────────────────────────────

/// Global Dio client provider
///
/// Usage:
/// final dio = ref.watch(dioProvider);
/// final res = await dio.get(
///   ApiEndpoints.upcomingContests,
/// );
final dioProvider = Provider<Dio>(
  (ref) {
    final dio = Dio(
      BaseOptions(
        baseUrl: EnvConfig.baseUrl,
        connectTimeout: const Duration(
          seconds: 10,
        ),
        receiveTimeout: const Duration(
          seconds: 30,
        ),
        sendTimeout: const Duration(
          seconds: 10,
        ),
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // ──────────────────────────
    // INTERCEPTORS
    // Order matters:
    // 1. Connectivity check first
    // 2. Mock (if enabled)
    // 3. Auth token injection
    // ──────────────────────────

    /// 1. Check internet first
    /// Throws DioException for no connection
    /// before any network call
    dio.interceptors.add(
      ConnectivityInterceptor(),
    );

    /// 2. Mock responses
    /// Only active when
    /// EnvConfig.useMock = true
    /// Bypasses real network
    if (EnvConfig.useMock) {
      dio.interceptors.add(
        MockInterceptor(),
      );
    }

    /// 3. Auth token injection
    /// Adds Bearer token to headers
    /// Handles 401 auto refresh
    /// Force logout on expiry
    dio.interceptors.add(
      AuthInterceptor(),
    );

    /// 4. Logging (for debugging)
    /// Full request/response logs
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
  },
);

// ──────────────────────────────
// DIO CLIENT HELPER
// Wraps common Dio calls
// Converts DioException →
// ApiException automatically
// ──────────────────────────────

/// Helper class for Dio requests
///
/// Wraps Dio with error handling
/// Converts all errors to
/// ApiException for clean repos
///
/// Usage:
/// final client = ref.watch(
///   dioClientProvider,
/// );
/// final data = await client.get(
///   ApiEndpoints.profile('tourist'),
/// );
final dioClientProvider = Provider<DioClient>((ref) {
  final dio = ref.watch(dioProvider);
  return DioClient(dio);
});

class DioClient {
  DioClient(this._dio);
  final Dio _dio;

  // ────────────────────────────
  // GET
  // ────────────────────────────

  /// HTTP GET request
  ///
  /// Throws ApiException on error
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final res = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
      );
      return res.data ?? <String, dynamic>{};
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ────────────────────────────
  // POST
  // ────────────────────────────

  /// HTTP POST request
  ///
  /// Throws ApiException on error
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        path,
        data: body,
      );
      return res.data ?? <String, dynamic>{};
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ────────────────────────────
  // DELETE
  // ────────────────────────────

  /// HTTP DELETE request
  ///
  /// Throws ApiException on error
  Future<Map<String, dynamic>> delete(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final res = await _dio.delete<Map<String, dynamic>>(
        path,
        data: body,
      );
      return res.data ?? <String, dynamic>{};
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ────────────────────────────
  // ERROR HANDLER
  // DioException → ApiException
  // ────────────────────────────

  /// Convert DioException to
  /// ApiException
  ///
  /// Maps status codes:
  /// 400 → badRequest
  /// 401 → unauthorized
  /// 403 → forbidden
  /// 404 → notFound
  /// 429 → rateLimited
  /// 500 → serverError
  /// no internet → noInternet
  /// timeout → timeout
  ApiException _handleError(
    DioException e,
  ) {
    switch (e.type) {
      case DioExceptionType.connectionError:
        return const ApiException(
          message: 'No internet connection',
          type: ApiExceptionType.noInternet,
        );
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const ApiException(
          message: 'Request timeout',
          type: ApiExceptionType.timeout,
        );
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        final msg =
            e.response?.data?['message'] as String? ?? 'Something went wrong';
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
        return ApiException(
          message: e.message ?? 'Unknown error',
          type: ApiExceptionType.unknown,
        );
    }
  }
}
