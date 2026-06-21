import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:algolens/core/local/hive_service.dart';
import 'package:algolens/core/local/notification_service.dart';

// ─────────────────────────────────
// PERMISSION STATUS ENUM
// Maps permission_handler status
// to app-specific flow states
// ─────────────────────────────────

enum NotifPermissionStatus {
  /// Permission granted — nothing to show
  granted,

  /// Never asked — show bottom sheet once
  notAsked,

  /// User denied once — show banner for 3 days
  denied,

  /// Permanently denied — show settings link banner
  permanentlyDenied,
}

// ─────────────────────────────────
// PROVIDER
// Riverpod provider — NOT a singleton
// Unlike NotificationService (P59)
// ─────────────────────────────────

final notificationPermissionServiceProvider =
    Provider<NotificationPermissionService>(
  (ref) => NotificationPermissionService(),
);

// ─────────────────────────────────
// NOTIFICATION PERMISSION SERVICE
// Snapchat-style permission flow:
// GRANTED → nothing shown
// NOT_ASKED → bottom sheet once
// DENIED → home banner 3 days
// PERMANENTLY_DENIED → settings link
// ─────────────────────────────────

class NotificationPermissionService {

  // ─────────────────────────────────
  // GET CURRENT STATUS
  // Reads from permission_handler
  // Falls back to Hive 'na' key
  // ─────────────────────────────────

  Future<NotifPermissionStatus> getStatus() async {
    final status = await ph.Permission.notification.status;

    if (status.isGranted) return NotifPermissionStatus.granted;

    if (status.isPermanentlyDenied) {
      return NotifPermissionStatus.permanentlyDenied;
    }

    // Check if we've asked before via Hive flag
    final asked = HiveService.userSettings.get('na') as bool? ?? false;
    if (!asked) return NotifPermissionStatus.notAsked;

    return NotifPermissionStatus.denied;
  }

  // ─────────────────────────────────
  // REQUEST PERMISSION
  // Marks 'na' = true in Hive first
  // Then calls NotificationService
  // Returns true if user granted
  // ─────────────────────────────────

  Future<bool> requestPermission() async {
    // Record that we asked — prevents showing bottom sheet again
    await HiveService.userSettings.put('na', true);

    final granted = await NotificationService.requestPermission();
    return granted;
  }

  // ─────────────────────────────────
  // CHECK AND PROMPT
  // Called on home screen mount
  // Returns current status for UI
  // ─────────────────────────────────

  Future<NotifPermissionStatus> checkAndPrompt() async {
    return getStatus();
  }

  // ─────────────────────────────────
  // SHOULD SHOW BANNER
  // True if denied within 3 days
  // False if granted or not asked yet
  // ─────────────────────────────────

  Future<bool> shouldShowBanner() async {
    final status = await getStatus();

    // No banner needed if granted or not asked yet
    if (status == NotifPermissionStatus.granted) return false;
    if (status == NotifPermissionStatus.notAsked) return false;

    // Check when banner was last shown
    final lastShown = HiveService.userSettings.get('bs') as String?;

    if (lastShown == null) {
      // First time showing banner — record timestamp
      await _updateBannerShown();
      return true;
    }

    final lastDate = DateTime.tryParse(lastShown);
    if (lastDate == null) {
      await _updateBannerShown();
      return true;
    }

    // Only show banner for 3 days after denial
    final daysSince = DateTime.now().difference(lastDate).inDays;
    return daysSince <= 3;
  }

  // ─────────────────────────────────
  // UPDATE BANNER SHOWN
  // Records current timestamp in Hive
  // ─────────────────────────────────

  Future<void> _updateBannerShown() async {
    await HiveService.userSettings.put('bs', DateTime.now().toIso8601String());
  }

  // ─────────────────────────────────
  // OPEN APP SETTINGS
  // For permanently denied case
  // Uses ph prefix to avoid recursive
  // call to this method itself
  // ─────────────────────────────────

  Future<void> openAppSettings() async {
    // Must use ph.openAppSettings() — not openAppSettings()
    // Calling openAppSettings() without prefix would be recursive
    await ph.openAppSettings();
  }

  // ─────────────────────────────────
  // QUICK HELPERS
  // Convenience wrappers around
  // permission_handler checks
  // ─────────────────────────────────

  /// Returns true if notifications are currently granted
  Future<bool> isGranted() async {
    return ph.Permission.notification.isGranted;
  }

  /// Returns true if user permanently denied notifications
  Future<bool> isPermanentlyDenied() async {
    return ph.Permission.notification.isPermanentlyDenied;
  }
}