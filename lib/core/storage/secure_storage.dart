import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ──────────────────────────────
// STORAGE KEYS
// Single source of truth
// Never hardcode keys elsewhere
// Always use StorageKeys.xxx
// ──────────────────────────────

class StorageKeys {
  StorageKeys._();

  /// JWT access token
  /// Expires in 1 hour
  /// Auto-refreshed by interceptor
  static const String accessToken = 'access_token';

  /// JWT refresh token
  /// Expires in 7 days
  /// Used to get new access token
  static const String refreshToken = 'refresh_token';

  /// Codeforces handle
  /// Set after setup screen
  /// NOT from API response
  /// null = show setup screen
  static const String cfHandle = 'cf_handle';

  /// Device ID for X-Device-Id header
  /// Generated once on first launch
  /// Never changes
  static const String deviceId = 'device_id';
}

// ──────────────────────────────
// SECURE STORAGE PROVIDER
// ──────────────────────────────

/// SecureStorage provider
/// Used by auth_interceptor
/// and auth screens
///
/// Usage:
/// final storage = ref.read(
///   secureStorageProvider,
/// );
final secureStorageProvider = Provider<SecureStorage>((ref) {
  return SecureStorage();
});

// ──────────────────────────────
// SECURE STORAGE SERVICE
// All token + handle operations
// ──────────────────────────────

/// Manages all secure storage ops
///
/// Rules:
/// → Never access _storage directly
///   outside this class
/// → Always use this service
/// → Single source of truth
class SecureStorage {
  /// Flutter secure storage instance
  /// Android: EncryptedSharedPrefs
  /// iOS: Keychain
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  // ────────────────────────────
  // TOKEN OPERATIONS
  // ────────────────────────────

  /// Save both tokens after login
  /// or after token refresh
  ///
  /// ALWAYS save both together
  /// Both tokens rotate per API docs
  ///
  /// Called after:
  /// → POST /auth/login success
  /// → POST /auth/refresh success
  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      _storage.write(
        key: StorageKeys.accessToken,
        value: accessToken,
      ),
      _storage.write(
        key: StorageKeys.refreshToken,
        value: refreshToken,
      ),
    ]);
  }

  /// Get access token
  /// Returns null if not logged in
  static Future<String?> getAccessToken() async => _storage.read(
        key: StorageKeys.accessToken,
      );

  /// Get refresh token
  /// Returns null if not logged in
  static Future<String?> getRefreshToken() async => _storage.read(
        key: StorageKeys.refreshToken,
      );

  /// Is user logged in?
  /// Checks if access token exists
  /// Does NOT validate expiry
  static Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  /// Clear tokens on logout
  ///
  /// Keeps: cf_handle, device_id
  /// Removes: access_token,
  ///          refresh_token
  ///
  /// Called after:
  /// → POST /auth/logout
  /// → Refresh token expired
  static Future<void> clearTokens() async {
    await Future.wait([
      _storage.delete(
        key: StorageKeys.accessToken,
      ),
      _storage.delete(
        key: StorageKeys.refreshToken,
      ),
    ]);
  }

  /// Clear everything on logout all
  ///
  /// Keeps: device_id only
  /// Removes: access_token,
  ///          refresh_token,
  ///          cf_handle
  ///
  /// Called after:
  /// → POST /auth/logout-all
  static Future<void> clearAll() async {
    await Future.wait([
      _storage.delete(
        key: StorageKeys.accessToken,
      ),
      _storage.delete(
        key: StorageKeys.refreshToken,
      ),
      _storage.delete(
        key: StorageKeys.cfHandle,
      ),
    ]);
  }

  // ────────────────────────────
  // CF HANDLE OPERATIONS
  // ────────────────────────────

  /// Save CF handle
  ///
  /// Called after:
  /// → CF handle setup screen
  /// → User verifies handle
  ///
  /// NOT called from API response
  /// API does not return cfHandle
  static Future<void> saveCfHandle(
    String handle,
  ) async =>
      _storage.write(
        key: StorageKeys.cfHandle,
        value: handle,
      );

  /// Get CF handle
  ///
  /// Returns null if not set yet
  /// null → show /cf-handle-setup
  /// found → go to /home
  static Future<String?> getCfHandle() async => _storage.read(
        key: StorageKeys.cfHandle,
      );

  /// Is CF handle linked?
  static Future<bool> isCfHandleLinked() async {
    final handle = await getCfHandle();
    return handle != null && handle.isNotEmpty;
  }

  /// Clear CF handle only
  ///
  /// Called when:
  /// → User changes CF handle
  ///   in settings
  static Future<void> clearCfHandle() async => _storage.delete(
        key: StorageKeys.cfHandle,
      );

  // ────────────────────────────
  // DEVICE ID OPERATIONS
  // ────────────────────────────

  /// Get or generate device ID
  ///
  /// Generated ONCE on first launch
  /// Used in X-Device-Id header
  /// Sent with every login request
  static Future<String> getDeviceId() async {
    final existing = await _storage.read(key: StorageKeys.deviceId);

    if (existing != null && existing.isNotEmpty) {
      return existing;
    }

    /// Generate new device ID
    final newId = 'algolens_device_'
        '${DateTime.now().millisecondsSinceEpoch}';

    await _storage.write(
      key: StorageKeys.deviceId,
      value: newId,
    );

    return newId;
  }

  // ────────────────────────────
  // DEBUG HELPER
  // ────────────────────────────

  /// Read all stored keys
  /// Use for debugging only
  static Future<Map<String, String>> readAll() async => _storage.readAll();

  /// Get CF handle (backward compatibility)
  /// Alias for getCfHandle()
  static Future<String?> getHandle() async => getCfHandle();

  /// Save CF handle (backward compatibility)
  /// Alias for saveCfHandle()
  static Future<void> saveHandle(String handle) async => saveCfHandle(handle);

  /// Save access token (backward compatibility)
  static Future<void> saveAccessToken(String token) async => saveTokens(
        accessToken: token,
        refreshToken: (await getRefreshToken()) ?? '',
      );

  /// Save refresh token (backward compatibility)
  static Future<void> saveRefreshToken(String token) async => saveTokens(
        accessToken: (await getAccessToken()) ?? '',
        refreshToken: token,
      );
}
