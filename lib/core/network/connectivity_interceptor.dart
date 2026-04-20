import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:algolens/core/errors/app_exceptions.dart';

// ──────────────────────────────
// CONNECTIVITY INTERCEPTOR
// ──────────────────────────────

/// Checks internet before every
/// Dio request
///
/// Flow:
/// 1. onRequest fires first
/// 2. Check ConnectivityResult
/// 3. If none → reject immediately
///    with ApiException.noInternet
/// 4. If connected → pass through
///
/// Why:
/// → Faster failure than timeout
/// → Clean error for offline banner
/// → No wasted network calls
class ConnectivityInterceptor extends Interceptor {
  // ────────────────────────────
  // ON REQUEST
  // Check before every call
  // ────────────────────────────

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final result = await Connectivity().checkConnectivity();

    /// No internet connection
    /// Reject before network call
    final hasInternet = result.any(
      (r) => r != ConnectivityResult.none,
    );

    if (!hasInternet) {
      /// Throw ApiException.noInternet
      /// DioClient._handleError will
      /// catch and surface this
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          error: const ApiException(
            message: 'No internet connection',
            type: ApiExceptionType.noInternet,
          ),
          message: 'No internet connection',
        ),
      );
      return;
    }

    /// Connected — pass through
    handler.next(options);
  }
}
