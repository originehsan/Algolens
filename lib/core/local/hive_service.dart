import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ──────────────────────────────
// BOX NAMES
// All Hive box name constants
// ──────────────────────────────

/// All Hive box name constants
///
/// Never hardcode box names
/// Always use these constants
abstract class HiveBoxes {
  HiveBoxes._();

  static const String userSettings = 'user_settings';
  static const String contestReminders = 'contest_reminders';
  static const String upsolveLocalState = 'upsolve_local_state';
  static const String dismissedContests = 'dismissed_contests';
  static const String cachedProfiles = 'cached_profiles';
  static const String cachedContests = 'cached_contests';
}

// ──────────────────────────────
// HIVE SERVICE
// ──────────────────────────────

/// Hive database service
///
/// Call HiveService.init()
/// once in main.dart before
/// runApp()
///
/// All boxes opened here
/// and kept open for app life
abstract class HiveService {
  HiveService._();

  // ────────────────────────────
  // INIT
  // Call once in main.dart
  // ────────────────────────────

  /// Initialize Hive + open
  /// all boxes
  ///
  /// Call before runApp():
  /// await HiveService.init();
  static Future<void> init() async {
    await Hive.initFlutter();
    await Future.wait([
      Hive.openBox<dynamic>(
        HiveBoxes.userSettings,
      ),
      Hive.openBox<dynamic>(
        HiveBoxes.contestReminders,
      ),
      Hive.openBox<dynamic>(
        HiveBoxes.upsolveLocalState,
      ),
      Hive.openBox<dynamic>(
        HiveBoxes.dismissedContests,
      ),
      Hive.openBox<dynamic>(
        HiveBoxes.cachedProfiles,
      ),
      Hive.openBox<dynamic>(
        HiveBoxes.cachedContests,
      ),
    ]);
  }

  // ────────────────────────────
  // BOX ACCESSORS
  // Get open box by name
  // ────────────────────────────

  static Box<dynamic> get userSettings => Hive.box<dynamic>(
        HiveBoxes.userSettings,
      );

  static Box<dynamic> get contestReminders => Hive.box<dynamic>(
        HiveBoxes.contestReminders,
      );

  static Box<dynamic> get upsolveLocalState => Hive.box<dynamic>(
        HiveBoxes.upsolveLocalState,
      );

  static Box<dynamic> get dismissedContests => Hive.box<dynamic>(
        HiveBoxes.dismissedContests,
      );

  static Box<dynamic> get cachedProfiles => Hive.box<dynamic>(
        HiveBoxes.cachedProfiles,
      );

  static Box<dynamic> get cachedContests => Hive.box<dynamic>(
        HiveBoxes.cachedContests,
      );

  // ────────────────────────────
  // CLEAR ON LOGOUT
  // Wipes user data only
  // Keeps userSettings intact
  // ────────────────────────────

  /// Clear all user data on logout
  ///
  /// Clears:
  /// → cachedProfiles
  /// → cachedContests
  /// → upsolveLocalState
  /// → contestReminders
  /// → dismissedContests
  ///
  /// Does NOT clear:
  /// → userSettings
  static Future<void> clearOnLogout() async {
    await Future.wait([
      cachedProfiles.clear(),
      cachedContests.clear(),
      upsolveLocalState.clear(),
      contestReminders.clear(),
      dismissedContests.clear(),
    ]);
  }

  // ────────────────────────────
  // CLEAR ALL
  // Full wipe — dev only
  // ────────────────────────────

  /// Wipe all boxes
  ///
  /// Use only for:
  /// → Debug reset
  /// → Account deletion
  static Future<void> clearAll() async {
    await Future.wait([
      userSettings.clear(),
      cachedProfiles.clear(),
      cachedContests.clear(),
      upsolveLocalState.clear(),
      contestReminders.clear(),
      dismissedContests.clear(),
    ]);
  }
}

// ──────────────────────────────
// HIVE PROVIDER
// Replaces isarProvider
// ──────────────────────────────

/// Marker provider to signal
/// Hive is initialized
///
/// Override not needed —
/// HiveService.init() called
/// in main.dart before runApp
/// All boxes already open
///
/// Used by services that need
/// to access boxes reactively
final hiveInitProvider = Provider<bool>((ref) => true);
