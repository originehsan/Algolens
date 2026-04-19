import 'package:isar/isar.dart';

part 'user_settings.g.dart';

@collection
class UserSettings {
  Id id = Isar.autoIncrement;

  // Notifications (FREE)
  bool contestAlertsEnabled = true;
  bool streakReminderEnabled = true;
  bool upsolveReminderEnabled = true;

  // Reminder timing
  int reminderMinutesBefore = 30;

  // TTS Voice (FREE)
  bool ttsEnabled = false;
  String ttsLanguage = 'en-US';
  double ttsVolume = 0.8;

  // Premium 🔒
  bool smsAlertsEnabled = false;
  bool voiceCallEnabled = false;
  bool isPhoneVerified = false;
  String? phoneNumber;

  // Home widget
  bool widgetEnabled = false;

  // Onboarding
  bool onboardingCompleted = false;

  // Notification permission
  bool notificationAsked = false;
  DateTime? bannerLastShownAt;
}
