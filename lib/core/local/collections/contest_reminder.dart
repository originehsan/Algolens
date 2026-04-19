import 'package:isar/isar.dart';

part 'contest_reminder.g.dart';

@collection
class ContestReminder {
  Id id = Isar.autoIncrement;

  @Index()
  late int contestId;

  late String contestName;

  /// Minutes before: 30, 60, or 120
  late int minutesBefore;

  /// contestId * 100 + minutesBefore
  /// Unique notification ID
  late int notificationId;

  late DateTime scheduledAt;
  bool isActive = true;
}
