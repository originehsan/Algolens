import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

// ──────────────────────────────
// UI PROVIDERS
// Pure UI state — no business logic
// ──────────────────────────────

// ────────────────────────────
// BOTTOM NAV
// Tracks active tab index
// ────────────────────────────

/// Active bottom nav tab index
///
/// 0 = Home
/// 1 = Contests
/// 2 = Practice
/// 3 = Friends
///
/// Usage:
/// final idx = ref.watch(
///   bottomNavIndexProvider,
/// );
/// ref.read(
///   bottomNavIndexProvider
///     .notifier,
/// ).state = 1;
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

// ────────────────────────────
// OFFLINE BANNER
// Shows when no internet
// ────────────────────────────

/// Whether offline banner
/// is currently visible
///
/// Set true when connectivity
/// lost, false when restored
///
/// Usage:
/// ref.read(
///   offlineBannerVisibleProvider
///     .notifier,
/// ).state = true;
final offlineBannerVisibleProvider = StateProvider<bool>((ref) => false);

// ────────────────────────────
// NOTIFICATION PERMISSION
// Snapchat style flow
// ────────────────────────────

/// Current notification
/// permission status
///
/// Used by:
/// → Home screen banner
/// → Settings screen
/// → Permission bottom sheet
///
/// Refreshed after user
/// grants/denies permission
final notifPermissionStatusProvider = FutureProvider(
  (ref) async {
    return await Permission.notification.status;
  },
);

// ────────────────────────────
// FIRST LAUNCH
// Show onboarding once only
// ────────────────────────────

/// Whether this is the
/// user's first app launch
///
/// Read from UserSettings
/// via Isar on app start
///
/// true  = show onboarding
/// false = skip onboarding
///
/// Set false after onboarding
/// completes via
/// UserSettingsService
///   .completeOnboarding()
final isFirstLaunchProvider = StateProvider<bool>((ref) => true);
