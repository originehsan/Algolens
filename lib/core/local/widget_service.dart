import 'dart:convert';
import 'package:home_widget/home_widget.dart';
import 'package:algolens/core/local/hive_service.dart';

/// Singleton widget service — static methods only.
/// Reads from Hive cache only — never makes API calls directly.
/// Background task in workmanager_service refreshes Hive, then calls update().
class WidgetService {
  WidgetService._();

  static const _appGroupId = 'group.algolens.widget';
  static const _androidWidgetName = 'AlgoLensWidget';
  static const _iosWidgetName = 'AlgoLensWidget';

  /// Sets app group ID for iOS widget data sharing.
  /// Call once in main() before runApp().
  static Future<void> init() async {
    await HomeWidget.setAppGroupId(_appGroupId);
  }

  /// Reads profile and contest data from Hive cache and pushes to home widget.
  /// Silently returns if widget is disabled in user settings.
  /// Called every 30 minutes by workmanager background task.
  static Future<void> update({required String handle}) async {
    final enabled =
        HiveService.userSettings.get('we') as bool? ?? false;
    if (!enabled) return;

    // Read cached profile data
    int rating = 0;
    String rank = '';
    int streakDays = 0;

    final profileRaw =
        HiveService.cachedProfiles.get(handle) as String?;
    if (profileRaw != null) {
      try {
        final map = jsonDecode(profileRaw) as Map<String, dynamic>;
        rating = (map['rating'] as int?) ?? 0;
        rank = (map['rank'] as String?) ?? '';
        streakDays = (map['streakDays'] as int?) ?? 0;
      } catch (_) {
        // Use defaults if cache is corrupted
      }
    }

    // Read next upcoming contest from cache
    String nextContest = '';
    String contestTime = '';

    final contestRaw =
        HiveService.cachedContests.get('upcoming') as String?;
    if (contestRaw != null) {
      try {
        final map = jsonDecode(contestRaw) as Map<String, dynamic>;
        final contests = map['data'] as List?;
        if (contests != null && contests.isNotEmpty) {
          final first = contests.first as Map<String, dynamic>;
          nextContest = (first['name'] as String?) ?? '';
          final startSecs = (first['startTimeSeconds'] as int?) ?? 0;
          if (startSecs > 0) {
            final startDt = DateTime.fromMillisecondsSinceEpoch(
              startSecs * 1000,
            );
            contestTime = _formatCountdown(startDt);
          }
        }
      } catch (_) {
        // Use defaults if cache is corrupted
      }
    }

    // Push all data to widget — use String for all to avoid platform issues
    await HomeWidget.saveWidgetData<String>('rating', rating.toString());
    await HomeWidget.saveWidgetData<String>('rank', rank);
    await HomeWidget.saveWidgetData<String>('streak', streakDays.toString());
    await HomeWidget.saveWidgetData<String>('handle', handle);
    await HomeWidget.saveWidgetData<String>('next_contest', nextContest);
    await HomeWidget.saveWidgetData<String>('contest_time', contestTime);
    await HomeWidget.saveWidgetData<String>(
      'updated_at',
      DateTime.now().toIso8601String(),
    );

    // Trigger widget UI refresh on home screen
    await HomeWidget.updateWidget(
      androidName: _androidWidgetName,
      iOSName: _iosWidgetName,
    );
  }

  /// Formats time until contest start into a human-readable string.
  /// Returns 'Live now' if contest has already started.
  static String _formatCountdown(DateTime startDt) {
    final diff = startDt.difference(DateTime.now());

    if (diff.isNegative) return 'Live now';

    final days = diff.inDays;
    final hours = diff.inHours % 24;
    final minutes = diff.inMinutes % 60;

    if (days > 0) return '${days}d ${hours}h';
    if (hours > 0) return '${hours}h ${minutes}m';
    return '${minutes}m';
  }

  /// Clears all widget data and refreshes to empty state.
  /// Called on logout to avoid showing stale user data.
  static Future<void> clear() async {
    await HomeWidget.saveWidgetData<String>('rating', '');
    await HomeWidget.saveWidgetData<String>('rank', '');
    await HomeWidget.saveWidgetData<String>('streak', '');
    await HomeWidget.saveWidgetData<String>('handle', '');
    await HomeWidget.saveWidgetData<String>('next_contest', '');
    await HomeWidget.saveWidgetData<String>('contest_time', '');

    await HomeWidget.updateWidget(
      androidName: _androidWidgetName,
      iOSName: _iosWidgetName,
    );
  }

  /// Returns true if home widget is enabled in user settings.
  static bool isEnabled() {
    return HiveService.userSettings.get('we') as bool? ?? false;
  }
}