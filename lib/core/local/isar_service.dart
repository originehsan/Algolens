import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:algolens/core/local/isar_collections.dart';

// ──────────────────────────────
// ISAR PROVIDER
// App-wide singleton
// ──────────────────────────────

/// Global Isar instance provider
///
/// Overridden in main.dart with
/// actual initialized instance:
///
/// ProviderScope(
///   overrides: [
///     isarProvider.overrideWithValue(
///       await IsarService.init(),
///     ),
///   ],
/// )
final isarProvider = Provider<Isar>(
  (ref) => throw UnimplementedError(
    'isarProvider not initialized.\n'
    'Override in ProviderScope.',
  ),
);

// ──────────────────────────────
// ISAR SERVICE
// ──────────────────────────────

/// Isar database service
///
/// Rules:
/// → Never instantiate directly
/// → Always use IsarService.init()
/// → One instance for entire app
/// → Injected via isarProvider
class IsarService {
  IsarService._(this._isar);
  final Isar _isar;

  /// Expose raw Isar instance
  /// for providers that need it
  Isar get instance => _isar;

  // ────────────────────────────
  // INIT
  // Call once in main.dart
  // ────────────────────────────

  /// Initialize Isar with all
  /// collections
  ///
  /// Call in main.dart before
  /// runApp():
  ///
  /// final isar =
  ///   await IsarService.init();
  static Future<Isar> init() async {
    final dir = await getApplicationDocumentsDirectory();

    /// Open with ALL collections
    /// Add new collections here
    final isar = await Isar.open(
      [
        UserSettingsSchema,
        ContestReminderSchema,
        UpsolveLocalStateSchema,
        DismissedContestSchema,
        CachedProfileSchema,
        CachedContestSchema,
      ],
      directory: dir.path,
      name: 'algolens_db',
    );

    return isar;
  }

  // ────────────────────────────
  // CLEAR ON LOGOUT
  // Wipes user-specific data only
  // Keeps app settings intact
  // ────────────────────────────

  /// Clear all user data on logout
  ///
  /// Clears:
  /// → CachedProfile (user data)
  /// → CachedContest (stale cache)
  /// → UpsolveLocalState (progress)
  /// → ContestReminder (reminders)
  /// → DismissedContest (dismissed)
  ///
  /// Does NOT clear:
  /// → UserSettings (kept across
  ///   logins for convenience)
  static Future<void> clearOnLogout(
    Isar isar,
  ) async {
    await isar.writeTxn(() async {
      await isar.cachedProfiles.clear();
      await isar.cachedContests.clear();
      await isar.upsolveLocalStates.clear();
      await isar.contestReminders.clear();
      await isar.dismissedContests.clear();
    });
  }

  // ────────────────────────────
  // CLEAR ALL
  // Full wipe — dev/debug only
  // ────────────────────────────

  /// Wipe entire database
  ///
  /// Clears ALL collections
  /// including UserSettings
  ///
  /// Use only for:
  /// → Debug reset
  /// → Account deletion flow
  /// → Fresh install simulation
  static Future<void> clearAll(
    Isar isar,
  ) async {
    await isar.writeTxn(() async {
      await isar.userSettings.clear();
      await isar.cachedProfiles.clear();
      await isar.cachedContests.clear();
      await isar.upsolveLocalStates.clear();
      await isar.contestReminders.clear();
      await isar.dismissedContests.clear();
    });
  }
}
