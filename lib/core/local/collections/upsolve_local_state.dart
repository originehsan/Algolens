import 'package:isar/isar.dart';

part 'upsolve_local_state.g.dart';

@collection
class UpsolveLocalState {
  Id id = Isar.autoIncrement;

  // Format: "${contestId}_${index}"
  // Example: "1865_D"
  @Index(unique: true)
  late String problemKey;

  // From API response
  late int contestId;
  late String problemIndex;
  late String problemName;
  late int problemRating;

  // WRONG_ANSWER, TIME_LIMIT_EXCEEDED
  // MEMORY_LIMIT_EXCEEDED, RUNTIME_ERROR
  late String bestVerdict;

  // CF problem URL
  late String problemUrl;

  // JSON string of tags
  // Decode with jsonDecode()
  // Example: '["binary search","dp"]'
  late String tagsJson;

  // Matches user weak topics?
  // true = show first in list
  bool isWeakTopic = false;

  // User marked as done?
  bool isCompleted = false;
  DateTime? completedAt;
}
