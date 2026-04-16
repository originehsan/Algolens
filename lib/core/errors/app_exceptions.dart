import 'package:dio/dio.dart';

enum AppExceptionType {
  network,
  unauthorized,
  notFound,
  serverError,
  offline,
  timeout,
  rateLimited,
  validationError,
  unknown,
}

class AppException implements Exception {
  final AppExceptionType type;
  final String message;
  final int? statusCode;

  const AppException({
    required this.type,
    required this.message,
    this.statusCode,
  });

  factory AppException.fromDioException(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const AppException(
            type: AppExceptionType.timeout,
            message: 'Connection timed out. Please try again.',
          );

        case DioExceptionType.connectionError:
          return const AppException(
            type: AppExceptionType.offline,
            message: 'No internet connection. Please check your network.',
          );

        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          switch (statusCode) {
            case 400:
              final msg = error.response?.data?['message'] as String? ??
                  'Invalid request. Please check your input.';
              return AppException(
                type: AppExceptionType.validationError,
                message: msg,
                statusCode: statusCode,
              );
            case 401:
              return AppException(
                type: AppExceptionType.unauthorized,
                message: 'Session expired. Please login again.',
                statusCode: statusCode,
              );
            case 403:
              final msg = error.response?.data?['message'] as String? ??
                  'Email not verified. Please verify your email.';
              return AppException(
                type: AppExceptionType.unauthorized,
                message: msg,
                statusCode: statusCode,
              );
            case 404:
              final msg = error.response?.data?['message'] as String? ??
                  'Resource not found.';
              return AppException(
                type: AppExceptionType.notFound,
                message: msg,
                statusCode: statusCode,
              );
            case 409:
              final msg = error.response?.data?['message'] as String? ??
                  'Resource already exists.';
              return AppException(
                type: AppExceptionType.validationError,
                message: msg,
                statusCode: statusCode,
              );
            case 429:
              return AppException(
                type: AppExceptionType.rateLimited,
                message: 'Too many requests. Please wait and try again.',
                statusCode: statusCode,
              );
            case 500:
            default:
              return AppException(
                type: AppExceptionType.serverError,
                message: 'Server error. Please try again later.',
                statusCode: statusCode,
              );
          }

        default:
          return const AppException(
            type: AppExceptionType.unknown,
            message: 'Something went wrong. Please try again.',
          );
      }
    }

    return const AppException(
      type: AppExceptionType.unknown,
      message: 'Something went wrong. Please try again.',
    );
  }

  String get userMessage {
    switch (type) {
      case AppExceptionType.network:
        return 'Network error. Please check your connection.';
      case AppExceptionType.unauthorized:
        return 'Session expired. Please login again.';
      case AppExceptionType.notFound:
        return 'Not found. Please check your input.';
      case AppExceptionType.serverError:
        return 'Server error. Please try again later.';
      case AppExceptionType.offline:
        return 'No internet connection.';
      case AppExceptionType.timeout:
        return 'Connection timed out. Please try again.';
      case AppExceptionType.rateLimited:
        return 'Too many requests. Please wait.';
      case AppExceptionType.validationError:
        return message;
      case AppExceptionType.unknown:
        return 'Something went wrong. Please try again.';
    }
  }

  @override
  String toString() => 'AppException: $message';
}
