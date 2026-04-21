import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:algolens/core/local/hive_service.dart';
import 'package:algolens/core/config/env_config.dart';

// ──────────────────────────────
// USER SETTINGS MODEL
// Plain Dart — NO annotations
// NO code generation needed
// ──────────────────────────────

class UserSettings {
  UserSettings({
    this.contestAlertsEnabled = true,
    this.streakReminderEnabled = true,
    this.upsolveReminderEnabled = true,
    this.reminderMinutesBefore = 30,
    this.ttsEnabled = false,
    this.ttsLanguage = 'en-US',
    this.ttsVolume = 0.8,
    this.smsAlertsEnabled = false,
    this.voiceCallEnabled = false,
    this.isPhoneVerified = false,
    this.phoneNumber,
    this.widgetEnabled = false,
    this.onboardingCompleted = false,
    this.notificationAsked = false,
    this.bannerLastShownAt,
  });

  bool contestAlertsEnabled;
  bool streakReminderEnabled;
  bool upsolveReminderEnabled;
  int reminderMinutesBefore;
  bool ttsEnabled;
  String ttsLanguage;
  double ttsVolume;
  bool smsAlertsEnabled;
  bool voiceCallEnabled;
  bool isPhoneVerified;
  String? phoneNumber;
  bool widgetEnabled;
  bool onboardingCompleted;
  bool notificationAsked;
  DateTime? bannerLastShownAt;
}

// ──────────────────────────────
// HIVE KEYS
// ──────────────────────────────

abstract class _K {
  static const ca = 'ca';
  static const sr = 'sr';
  static const ur = 'ur';
  static const rm = 'rm';
  static const te = 'te';
  static const tl = 'tl';
  static const tv = 'tv';
  static const sa = 'sa';
  static const vc = 'vc';
  static const pv = 'pv';
  static const pn = 'pn';
  static const we = 'we';
  static const oc = 'oc';
  static const na = 'na';
  static const bs = 'bs';
}

// ──────────────────────────────
// PROVIDERS
// ──────────────────────────────

final userSettingsProvider = StreamProvider<UserSettings>(
  (ref) {
    final svc = ref.watch(
      userSettingsServiceProvider,
    );
    return svc.stream;
  },
);

final userSettingsServiceProvider = Provider<UserSettingsService>(
  (ref) => UserSettingsService(),
);

// ──────────────────────────────
// SERVICE
// ──────────────────────────────

class UserSettingsService {
  UserSettingsService() {
    _ctrl = StreamController<UserSettings>.broadcast();
    _emit();
    _box.listenable().addListener(_emit);
  }

  late final StreamController<UserSettings> _ctrl;

  Box<dynamic> get _box => HiveService.userSettings;

  Stream<UserSettings> get stream => _ctrl.stream;

  void _emit() {
    if (!_ctrl.isClosed) {
      _ctrl.add(_read());
    }
  }

  void dispose() {
    _box.listenable().removeListener(_emit);
    _ctrl.close();
  }

  // ────────────────────────────
  // READ
  // ────────────────────────────

  UserSettings _read() => UserSettings(
        contestAlertsEnabled: _b<bool>(_K.ca, true),
        streakReminderEnabled: _b<bool>(_K.sr, true),
        upsolveReminderEnabled: _b<bool>(_K.ur, true),
        reminderMinutesBefore: _b<int>(_K.rm, 30),
        ttsEnabled: _b<bool>(_K.te, false),
        ttsLanguage: _b<String>(_K.tl, 'en-US'),
        ttsVolume: (_box.get(
          _K.tv,
          defaultValue: 0.8,
        ) as num)
            .toDouble(),
        smsAlertsEnabled: _b<bool>(_K.sa, false),
        voiceCallEnabled: _b<bool>(_K.vc, false),
        isPhoneVerified: _b<bool>(_K.pv, false),
        phoneNumber: _box.get(_K.pn) as String?,
        widgetEnabled: _b<bool>(_K.we, false),
        onboardingCompleted: _b<bool>(_K.oc, false),
        notificationAsked: _b<bool>(_K.na, false),
        bannerLastShownAt: _box.get(_K.bs) != null
            ? DateTime.tryParse(
                _box.get(_K.bs) as String,
              )
            : null,
      );

  T _b<T>(String key, T def) =>
      (_box.get(
        key,
        defaultValue: def,
      ) as T?) ??
      def;

  UserSettings get() => _read();

  // ────────────────────────────
  // SETTERS
  // ────────────────────────────

  Future<void> setContestAlerts(bool v) => _box.put(_K.ca, v);

  Future<void> setStreakReminder(bool v) => _box.put(_K.sr, v);

  Future<void> setUpsolveReminder(bool v) => _box.put(_K.ur, v);

  Future<void> setReminderMinutes(int minutes) => _box.put(
        _K.rm,
        minutes.clamp(
          EnvConfig.minReminderMins,
          EnvConfig.maxReminderMins,
        ),
      );

  Future<void> setTtsEnabled(bool v) => _box.put(_K.te, v);

  Future<void> setTtsLanguage(String v) => _box.put(_K.tl, v);

  Future<void> setTtsVolume(double v) => _box.put(
        _K.tv,
        v.clamp(0.0, 1.0),
      );

  Future<void> setSmsAlerts(bool v) => _box.put(_K.sa, v);

  Future<void> setVoiceCall(bool v) => _box.put(_K.vc, v);

  Future<void> setPhoneVerified({
    required bool verified,
    String? phoneNumber,
  }) async {
    await _box.put(_K.pv, verified);
    if (phoneNumber != null) {
      await _box.put(
        _K.pn,
        phoneNumber,
      );
    }
  }

  Future<void> setWidgetEnabled(bool v) => _box.put(_K.we, v);

  Future<void> markPermissionAsked() => _box.put(_K.na, true);

  Future<void> updateBannerShownTime() => _box.put(
        _K.bs,
        DateTime.now().toIso8601String(),
      );

  Future<bool> shouldShowBanner() async {
    final s = _read();
    if (!s.notificationAsked) {
      return false;
    }
    if (s.bannerLastShownAt == null) {
      return true;
    }
    return DateTime.now().difference(s.bannerLastShownAt!).inDays >=
        EnvConfig.bannerReshowDays;
  }

  Future<void> completeOnboarding() => _box.put(_K.oc, true);

  Future<bool> isOnboardingDone() async => _b<bool>(_K.oc, false);
}
