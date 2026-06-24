import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// ──────────────────────────────
// UI PROVIDERS
// Pure UI state — no business logic
// ──────────────────────────────

// ────────────────────────────
// CONNECTIVITY
// Network state stream
// ────────────────────────────

/// Stream of connectivity results
///
/// Emits List<ConnectivityResult>
/// Watch to detect internet changes
/// Used by OfflineBanner
final connectivityStreamProvider = StreamProvider<List<ConnectivityResult>>(
  (ref) {
    return Connectivity().onConnectivityChanged;
  },
);

// ────────────────────────────
// OFFLINE BANNER
// Shows when no internet
// ────────────────────────────

/// Whether offline banner
/// is currently visible
final offlineBannerVisibleProvider = StateProvider<bool>((ref) => false);

// ────────────────────────────
// NOTIFICATION PERMISSION
// Snapchat style flow
// ────────────────────────────

/// Current notification permission status
///
/// Used by:
/// → Home screen banner
/// → Settings screen
/// → Permission bottom sheet
///
/// Refreshed after user grants/denies
final notifPermissionStatusProvider = FutureProvider(
  (ref) async {
    return await Permission.notification.status;
  },
);

// ────────────────────────────
// FIRST LAUNCH
// Show onboarding once only
// ────────────────────────────

/// Whether this is the user's first app launch
///
/// Read from UserSettings via Hive on app start
///
/// true  = show onboarding
/// false = skip onboarding
///
/// Set false after onboarding completes via
/// UserSettingsService.completeOnboarding()
final isFirstLaunchProvider = StateProvider<bool>((ref) => true);