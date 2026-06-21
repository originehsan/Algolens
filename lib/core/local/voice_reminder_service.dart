import 'dart:convert';
import 'package:algolens/core/local/hive_service.dart';
import 'package:algolens/core/local/tts_service.dart';

/// Singleton voice reminder service — static methods only.
/// Works in foreground only — background reminders use NotificationService.
/// TtsService.speak() handles the ttsEnabled check internally.
class VoiceReminderService {
  VoiceReminderService._();

  /// Reads all contest reminders from Hive and speaks any due within 5 minutes.
  /// Call this on app resume/foreground to catch imminent contests.
  static Future<void> checkAndSpeak() async {
    // Early exit if TTS is disabled — avoids unnecessary Hive reads
    final enabled =
        HiveService.userSettings.get('te') as bool? ?? false;
    if (!enabled) return;

    final box = HiveService.contestReminders;
    final now = DateTime.now();

    for (final key in box.keys) {
      try {
        final raw = box.get(key) as String?;
        if (raw == null) continue;

        final map = jsonDecode(raw) as Map<String, dynamic>;

        // Skip reminders the user manually disabled
        final isActive = (map['isActive'] as bool?) ?? true;
        if (!isActive) continue;

        final scheduledAt = DateTime.tryParse(
          (map['scheduledAt'] as String?) ?? '',
        );
        if (scheduledAt == null) continue;

        final diff = scheduledAt.difference(now);

        // Only speak if reminder is due within the next 5 minutes
        if (diff.isNegative || diff.inMinutes > 5) continue;

        final contestName = (map['contestName'] as String?) ?? '';
        final minutesBefore = (map['minutesBefore'] as int?) ?? 0;

        await TtsService.speakContestReminder(
          contestName: contestName,
          minutesBefore: minutesBefore,
        );

        // Brief pause between consecutive reminders to avoid overlap
        await Future.delayed(const Duration(milliseconds: 500));
      } catch (_) {
        // Skip corrupted Hive entries silently
      }
    }
  }

  /// Speaks any custom text via TtsService.
  /// TtsService handles the enabled check automatically.
  static Future<void> speak(String text) async {
    await TtsService.speak(text);
  }

  /// Speaks a daily streak reminder with streak-aware messaging.
  static Future<void> speakStreakReminder(int streakDays) async {
    final message = streakDays > 0
        ? 'Your AlgoLens streak is $streakDays days. Keep it going!'
        : 'Start your AlgoLens streak today! Open the app and solve a problem.';

    await TtsService.speak(message);
  }

  /// Speaks a weekly upsolve nudge based on how many problems are pending.
  static Future<void> speakUpsolveReminder(int pendingCount) async {
    final message = pendingCount > 0
        ? 'You have $pendingCount problems to upsolve. Open AlgoLens to practice!'
        : 'Great job! No pending upsolves. Keep solving!';

    await TtsService.speak(message);
  }

  /// Stops any currently playing TTS speech.
  static Future<void> stop() async {
    await TtsService.stop();
  }
}