import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/core/storage/secure_storage.dart';
import 'package:algolens/features/auth/data/models/auth_request_model.dart';
import 'package:algolens/features/auth/data/models/auth_response_model.dart';

// ─────────────────────────────────
// PROVIDER
// ─────────────────────────────────

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.watch(dioClientProvider),
  );
});

// ─────────────────────────────────
// REPOSITORY
// ─────────────────────────────────

class AuthRepository {
  AuthRepository(this._client);

  final DioClient _client;

  // ───────────────────────────────
  // REGISTER
  // ───────────────────────────────

  Future<MessageResponse> register(
    RegisterRequest request,
  ) async {
    try {
      final data = await _client.post(
        ApiEndpoints.register,
        body: request.toJson(),
      );
      return MessageResponse.fromJson(data);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: ApiMessages.unknown,
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ───────────────────────────────
  // RESEND VERIFICATION
  // ───────────────────────────────

  Future<MessageResponse> resendVerification(
    String email,
  ) async {
    try {
      final data = await _client.post(
        ApiEndpoints.resendVerification,
        body: ResendVerificationRequest(
          email: email,
        ).toJson(),
      );
      return MessageResponse.fromJson(data);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: ApiMessages.unknown,
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ───────────────────────────────
  // LOGIN
  // Saves tokens to SecureStorage
  // ───────────────────────────────

  Future<LoginResponse> login(
    LoginRequest request,
  ) async {
    try {
      final data = await _client.post(
        ApiEndpoints.login,
        body: request.toJson(),
      );
      final response = LoginResponse.fromJson(data);
      await SecureStorage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
      return response;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: ApiMessages.unknown,
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ───────────────────────────────
  // REFRESH
  // Called by AuthInterceptor on 401
  // ───────────────────────────────

  Future<LoginResponse> refresh(
    RefreshTokenRequest request,
  ) async {
    try {
      final data = await _client.post(
        ApiEndpoints.refresh,
        body: request.toJson(),
      );
      final response = LoginResponse.fromJson(data);
      await SecureStorage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
      return response;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: ApiMessages.unknown,
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ───────────────────────────────
  // LOGOUT
  // Clears tokens even on API fail
  // ───────────────────────────────

  Future<MessageResponse> logout(
    LogoutRequest request,
  ) async {
    try {
      final data = await _client.post(
        ApiEndpoints.logout,
        body: request.toJson(),
      );
      await SecureStorage.clearAll();
      return MessageResponse.fromJson(data);
    } on ApiException {
      await SecureStorage.clearAll();
      rethrow;
    } catch (e) {
      await SecureStorage.clearAll();
      throw ApiException(
        message: ApiMessages.unknown,
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ───────────────────────────────
  // LOGOUT ALL DEVICES
  // ───────────────────────────────

  Future<MessageResponse> logoutAll(
    LogoutRequest request,
  ) async {
    try {
      final data = await _client.post(
        ApiEndpoints.logoutAll,
        body: request.toJson(),
      );
      await SecureStorage.clearAll();
      return MessageResponse.fromJson(data);
    } on ApiException {
      await SecureStorage.clearAll();
      rethrow;
    } catch (e) {
      await SecureStorage.clearAll();
      throw ApiException(
        message: ApiMessages.unknown,
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ───────────────────────────────
  // FORGOT PASSWORD
  // ───────────────────────────────

  Future<MessageResponse> forgotPassword(
    ForgotPasswordRequest request,
  ) async {
    try {
      final data = await _client.post(
        ApiEndpoints.forgotPassword,
        body: request.toJson(),
      );
      return MessageResponse.fromJson(data);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: ApiMessages.unknown,
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ───────────────────────────────
  // VERIFY RESET TOKEN
  // ───────────────────────────────

  Future<MessageResponse> verifyResetToken(
    VerifyResetTokenRequest request,
  ) async {
    try {
      final data = await _client.post(
        ApiEndpoints.verifyResetToken,
        body: request.toJson(),
      );
      return MessageResponse.fromJson(data);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: ApiMessages.unknown,
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ───────────────────────────────
  // RESET PASSWORD
  // ───────────────────────────────

  Future<MessageResponse> resetPassword(
    ResetPasswordRequest request,
  ) async {
    try {
      final data = await _client.post(
        ApiEndpoints.resetPassword,
        body: request.toJson(),
      );
      return MessageResponse.fromJson(data);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: ApiMessages.unknown,
        type: ApiExceptionType.unknown,
      );
    }
  }
}
