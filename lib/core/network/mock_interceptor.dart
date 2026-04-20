import 'dart:async';
import 'package:dio/dio.dart';
import 'package:algolens/core/config/env_config.dart';
import 'package:algolens/core/network/mock_data.dart';

// ──────────────────────────────
// MOCK INTERCEPTOR
// ──────────────────────────────

/// Intercepts all Dio requests
/// and returns fake mock data
///
/// Only active when:
/// EnvConfig.useMock = true
///
/// Flow:
/// 1. onRequest fires
/// 2. Look up path in MockData
/// 3. Add fake delay
/// 4. Return mock response
/// 5. Real network never called
class MockInterceptor extends Interceptor {
  // ────────────────────────────
  // ON REQUEST
  // Return mock instead of
  // real network call
  // ────────────────────────────

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    /// Simulate network delay
    await Future.delayed(
      EnvConfig.mockDelay,
    );

    /// Get mock data for this path
    final data = MockData.getResponse(
      options.path,
      options.method,
    );

    /// Resolve with fake response
    /// Never hits real server
    handler.resolve(
      Response(
        requestOptions: options,
        statusCode: 200,
        data: data,
      ),
    );
  }
}
