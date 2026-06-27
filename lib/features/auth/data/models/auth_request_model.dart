// ──────────────────────────────
// AUTH REQUEST MODELS
// Plain Dart — NO annotations
// NO code generation
// NO .g.dart file
// ──────────────────────────────

/// Register new user
/// POST /auth/register
class RegisterRequest {
  const RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
      };
}

// ──────────────────────────────

/// Login existing user
/// POST /auth/login
class LoginRequest {
  const LoginRequest({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

// ──────────────────────────────

/// Request password reset email
/// POST /auth/forgot-password
class ForgotPasswordRequest {
  const ForgotPasswordRequest({
    required this.email,
  });

  final String email;

  Map<String, dynamic> toJson() => {
        'email': email,
      };
}

// ──────────────────────────────

/// Verify OTP reset token
/// POST /auth/verify-reset-token
class VerifyResetTokenRequest {
  const VerifyResetTokenRequest({
    required this.token,
  });

  final String token;

  Map<String, dynamic> toJson() => {
        'token': token,
      };
}

// ──────────────────────────────

/// Reset password with OTP
/// POST /auth/reset-password
class ResetPasswordRequest {
  const ResetPasswordRequest({
    required this.otp,
    required this.newPassword,
  });

  final String otp;
  final String newPassword;

  Map<String, dynamic> toJson() => {
        'otp': otp,
        'newPassword': newPassword,
      };
}

// ──────────────────────────────

/// Refresh access token
/// POST /auth/refresh
class RefreshTokenRequest {
  const RefreshTokenRequest({
    required this.refreshToken,
  });

  final String refreshToken;

  Map<String, dynamic> toJson() => {
        'refreshToken': refreshToken,
      };
}

// ──────────────────────────────

/// Logout current device
/// POST /auth/logout
/// POST /auth/logout-all
class LogoutRequest {
  const LogoutRequest({
    required this.refreshToken,
  });

  final String refreshToken;

  Map<String, dynamic> toJson() => {
        'refreshToken': refreshToken,
      };
}

// ──────────────────────────────

/// Resend verification email
/// POST /auth/resend-verification
class ResendVerificationRequest {
  const ResendVerificationRequest({
    required this.email,
  });

  final String email;

  Map<String, dynamic> toJson() => {
        'email': email,
      };
}
