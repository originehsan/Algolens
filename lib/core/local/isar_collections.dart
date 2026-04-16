// ignore_for_file: invalid_annotation_target

import 'package:isar/isar.dart';

part 'isar_collections.g.dart';

// ═══════════════════════════════════════
// 1. USER SETTINGS
// Singleton — id always = 1
// App preferences only
// NO api data stored here
// NO cf handle here
//   (cf handle → flutter_secure_storage)
// ═══════════════════════════════════════
@collection
class UserSettings {
  // Singleton — always use id = 1
  // Never create multiple records
  Id id = 1;

  // ── Notification Preferences ──
  // Popup notifications (free)
  bool contestAlertsEnabled = true;
  bool streakReminderEnabled = true;
  bool upsolveReminderEnabled = false;

  // TTS voice reminder (free)
  // App must be open for this
  bool ttsVoiceEnabled = false;
  String ttsLanguage = 'en-US';
  double ttsVolume = 0.80;

  // Premium features 🔒
  // Locked until payment gateway added
  // DO NOT enable these yet
  // Just store the flag for future use
  bool smsAlertsEnabled = false; // Premium 🔒
  bool voiceCallEnabled = false; // Premium 🔒
  bool isPhoneVerified = false; // Premium 🔒
  String? phoneNumber; // Premium 🔒

  // ── Reminder Timing ──
  // How many minutes before contest
  // to fire local notification
  // Default 30 min
  // Range 0-120 min via slider
  int reminderMinutesBefore = 30;

  // ── Home Widget ──
  bool widgetEnabled = true;

  // ── Notification Permission ──
  // Snapchat style — not compulsory
  // Track if we already asked user
  bool notificationPermissionAsked = false;
  // When banner was last shown
  // Banner shows again after 3 days
  DateTime? bannerLastShownAt;

  // ── Onboarding ──
  // Show onboarding only once
  bool onboardingCompleted = false;
}

// ═══════════════════════════════════════
// 2. CONTEST REMINDER
// User's custom notification reminders
// Backend has NO reminder storage
// So we store locally in Isar
//
// CRUD:
// CREATE → user sets reminder via slider
// READ   → show active reminders list
// DELETE → user taps X on reminder card
// MAX 3 reminders per contest
// ═══════════════════════════════════════
@collection
class ContestReminder {
  Id id = Isar.autoIncrement;

  // Which contest this reminder is for
  // From CachedContest.contestId
  @Index()
  late int contestId;

  // Cached contest info for display
  // So we can show name without API call
  late String contestName;
  // Unix timestamp in seconds
  late int contestStartTimeSeconds;

  // How many minutes before contest
  // User sets via slider (0-120 min)
  // Or quick presets: 30, 60, 120
  late int minutesBefore;

  // flutter_local_notifications ID
  // Used to cancel this specific notification
  // Formula: contestId * 100 + minutesBefore
  // Example: contest 1900, 30 min → 190030
  late int notificationId;

  // Is this reminder still active?
  // false = cancelled/fired
  bool isActive = true;

  // When was this reminder created
  late DateTime scheduledAt;

  // When will this notification fire
  // Computed from start time - minutesBefore
  DateTime get firesAt => DateTime.fromMillisecondsSinceEpoch(
        contestStartTimeSeconds * 1000,
      ).subtract(
        Duration(minutes: minutesBefore),
      );

  // Has this reminder already fired?
  bool get hasFired => DateTime.now().isAfter(firesAt);
}

// ═══════════════════════════════════════
// 3. UPSOLVE LOCAL STATE
// Tracks done/undone per problem
// Backend has NO done/undone endpoint
// So we store locally in Isar
//
// CRUD:
// CREATE → auto when upsolve loads
// READ   → show pending/solved tabs
// UPDATE → user taps Done button
// No DELETE — just toggle isCompleted
// ═══════════════════════════════════════
@collection
class UpsolveLocalState {
  Id id = Isar.autoIncrement;

  // Unique key per problem
  // Format: "${contestId}_${index}"
  // Example: "1865_D"
  // This never changes for same problem
  @Index(unique: true)
  late String problemKey;

