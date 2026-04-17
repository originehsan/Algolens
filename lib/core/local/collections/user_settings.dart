import 'package:isar/isar.dart';

part 'user_settings.g.dart';

@collection
class UserSettings {
  Id id = 1;

  // Notification — FREE
  bool contestAlertsEnabled = true;
  bool streakReminderEnabled = true;
  bool upsolveReminderEnabled = false;

  // TTS Voice — FREE
  bool ttsEnabled = false;
  String ttsLanguage = 'en-US';
  double ttsVolume = 0.80;

  // Premium 🔒
  // DO NOT enable
  // Show premium dialog on tap
  bool smsAlertsEnabled = false;
  bool voiceCallEnabled = false;
  bool isPhoneVerified = false;
  String? phoneNumber;

  // Reminder timing
  // 0-120 minutes before contest
  int reminderMinutesBefore = 30;

  // Home widget
  bool widgetEnabled = true;

  // Notification permission
  // Snapchat style
  bool notificationAsked = false;
  DateTime? bannerLastShownAt;

  // Onboarding
  // Show slides only once
  bool onboardingCompleted = false;
}
