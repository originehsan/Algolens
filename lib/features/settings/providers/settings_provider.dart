
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:algolens/core/local/hive_service.dart';

// ─────────────────────────────────
// APP VERSION PROVIDER
// ─────────────────────────────────

/// Reads app version from device package info.
/// Returns "1.0.0 (1)" — version + build number.
/// Auto-updates when app is updated via store.
final appVersionProvider = FutureProvider<String>((ref) async {
  final info = await PackageInfo.fromPlatform();
  return '${info.version} (${info.buildNumber})';
});

// ─────────────────────────────────
// CLEAR CACHE PROVIDER
// ─────────────────────────────────

/// Clears only API response caches from Hive.
/// Safe to call anytime — does NOT affect:
/// → User settings (notification prefs, TTS config)
/// → Contest reminders (scheduled notifications)
/// → Upsolve progress (done/undone state)
/// → Auth tokens or CF handle
///
/// Use when user wants to force-refresh
/// stale profile or contest data.
final clearCacheProvider =
    StateNotifierProvider<ClearCacheNotifier, AsyncValue<void>>(
  (ref) => ClearCacheNotifier(),
);

class ClearCacheNotifier extends StateNotifier<AsyncValue<void>> {
  ClearCacheNotifier() : super(const AsyncValue.data(null));

  Future<void> clear() async {
    state = const AsyncValue.loading();
    try {
      // Wipe cached CF profiles (5 min TTL data)
      await HiveService.cachedProfiles.clear();

      // Wipe cached contest lists (1 hr TTL data)
      await HiveService.cachedContests.clear();

      // Reset to idle — UI can show "Cache cleared" snackbar
      state = const AsyncValue.data(null);
    } catch (e, s) {
      // Propagate error — UI shows failure message
      state = AsyncValue.error(e, s);
    }
  }

  /// True while clearing is in progress.
  /// Use to disable button and show spinner in UI.
  bool get isClearing => state is AsyncLoading;
}

// ─────────────────────────────────
// NOTE: logoutProvider is in
// auth_provider.dart (P31).
// Import directly in settings
// screen — no re-export needed.
// ─────────────────────────────────