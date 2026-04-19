import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/errors/app_exceptions.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;
  final Dio _dio;

  AuthInterceptor({
    required FlutterSecureStorage storage,
    required Dio dio,
  })  : _storage = storage,
        _dio = dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip auth header for auth endpoints
    final skipPaths = [
      ApiEndpoints.login,
      ApiEndpoints.register,
      ApiEndpoints.refresh,
      ApiEndpoints.verifyEmail,
      ApiEndpoints.forgotPassword,
      ApiEndpoints.verifyResetToken,
      ApiEndpoints.resetPassword,
    ];

    final shouldSkip = skipPaths.any((path) => options.path.contains(path));

    if (!shouldSkip) {
      final token = await _storage.read(key: 'access_token');
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    // Add device ID header for login
    if (options.path.contains(ApiEndpoints.login)) {
      options.headers['X-Device-Id'] = 'algolens-mobile-device';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      try {
        final refreshToken = await _storage.read(key: 'refresh_token');

        if (refreshToken == null) {
          await _storage.deleteAll();
          handler.next(err);
          return;
        }

        // Try to refresh token
        final response = await _dio.post(
          ApiEndpoints.refresh,
          data: {'refreshToken': refreshToken},
        );

        final newAccessToken = response.data['accessToken'] as String;
        final newRefreshToken = response.data['refreshToken'] as String;

        // Save new tokens
        await _storage.write(
          key: 'access_token',
          value: newAccessToken,
        );
        await _storage.write(
          key: 'refresh_token',
          value: newRefreshToken,
        );

        // Retry original request with new token
        err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

        final retryResponse = await _dio.fetch(
          err.requestOptions,
        );
        handler.resolve(retryResponse);
        return;
      } catch (e) {
        // Refresh failed — clear all tokens
        await _storage.deleteAll();
        handler.next(
          DioException(
            requestOptions: err.requestOptions,
            error: const ApiException(
              message: 'Session expired. Please login again.',
              type: ApiExceptionType.sessionExpired,
            ),
          ),
        );
        return;
      }
    }

    handler.next(err);
  }
}
