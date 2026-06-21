import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:algolens/core/local/hive_service.dart';

// Singleton — static methods only
// Handles all local push notifications
// init() must be called in main() before runApp()
class NotificationService {
  NotificationService._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static bool _initialized = false;

  // ─────────────────────────────────
  // INIT
  // Call once in main() before runApp()
  // Sets up Android + iOS channels
  // ─────────────────────────────────

  static Future<void> init() async {
    // Guard against duplicate initialization
    if (_initialized) return;

    // Required for zonedSchedule to work correctly
    tz.initializeTimeZones();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    // Request permissions explicitly later via requestPermission()
    const ios = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const settings = InitializationSettings(android: android, iOS: ios);

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    _initialized = true;
  }

  // ─────────────────────────────────
  // NOTIFICATION TAP HANDLER
  // Called when user taps a notification
  // Router redirect guard handles navigation on app open
  // ─────────────────────────────────

  static void _onNotificationTap(NotificationResponse response) {
    // Navigation handled by app_router redirect on open
  }

  // ─────────────────────────────────
  // REQUEST PERMISSION
  // Must be called explicitly — not on init
  // Handles Android 13+ and iOS separately
  // ─────────────────────────────────

  static Future<bool> requestPermission() async {
    final android = _plugin.resolvePlatformSpecificImplementation
        <AndroidFlutterLocalNotificationsPlugin>();
    final ios = _plugin.resolvePlatformSpecificImplementation
        <IOSFlutterLocalNotificationsPlugin>();

    bool granted = false;

    if (android != null) {
      final result = await android.requestNotificationsPermission();
      granted = result ?? false;
    }

    if (ios != null) {
      final result = await ios.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      granted = result ?? false;
    }

    return granted;
  }

  // ─────────────────────────────────
  // CHECK PERMISSION STATUS
  // Returns true if notifications are enabled
  // iOS defaults to true — checked at OS level
  // ─────────────────────────────────

  static Future<bool> isPermissionGranted() async {
    final android = _plugin.resolvePlatformSpecificImplementation
        <AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      return await android.areNotificationsEnabled() ?? false;
    }
    // iOS permission checked via system settings
    return true;
  }

  // ─────────────────────────────────
  // SCHEDULE CONTEST REMINDER
  // Schedules a local notification at scheduledAt time
  // Silently skips if scheduledAt is already in the past
  // notifId = contestId * 100 + minutesBefore
  // ─────────────────────────────────

  static Future<void> scheduleContestReminder({
    required int notificationId,
    required String contestName,
    required int minutesBefore,
    required DateTime scheduledAt,
  }) async {
    // Skip stale reminders — avoids firing on app restart
    if (scheduledAt.isBefore(DateTime.now())) return;

    final tzScheduledAt = tz.TZDateTime.from(scheduledAt, tz.local);

    const androidDetails = AndroidNotificationDetails(
      'contest_reminders',
      'Contest Reminders',
      channelDescription: 'Reminders for upcoming CF contests',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      color:  Color(0xFF00D4FF), // AlgoLens cyan
      enableVibration: true,
      playSound: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Title changes based on how far away the contest is
    final title = minutesBefore == 0
        ? '$contestName is starting!'
        : '$contestName in $minutesBefore min';

    final body = minutesBefore == 0
        ? 'The contest has started. Open AlgoLens to join!'
        : 'Contest starts in $minutesBefore minutes. Get ready!';

    await _plugin.zonedSchedule(
      notificationId,
      title,
      body,
      tzScheduledAt,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // ─────────────────────────────────
  // CANCEL REMINDER
  // Cancel a single notification by ID
  // ─────────────────────────────────

  static Future<void> cancelReminder(int notificationId) async {
    await _plugin.cancel(notificationId);
  }

  // ─────────────────────────────────
  // CANCEL ALL REMINDERS
  // Wipes all scheduled notifications
  // Used on logout or full reset
  // ─────────────────────────────────

  static Future<void> cancelAllReminders() async {
    await _plugin.cancelAll();
  }

  // ─────────────────────────────────
  // RESCHEDULE ALL FROM HIVE
  // Reads saved reminders from Hive and reschedules them
  // Called by workmanager background task and on app start
  // Skips past, inactive, or corrupted entries silently
  // ─────────────────────────────────

  static Future<void> rescheduleAllFromHive() async {
    final box = HiveService.contestReminders;

    for (final key in box.keys) {
      try {
        final raw = box.get(key) as String?;
        if (raw == null) continue;

        final map = jsonDecode(raw) as Map<String, dynamic>;

        // Skip reminders manually disabled by user
        final isActive = (map['isActive'] as bool?) ?? true;
        if (!isActive) continue;

        final scheduledAt = DateTime.tryParse(
          (map['scheduledAt'] as String?) ?? '',
        );
        if (scheduledAt == null) continue;

        // Skip past reminders — no point rescheduling them
        if (scheduledAt.isBefore(DateTime.now())) continue;

        final notifId = (map['notificationId'] as int?) ?? 0;
        final contestName = (map['contestName'] as String?) ?? '';
        final minutesBefore = (map['minutesBefore'] as int?) ?? 0;

        await scheduleContestReminder(
          notificationId: notifId,
          contestName: contestName,
          minutesBefore: minutesBefore,
          scheduledAt: scheduledAt,
        );
      } catch (_) {
        // Skip corrupted Hive entries — don't crash the loop
      }
    }
  }

  // ─────────────────────────────────
  // SHOW IMMEDIATE NOTIFICATION
  // Fires instantly — used for testing
  // or urgent non-scheduled alerts
  // ─────────────────────────────────

  static Future<void> showImmediate({
    required int id,
    required String title,
    required String body,
  }) async {
     const  androidDetails = AndroidNotificationDetails(
      'contest_reminders',
      'Contest Reminders',
      importance: Importance.high,
      priority: Priority.high,
      color:  Color(0xFF00D4FF),
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    await _plugin.show(
      id,
      title,
      body,
      const NotificationDetails(android: androidDetails, iOS: iosDetails),
    );
  }
}