import 'package:isar/isar.dart';

part 'dismissed_contest.g.dart';

@collection
class DismissedContest {
  Id id = Isar.autoIncrement;

  // CF contest ID
  @Index(unique: true)
  late int contestId;

  // When dismissed
  late DateTime dismissedAt;
}
