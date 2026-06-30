library magnus.core.constants.app_constants;

abstract class AppConstants {
  AppConstants._();

  // ── Reminder intervals (minutes before contest) ──
  static const List<int> reminderIntervalMinutes = [30, 60, 120];

  // ── Urgency thresholds (minutes remaining) ───────
  static const int urgencyRedMinutes   = 60;    // < 1hr  → danger
  static const int urgencyAmberMinutes = 1440;  // < 24hr → warning

  // ── Cache TTL (seconds) ───────────────────────────
  static const int profileCacheTtl    = 300;    // 5 min
  static const int contestCacheTtl    = 3600;   // 1 hr
  static const int analysisCacheTtl   = 3600;   // 1 hr
  static const int friendsCacheTtl    = 3600;   // 1 hr
  static const int weakTopicsCacheTtl = 7200;   // 2 hr

  // ── Pagination ────────────────────────────────────
  static const int contestPageSize    = 20;
  static const int homeCarouselMax    = 5;
  static const int homeFriendPulseMax = 3;

  // ── Keep-alive timer (seconds) ───────────────────
  static const int keepAliveDuration  = 300;    // 5 min

  // ── Weak topic threshold ─────────────────────────
  static const double weakTopicAcThreshold = 40.0; // below 40% = weak

  // ── Notification ID formula ──────────────────────
  // notifId = contestId * 100 + minutesBefore
  static const int notifIdMultiplier  = 100;

  // ── Urgency bar window ────────────────────────────
  static const int urgencyWindowDays  = 7;
  static const double screenHorizontalPaddingValue = 16.0;
}