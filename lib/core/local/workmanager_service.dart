import 'package:workmanager/workmanager.dart';
import 'package:algolens/core/local/hive_service.dart';
import 'package:algolens/core/local/notification_service.dart';
import 'package:algolens/core/local/widget_service.dart';

// Top-level function — required by workmanager.
// Runs in a separate isolate from the main app.
// Must re-initialize all services before using them.
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    try {
      // Hive must be re-initialized in every background isolate
      await HiveService.init();

      switch (taskName) {
        // Runs every 30 minutes — reads Hive cache and pushes to home widget
        case WorkmanagerService.widgetUpdateTask:
          await WidgetService.init();
          // SecureStorage unavailable in isolate — read handle from Hive instead
          final profileKeys = HiveService.cachedProfiles.keys.toList();
          if (profileKeys.isNotEmpty) {
            final handle = profileKeys.first.toString();
            await WidgetService.update(handle: handle);
          }
          break;

        // Runs every 1 hour — reschedules contest reminders from Hive
        case WorkmanagerService.notifRescheduleTask:
          await NotificationService.init();
          await NotificationService.rescheduleAllFromHive();
          break;

        default:
          break;
      }

      return Future.value(true);
    } catch (_) {
      // Return false so workmanager knows the task failed
      return Future.value(false);
    }
  });
}

/// Singleton workmanager service — static methods only.
/// init() and registerTasks() must be called in main() before runApp().
class WorkmanagerService {
  WorkmanagerService._();

  // Task name constants — must match case strings in callbackDispatcher
  static const widgetUpdateTask = 'widgetUpdate';
  static const notifRescheduleTask = 'notifReschedule';

  /// Registers the background callback dispatcher.
  static Future<void> init() async {
    // isInDebugMode is deprecated — omitted
    await Workmanager().initialize(callbackDispatcher);
  }

  /// Registers all periodic background tasks.
  static Future<void> registerTasks() async {
    // Updates home widget every 30 minutes — requires network
    await Workmanager().registerPeriodicTask(
      widgetUpdateTask,
      widgetUpdateTask,
      frequency: const Duration(minutes: 30),
      constraints: Constraints(networkType: NetworkType.connected),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
    );

    // Reschedules notification reminders every hour — works offline
    await Workmanager().registerPeriodicTask(
      notifRescheduleTask,
      notifRescheduleTask,
      frequency: const Duration(hours: 1),
      constraints: Constraints(networkType: NetworkType.notRequired),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
    );
  }

  /// Cancels all registered background tasks — call on logout.
  static Future<void> cancelAll() async {
    await Workmanager().cancelAll();
  }

  /// Cancels a single background task by unique name.
  static Future<void> cancel(String taskName) async {
    await Workmanager().cancelByUniqueName(taskName);
  }
}