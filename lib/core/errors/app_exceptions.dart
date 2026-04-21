/// AlgoLens Exception System
///
/// Single source of truth for
/// all API and app exceptions.
library algolens.core.errors.app_exceptions;

// ──────────────────────────────
// EXCEPTION TYPES
// Maps to HTTP status codes
// ──────────────────────────────

enum ApiExceptionType {
  badRequest,
  unauthorized,
  sessionExpired,
  forbidden,
  notFound,
  conflict,
  unprocessable,
  rateLimited,
  serverError,
  noInternet,
  timeout,
  unknown,
}

class ApiException implements Exception {
  const ApiException({
    required this.message,
    required this.type,
    this.statusCode,
  });

  /// User friendly message
  /// Show directly in UI
  /// Comes from API response
  /// or default message
  final String message;

  /// Exception category
  /// Use for UI decisions
  final ApiExceptionType type;

  /// HTTP status code
  /// null for network errors
  final int? statusCode;

  // ────────────────────────────
  // HELPER GETTERS
  // Use in UI for decisions
  // ────────────────────────────

  /// Network error?
  /// → Show offline banner
  /// → Show retry button
  bool get isNetworkError =>
      type == ApiExceptionType.noInternet || type == ApiExceptionType.timeout;

  /// Session expired?
  /// → Force logout
  /// → Navigate to /login
  bool get isSessionExpired => type == ApiExceptionType.sessionExpired;

  /// Email not verified?
  /// → Show verify email message
  /// → Show resend button
  /// → POST /auth/resend-verification
  bool get isEmailNotVerified =>
      type == ApiExceptionType.forbidden && statusCode == 403;

  /// Rate limited?
  /// → Show wait message
  /// → Disable retry button
  bool get isRateLimited => type == ApiExceptionType.rateLimited;

  /// Conflict/duplicate?
  /// → Show "already exists"
  /// → Email already registered
  /// → Friend already added
  bool get isConflict => type == ApiExceptionType.conflict;

  /// Not found?
  /// → Handle not on CF
  /// → Resource missing
  bool get isNotFound => type == ApiExceptionType.notFound;

  /// Server error?
  /// → Show generic error
  /// → Suggest retry later
  bool get isServerError => type == ApiExceptionType.serverError;

  /// Can retry?
  /// → Show retry button
  bool get canRetry =>
      type != ApiExceptionType.sessionExpired &&
      type != ApiExceptionType.forbidden;

  @override
  String toString() => 'ApiException('
      'type: $type, '
      'statusCode: $statusCode, '
      'message: $message'
      ')';
}

// ──────────────────────────────
// DEFAULT MESSAGES
// User friendly per status code
// Used when API message missing
// ──────────────────────────────

class ApiMessages {
  ApiMessages._();

  static String forStatus(
    int? statusCode,
  ) {
    switch (statusCode) {
      case 400:
        return 'Invalid request. '
            'Please check your input.';
      case 401:
        return 'Session expired. '
            'Please login again.';
      case 403:
        return 'Email not verified. '
            'Please check your inbox.';
      case 404:
        return 'Not found.';
      case 409:
        return 'Already exists.';
      case 422:
        return 'Could not process '
            'your request.';
      case 429:
        return 'Too many requests. '
            'Please wait and try again.';
      case 500:
        return 'Server error. '
            'Please try again later.';
      default:
        return 'Something went wrong. '
            'Please try again.';
    }
  }

  static ApiExceptionType typeFor(
    int? statusCode,
  ) {
    switch (statusCode) {
      case 400:
        return ApiExceptionType.badRequest;
      case 401:
        return ApiExceptionType.unauthorized;
      case 403:
        return ApiExceptionType.forbidden;
      case 404:
        return ApiExceptionType.notFound;
      case 409:
        return ApiExceptionType.conflict;
      case 422:
        return ApiExceptionType.unprocessable;
      case 429:
        return ApiExceptionType.rateLimited;
      case 500:
        return ApiExceptionType.serverError;
      default:
        return ApiExceptionType.unknown;
    }
  }

  // Common messages
  static const String noInternet = 'No internet connection. '
      'Check your network.';

  static const String timeout = 'Connection timeout. '
      'Check your internet.';

  static const String sessionExpired = 'Session expired. '
      'Please login again.';

  static const String unknown = 'Something went wrong. '
      'Please try again.';

  // Auth specific messages
  static const String emailNotVerified = 'Email not verified. '
      'Please check your inbox.';

  static const String invalidCredentials = 'Invalid email or password.';

  static const String emailExists = 'Email already registered. '
      'Please login instead.';

  static const String friendExists = 'Already in your friends list.';

  static const String handleNotFound = 'Handle not found on Codeforces. '
      'Please check and try again.';

  static const String rateLimited = 'Too many requests. '
      'Please wait before trying again.';
}
