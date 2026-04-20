import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/core/network/api_endpoints.dart';

class AuthRepository {
  final DioClient _dioClient;

  AuthRepository(this._dioClient);

  Future<Map<String, String>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.login,
        body: {
          'email': email,
          'password': password,
        },
      );
      return {
        'accessToken': response['accessToken'] as String,
        'refreshToken': response['refreshToken'] as String,
      };
    } catch (e) {
      rethrow;
    }
  }

  Future<String> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.register,
        body: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      return response as String;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> forgotPassword(String email) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.forgotPassword,
        body: {'email': email},
      );
      return response['message'] as String;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> verifyResetToken(String token) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.verifyResetToken,
        body: {'token': token},
      );
      return response['message'] as String;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> resetPassword({
    required String otp,
    required String newPassword,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.resetPassword,
        body: {
          'otp': otp,
          'newPassword': newPassword,
        },
      );
      return response['message'] as String;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> logout(String refreshToken) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.logout,
        body: {'refreshToken': refreshToken},
      );
      return response as String;
    } catch (e) {
      rethrow;
    }
  }
}
