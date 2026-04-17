import 'package:isar/isar.dart';

part 'contest_reminder.g.dart';

@collection
class ContestReminder {
  Id id = Isar.autoIncrement;

  // Which contest
  @Index()
  late int contestId;

  // Cached for offline display
  late String contestName;

  // Unix timestamp seconds
  late int contestStartTimeSeconds;

  // 0-120 minutes before
  late int minutesBefore;

  // flutter_local_notifications ID
  // Formula: contestId * 100
  //          + minutesBefore
  // Example: 1900 * 100 + 30 = 190030
  late int notificationId;

  // Active = not cancelled
  bool isActive = true;

  late DateTime scheduledAt;

  // Computed — NOT stored
  // When notification fires
  DateTime get firesAt => DateTime.fromMillisecondsSinceEpoch(
        contestStartTimeSeconds * 1000,
      ).subtract(
        Duration(minutes: minutesBefore),
      );

  // Has it already fired?
  bool get hasFired => DateTime.now().isAfter(firesAt);
}
