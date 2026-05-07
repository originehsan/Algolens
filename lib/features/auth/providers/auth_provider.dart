import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/core/local/hive_service.dart';
import 'package:algolens/core/storage/secure_storage.dart';
import 'package:algolens/features/auth/data/models/auth_request_model.dart';
import 'package:algolens/features/auth/data/repositories/auth_repository.dart';

// ─────────────────────────────────
// AUTH STATE
// Sealed class — 4 states only
// ─────────────────────────────────

sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  const AuthSuccess({this.message});
  final String? message;
}

class AuthError extends AuthState {
  const AuthError({
    required this.message,
  });
  final String message;
}

// ─────────────────────────────────
// BASE NOTIFIER
// ─────────────────────────────────

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this.ref) : super(const AuthInitial());

  final Ref ref;

  void setLoading() => state = const AuthLoading();

  void setSuccess([String? msg]) => state = AuthSuccess(message: msg);

  void setError(ApiException e) => state = AuthError(message: e.message);

  void reset() => state = const AuthInitial();
}

// ─────────────────────────────────
// REGISTER
// ─────────────────────────────────

final registerProvider = StateNotifierProvider<RegisterNotifier, AuthState>(
    (ref) => RegisterNotifier(ref));

class RegisterNotifier extends AuthNotifier {
  RegisterNotifier(super.ref);

  Future<void> register(RegisterRequest request) async {
    setLoading();
    try {
      final res = await ref.read(authRepositoryProvider).register(request);
      setSuccess(res.message);
    } on ApiException catch (e) {
      setError(e);
    }
  }
}

// ─────────────────────────────────
// LOGIN
// Checks cfHandle after success
// ─────────────────────────────────

final loginProvider = StateNotifierProvider<LoginNotifier, AuthState>(
    (ref) => LoginNotifier(ref));

class LoginNotifier extends AuthNotifier {
  LoginNotifier(super.ref);

  /// true = go to /cf-handle-setup
  /// false = go to /home
  bool needsCfSetup = false;

  Future<void> login(LoginRequest request) async {
    setLoading();
    try {
      await ref.read(authRepositoryProvider).login(request);

      final cfHandle = await SecureStorage.getCfHandle();

      needsCfSetup = cfHandle == null || cfHandle.isEmpty;

      setSuccess();
    } on ApiException catch (e) {
      setError(e);
    }
  }
}

// ─────────────────────────────────
// LOGOUT
// Clears SecureStorage + Hive
// ─────────────────────────────────

final logoutProvider = StateNotifierProvider<LogoutNotifier, AuthState>(
    (ref) => LogoutNotifier(ref));

class LogoutNotifier extends AuthNotifier {
  LogoutNotifier(super.ref);

  Future<void> logout() async {
    setLoading();
    try {
      final token = await SecureStorage.getRefreshToken();

      if (token != null) {
        await ref.read(authRepositoryProvider).logout(
              LogoutRequest(refreshToken: token),
            );
      }
      await HiveService.clearOnLogout();
      setSuccess();
    } on ApiException catch (e) {
      await HiveService.clearOnLogout();
      setError(e);
    }
  }

  Future<void> logoutAll() async {
    setLoading();
    try {
      final token = await SecureStorage.getRefreshToken();

      if (token != null) {
        await ref.read(authRepositoryProvider).logoutAll(
              LogoutRequest(refreshToken: token),
            );
      }
      await HiveService.clearOnLogout();
      setSuccess();
    } on ApiException catch (e) {
      await HiveService.clearOnLogout();
      setError(e);
    }
  }
}

// ─────────────────────────────────
// FORGOT PASSWORD
// ─────────────────────────────────

final forgotPasswordProvider =
    StateNotifierProvider<ForgotPasswordNotifier, AuthState>(
        (ref) => ForgotPasswordNotifier(ref));

class ForgotPasswordNotifier extends AuthNotifier {
  ForgotPasswordNotifier(super.ref);

  Future<void> forgotPassword(String email) async {
    setLoading();
    try {
      final res = await ref.read(authRepositoryProvider).forgotPassword(
            ForgotPasswordRequest(email: email),
          );
      setSuccess(res.message);
    } on ApiException catch (e) {
      setError(e);
    }
  }
}

// ─────────────────────────────────
// VERIFY RESET TOKEN
// ─────────────────────────────────

final verifyResetTokenProvider =
    StateNotifierProvider<VerifyResetTokenNotifier, AuthState>(
        (ref) => VerifyResetTokenNotifier(ref));

class VerifyResetTokenNotifier extends AuthNotifier {
  VerifyResetTokenNotifier(super.ref);

  Future<void> verifyResetToken(String token) async {
    setLoading();
    try {
      final res = await ref.read(authRepositoryProvider).verifyResetToken(
            VerifyResetTokenRequest(token: token),
          );
      setSuccess(res.message);
    } on ApiException catch (e) {
      setError(e);
    }
  }
}

// ─────────────────────────────────
// RESET PASSWORD
// ─────────────────────────────────

final resetPasswordProvider =
    StateNotifierProvider<ResetPasswordNotifier, AuthState>(
        (ref) => ResetPasswordNotifier(ref));

class ResetPasswordNotifier extends AuthNotifier {
  ResetPasswordNotifier(super.ref);

  Future<void> resetPassword({
    required String otp,
    required String newPassword,
  }) async {
    setLoading();
    try {
      final res = await ref.read(authRepositoryProvider).resetPassword(
            ResetPasswordRequest(otp: otp, newPassword: newPassword),
          );
      setSuccess(res.message);
    } on ApiException catch (e) {
      setError(e);
    }
  }
}

// ─────────────────────────────────
// RESEND VERIFICATION
// ─────────────────────────────────

final resendVerificationProvider =
    StateNotifierProvider<ResendVerificationNotifier, AuthState>(
        (ref) => ResendVerificationNotifier(ref));

class ResendVerificationNotifier extends AuthNotifier {
  ResendVerificationNotifier(super.ref);

  Future<void> resendVerification(String email) async {
    setLoading();
    try {
      final res =
          await ref.read(authRepositoryProvider).resendVerification(email);
      setSuccess(res.message);
    } on ApiException catch (e) {
      setError(e);
    }
  }
}
