import 'package:dio/dio.dart';
import 'package:algolens/core/errors/app_exceptions.dart';

/// Converts DioException to ApiException
/// Should be the last interceptor
class ErrorInterceptor extends Interceptor {
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Check if already converted to ApiException
    if (err.error is ApiException) {
      handler.next(err);
      return;
    }

    // Convert DioException to ApiException
    final apiException = _convertToApiException(err);

    // Wrap in DioException to maintain error chain
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: apiException,
        response: err.response,
        type: err.type,
        stackTrace: err.stackTrace,
      ),
    );
  }

  /// Convert DioException to typed ApiException
  ApiException _convertToApiException(DioException err) {
    // Handle network/timeout errors
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(
          message: ApiMessages.timeout,
          type: ApiExceptionType.timeout,
        );

      case DioExceptionType.connectionError:
        return ApiException(
          message: ApiMessages.noInternet,
          type: ApiExceptionType.noInternet,
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(err);

      default:
        return ApiException(
          message: ApiMessages.unknown,
          type: ApiExceptionType.unknown,
        );
    }
  }

  /// Handle HTTP error responses (4xx, 5xx)
  ApiException _handleBadResponse(DioException err) {
    final statusCode = err.response?.statusCode;
    final backendMessage = _extractBackendMessage(err.response?.data);

    final type = ApiMessages.typeFor(statusCode);
    final message = backendMessage ?? ApiMessages.forStatus(statusCode);

    return ApiException(
      message: message,
      type: type,
      statusCode: statusCode,
    );
  }

  /// Extract user-friendly message from backend response
  /// Backend format: { "message": "...", "error": "..." }
  String? _extractBackendMessage(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      return responseData['message'] as String?;
    }
    return null;
  }
}
