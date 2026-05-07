// ──────────────────────────────
// AUTH RESPONSE MODELS
// Plain Dart — NO annotations
// NO code generation
// NO .g.dart file
// ──────────────────────────────

/// Login / refresh token response
///
/// Returned by:
/// POST /auth/login
/// POST /auth/refresh
class LoginResponse {
  const LoginResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  factory LoginResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      LoginResponse(
        accessToken: json['accessToken'] as String,
        refreshToken: json['refreshToken'] as String,
      );

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };
}

// ──────────────────────────────

/// Generic message response
///
/// Returned by:
/// POST /auth/register
/// POST /auth/logout
/// POST /auth/logout-all
/// POST /auth/forgot-password
/// POST /auth/verify-reset-token
/// POST /auth/reset-password
/// POST /auth/resend-verification
class MessageResponse {
  const MessageResponse({
    required this.message,
  });

  final String message;

  factory MessageResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      MessageResponse(
        message: json['message'] as String,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
      };
}
