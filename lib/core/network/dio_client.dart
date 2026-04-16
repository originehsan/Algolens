import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:algolens/core/config/env_config.dart';
import 'package:algolens/core/network/auth_interceptor.dart';
import 'package:algolens/core/network/mock_interceptor.dart';

class DioClient {
  static DioClient? _instance;
  late final Dio dio;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: EnvConfig.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _addInterceptors();
  }

  factory DioClient() {
    _instance ??= DioClient._internal();
    return _instance!;
  }

  static DioClient get instance {
    _instance ??= DioClient._internal();
    return _instance!;
  }

  void _addInterceptors() {
    // MockInterceptor must be first
    // so it intercepts before auth
    dio.interceptors.add(MockInterceptor());

    // AuthInterceptor adds JWT header
    dio.interceptors.add(
      AuthInterceptor(
        storage: const FlutterSecureStorage(),
        dio: dio,
      ),
    );

    // Logger only in development
    if (EnvConfig.isDevelopment) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
        ),
      );
    }
  }
}
