import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/errors/app_exceptions.dart';

class AuthRepository {
  final DioClient _dioClient;

  AuthRepository({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient.instance;

  Future<Map<String, String>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dioClient.dio.post(
        ApiEndpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      return {
        'accessToken': response.data['accessToken'] as String,
        'refreshToken': response.data['refreshToken'] as String,
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
      final response = await _dioClient.dio.post(
        ApiEndpoints.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      return response.data as String;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> verifyEmail(String token) async {
    try {
      final response = await _dioClient.dio.get(
        ApiEndpoints.verifyEmail,
        queryParameters: {'token': token},
      );
      return response.data as String;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> forgotPassword(String email) async {
    try {
      final response = await _dioClient.dio.post(
        ApiEndpoints.forgotPassword,
        data: {'email': email},
      );
      return response.data['message'] as String;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> verifyResetToken(String token) async {
    try {
      final response = await _dioClient.dio.post(
        ApiEndpoints.verifyResetToken,
        data: {'token': token},
      );
      return response.data['message'] as String;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> resetPassword({
    required String otp,
    required String newPassword,
  }) async {
    try {
      final response = await _dioClient.dio.post(
        ApiEndpoints.resetPassword,
        data: {
          'otp': otp,
          'newPassword': newPassword,
        },
      );
      return response.data['message'] as String;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> logout(String refreshToken) async {
    try {
      final response = await _dioClient.dio.post(
        ApiEndpoints.logout,
        data: {'refreshToken': refreshToken},
      );
      return response.data as String;
    } catch (e) {
      rethrow;
    }
  }
}
