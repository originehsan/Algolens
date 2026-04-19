import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:algolens/core/local/isar_service.dart';
import 'package:algolens/core/local/isar_collections.dart';
import 'package:algolens/core/config/env_config.dart';

// ──────────────────────────────
// STREAM PROVIDER
// Reactive UI auto updates
// ──────────────────────────────

/// Reactive UserSettings stream
/// UI rebuilds when settings change
///
/// Usage in widget:
/// ref.watch(userSettingsProvider)
///   .when(
///     loading: () => ...,
///     error: (e, s) => ...,
///     data: (settings) => ...,
///   )
final userSettingsProvider = StreamProvider<UserSettings>((ref) {
  final isar = ref.watch(isarProvider);
  return isar.userSettings
      .watchObject(
        1,
        fireImmediately: true,
      )
      .map((s) => s ?? UserSettings());
});

// ──────────────────────────────
// SERVICE PROVIDER
// ──────────────────────────────

/// UserSettings service provider
/// Use ref.read() to call methods
///
/// Usage:
/// final service = ref.read(
///   userSettingsServiceProvider,
/// );
/// await service.setTtsEnabled(true);
final userSettingsServiceProvider = Provider<UserSettingsService>(
  (ref) {
    final isar = ref.watch(isarProvider);
    return UserSettingsService(isar);
  },
);

// ──────────────────────────────
// SERVICE CLASS
// All UserSettings CRUD
// ──────────────────────────────

/// UserSettings CRUD operations
///
/// Rules:
/// → Never access Isar directly
///   for settings outside this
/// → Always use this service
/// → Single source of truth
class UserSettingsService {
  UserSettingsService(this._isar);
  final Isar _isar;

  // ────────────────────────────
  // READ
  // ────────────────────────────

  /// Get current settings
  /// Creates defaults if first time
  Future<UserSettings> get() async {
    final existing = await _isar.userSettings.get(1);
    if (existing != null) {
      return existing;
    }

    /// First launch — save defaults
    final defaults = UserSettings();
    await _isar.writeTxn(() async {
      await _isar.userSettings.put(defaults);
    });
    return defaults;
  }

  // ────────────────────────────
  // INTERNAL UPDATE HELPER
  // ────────────────────────────

  /// Get current → apply change → save
  /// Used by all setter methods
  Future<void> _update(
    void Function(UserSettings s) change,
  ) async {
    final s = await get();
    change(s);
    s.id = 1;
    await _isar.writeTxn(() async {
      await _isar.userSettings.put(s);
    });
  }

  // ────────────────────────────
  // NOTIFICATION SETTINGS
  // ────────────────────────────

  /// Toggle contest popup alerts
  /// flutter_local_notifications
  /// FREE feature
  Future<void> setContestAlerts(
    bool enabled,
  ) =>
      _update(
        (s) => s.contestAlertsEnabled = enabled,
      );

  /// Toggle streak reminder
  /// Daily local notification
  /// FREE feature
  Future<void> setStreakReminder(
    bool enabled,
  ) =>
      _update(
        (s) => s.streakReminderEnabled = enabled,
      );

  /// Toggle upsolve reminder
  /// Weekly local notification
  /// FREE feature
  Future<void> setUpsolveReminder(
    bool enabled,
  ) =>
      _update(
        (s) => s.upsolveReminderEnabled = enabled,
      );

  /// Set reminder timing
  /// Minutes before contest (0-120)
  /// Clamped to valid range
  Future<void> setReminderMinutes(
    int minutes,
  ) async {
    final clamped = minutes.clamp(
      EnvConfig.minReminderMins,
      EnvConfig.maxReminderMins,
    );
    return _update(
      (s) => s.reminderMinutesBefore = clamped,
    );
  }

  // ────────────────────────────
  // TTS SETTINGS (FREE)
  // flutter_tts package
  // ────────────────────────────

  /// Toggle TTS voice reminder
  /// App must be open/foreground
  /// FREE feature
  Future<void> setTtsEnabled(
    bool enabled,
  ) =>
      _update(
        (s) => s.ttsEnabled = enabled,
      );

  /// Set TTS language
  /// Default: 'en-US'
  Future<void> setTtsLanguage(
    String language,
  ) =>
      _update(
        (s) => s.ttsLanguage = language,
      );

  /// Set TTS volume
  /// Range: 0.0 to 1.0
  Future<void> setTtsVolume(
    double volume,
  ) async {
    final clamped = volume.clamp(0.0, 1.0);
    return _update(
      (s) => s.ttsVolume = clamped,
    );
  }

  // ────────────────────────────
  // PREMIUM FEATURES 🔒
  // Locked until payment gateway
  // Show premium dialog on tap
  // DO NOT enable these now
  // ────────────────────────────

  /// SMS alerts via Twilio
  /// PREMIUM 🔒
  /// Only set true after payment
  Future<void> setSmsAlerts(
    bool enabled,
  ) =>
      _update(
        (s) => s.smsAlertsEnabled = enabled,
      );

  /// Voice call alerts via Twilio
  /// PREMIUM 🔒
  /// Only set true after payment
  Future<void> setVoiceCall(
    bool enabled,
  ) =>
      _update(
        (s) => s.voiceCallEnabled = enabled,
      );

  /// Phone verified status
  /// PREMIUM 🔒
  /// Set after /verification/verify-otp
  Future<void> setPhoneVerified({
    required bool verified,
    String? phoneNumber,
  }) =>
      _update((s) {
        s.isPhoneVerified = verified;
        s.phoneNumber = phoneNumber;
      });

  // ────────────────────────────
  // HOME WIDGET
  // home_widget + workmanager
  // ────────────────────────────

  /// Toggle home screen widget
  Future<void> setWidgetEnabled(
    bool enabled,
  ) =>
      _update(
        (s) => s.widgetEnabled = enabled,
      );

  // ────────────────────────────
  // NOTIFICATION PERMISSION
  // Snapchat style flow
  // ────────────────────────────

  /// Mark permission already asked
  /// Never show bottom sheet again
  Future<void> markPermissionAsked() => _update(
        (s) => s.notificationAsked = true,
      );

  /// Update banner shown time
  /// Banner reshows after 3 days
  Future<void> updateBannerShownTime() => _update(
        (s) => s.bannerLastShownAt = DateTime.now(),
      );

  /// Should show permission banner?
  ///
  /// Returns true if:
  /// → Already asked (no sheet)
  /// → Banner never shown OR
  /// → 3+ days since last shown
  Future<bool> shouldShowBanner() async {
    final s = await get();

    /// Not asked yet
    /// → Show bottom sheet instead
    if (!s.notificationAsked) {
      return false;
    }

    /// Banner never shown
    if (s.bannerLastShownAt == null) {
      return true;
    }

    /// Check 3 day timer
    final daysSince = DateTime.now().difference(s.bannerLastShownAt!).inDays;

    return daysSince >= EnvConfig.bannerReshowDays;
  }

  // ────────────────────────────
  // ONBOARDING
  // Show slides only once
  // ────────────────────────────

  /// Mark onboarding completed
  /// Never show again
  Future<void> completeOnboarding() => _update(
        (s) => s.onboardingCompleted = true,
      );

  /// Has user done onboarding?
  Future<bool> isOnboardingDone() async {
    final s = await get();
    return s.onboardingCompleted;
  }
}