  // Problem info (from API response)
  // Cached here so we don't need API
  // when user marks done offline
  late int contestId;
  late String problemIndex; // A, B, C, D, E, F
  late String problemName;
  late int problemRating;
  late String bestVerdict;
  // WA = WRONG_ANSWER
  // TLE = TIME_LIMIT_EXCEEDED
  // MLE = MEMORY_LIMIT_EXCEEDED
  // RE = RUNTIME_ERROR
  late String problemUrl;
  // Direct CF link

  // Tags stored as JSON string
  // Decode with jsonDecode when needed
  // Example: '["binary search","greedy"]'
  late String tagsJson;

  // Is this problem a weak topic?
  // true = matches user's weak topics
  // Used for sorting — weak topics first
  bool isWeakTopic = false;

  // ── User Action ──
  bool isCompleted = false;
  DateTime? completedAt;
  // Set when user taps Done button
}

// ═══════════════════════════════════════
// 4. DISMISSED CONTEST
// When user swipes away contest card
// on home screen Hotstar swipe stack
// Backend has NO dismiss endpoint
// So we store locally in Isar
//
// CRUD:
// CREATE → user swipes card away
// READ   → filter out dismissed cards
// No DELETE — persists until logout
// ═══════════════════════════════════════
@collection
class DismissedContest {
  Id id = Isar.autoIncrement;

  // CF contest ID
  @Index(unique: true)
  late int contestId;

  // When user dismissed this card
  late DateTime dismissedAt;

  // Dismissed cards are filtered out
  // when loading home swipe stack
  // They come back if user pulls to refresh
  // AND contest is still upcoming
}

// ═══════════════════════════════════════
// 5. CACHED PROFILE
// Offline support for user profiles
// Backend CAN cache (Redis 5 min)
// BUT Flutter needs offline availability
// When network fails, show cached profile
//
// Cache Strategy:
// • Update after EVERY profile fetch
// • Use if network offline
// • Treat as stale after 5 minutes
// ═══════════════════════════════════════
@collection
class CachedProfile {
  Id id = Isar.autoIncrement;

  // CF handle — unique index for lookup
  @Index(unique: true)
  late String handle;

  // Profile data from CF API
  late int rating;
  late int maxRating;
  late String rank;
  late int problemsSolved;
  late int contestsParticipated;
  late int streakDays;
  late String lastActiveDate;
  late String avatar;

  // Cache metadata
  late DateTime cachedAt;

  // Check if cache is still valid (5 min)
  bool get isValid {
    final diff = DateTime.now().difference(cachedAt);
    return diff.inMinutes < 5;
  }

  // For offline mode: always return true
  // Even if stale, show it offline
  bool get isValidOffline => true;
}

// ═══════════════════════════════════════
// 6. CACHED CONTEST
// Offline support for contest listings
// Backend CAN cache (Redis 1 hour)
// BUT Flutter needs offline availability
// When network fails, show cached contests
//
// Cache Strategy:
// • Update after EVERY contest fetch
// • Use if network offline
// • Treat as stale after 1 hour
// • Mark isDismissed doesn't clear cache
// ═══════════════════════════════════════
@collection
class CachedContest {
  Id id = Isar.autoIncrement;

  // Unique CF contest ID
  @Index(unique: true)
  late int contestId;

  // Contest data from CF API
  late String name;
  late String type; // CF, ICPC, IOI etc
  late int durationSeconds;
  late int startTimeSeconds; // Unix timestamp
  late int relativeTimeSeconds;
  // negative = not started yet
  // positive = started/finished

  // Cache metadata
  late DateTime cachedAt;

  // Check if cache valid (1 hour)
  bool get isValid {
    final diff = DateTime.now().difference(cachedAt);
    return diff.inHours < 1;
  }

  // For offline mode: always return true
  // Even if stale, show it offline
  bool get isValidOffline => true;

  // Computed helpers
  bool get isUpcoming => relativeTimeSeconds < 0;

  bool get isLive =>
      relativeTimeSeconds >= 0 && relativeTimeSeconds < durationSeconds;

  DateTime get startDateTime => DateTime.fromMillisecondsSinceEpoch(
        startTimeSeconds * 1000,
      );

  String get durationFormatted {
    final h = durationSeconds ~/ 3600;
    final m = (durationSeconds % 3600) ~/ 60;
    if (m == 0) return '${h}h';
    return '${h}h ${m}m';
  }
}
