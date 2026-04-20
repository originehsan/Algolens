import 'dart:async';
import 'package:dio/dio.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/storage/secure_storage.dart';

// ──────────────────────────────
// AUTH INTERCEPTOR
// ──────────────────────────────

/// Handles token injection + refresh
///
/// Flow:
/// 1. Add Bearer token to every
///    request header
/// 2. On 401 response:
///    a. Pause all new requests
///    b. Try refresh token
///    c. If success: retry all
///       queued requests
///    d. If fail: force logout
///       clear all tokens
///       redirect to /login
class AuthInterceptor extends Interceptor {
  /// Whether refresh is in progress
  bool _isRefreshing = false;

  /// Queue of requests waiting
  /// for token refresh to complete
  final List<_PendingRequest> _queue = [];

  // ────────────────────────────
  // ON REQUEST
  // Inject Bearer token
  // ────────────────────────────

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    /// Skip token injection for
    /// public auth endpoints
    final isPublic = _isPublicEndpoint(options.path);

    if (!isPublic) {
      final token = await SecureStorage.getAccessToken();

      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    handler.next(options);
  }

  // ────────────────────────────
  // ON ERROR
  // Handle 401 → refresh flow
  // ────────────────────────────

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final is401 = err.response?.statusCode == 401;
    final isRefreshEndpoint =
        err.requestOptions.path.contains(ApiEndpoints.refresh);

    /// Not a 401 or is refresh call
    /// itself failing → pass through
    if (!is401 || isRefreshEndpoint) {
      handler.next(err);
      return;
    }

    /// 401 on normal request
    /// Queue it and try refresh
    if (_isRefreshing) {
      /// Refresh already in progress
      /// Add to queue
      final completer = Completer<Response>();
      _queue.add(
        _PendingRequest(
          options: err.requestOptions,
          completer: completer,
        ),
      );
      try {
        final res = await completer.future;
        handler.resolve(res);
      } catch (e) {
        handler.next(err);
      }
      return;
    }

    /// Start refresh
    _isRefreshing = true;

    try {
      final refreshToken = await SecureStorage.getRefreshToken();

      if (refreshToken == null) {
        /// No refresh token
        /// Force logout
        await SecureStorage.clearTokens();
        handler.next(err);
        return;
      }

      /// Call refresh endpoint
      /// Use a fresh Dio to avoid
      /// interceptor loop
      final freshDio = Dio(
        BaseOptions(
          baseUrl: err.requestOptions.baseUrl,
        ),
      );

      final refreshRes = await freshDio.post<Map<String, dynamic>>(
        ApiEndpoints.refresh,
        data: {
          'refreshToken': refreshToken,
        },
      );

      final newAccess = refreshRes.data?['accessToken'] as String?;
      final newRefresh = refreshRes.data?['refreshToken'] as String?;

      if (newAccess == null) {
        await SecureStorage.clearTokens();
        handler.next(err);
        return;
      }

      /// Save new tokens
      await SecureStorage.saveTokens(
        accessToken: newAccess,
        refreshToken: newRefresh ?? refreshToken,
      );

      /// Retry original request
      err.requestOptions.headers['Authorization'] = 'Bearer $newAccess';

      final retryRes = await freshDio.fetch(
        err.requestOptions,
      );

      /// Resolve all queued requests
      for (final pending in _queue) {
        try {
          pending.options.headers['Authorization'] = 'Bearer $newAccess';
          final qRes = await freshDio.fetch(
            pending.options,
          );
          pending.completer.complete(qRes);
        } catch (e) {
          pending.completer.completeError(e);
        }
      }
      _queue.clear();

      handler.resolve(retryRes);
    } catch (_) {
      /// Refresh failed
      /// Force logout everything
      await SecureStorage.clearTokens();

      /// Fail all queued requests
      for (final pending in _queue) {
        pending.completer.completeError(err);
      }
      _queue.clear();

      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  // ────────────────────────────
  // FORCE LOGOUT
  // Clear tokens + redirect
  // ────────────────────────────

  // ────────────────────────────
  // PUBLIC ENDPOINTS
  // No token needed
  // ────────────────────────────

  /// Returns true for endpoints
  /// that don't need auth token
  bool _isPublicEndpoint(String path) {
    const publicPaths = [
      '/auth/register',
      '/auth/login',
      '/auth/refresh',
      '/auth/forgot-password',
      '/auth/verify-reset-token',
      '/auth/reset-password',
      '/auth/resend-verification',
    ];
    return publicPaths.any(
      (p) => path.contains(p),
    );
  }
}

// ──────────────────────────────
// PENDING REQUEST MODEL
// Queue item for retry
// ──────────────────────────────

/// Holds a queued request
/// waiting for token refresh
class _PendingRequest {
  _PendingRequest({
    required this.options,
    required this.completer,
  });

  final RequestOptions options;
  final Completer<Response> completer;
}
