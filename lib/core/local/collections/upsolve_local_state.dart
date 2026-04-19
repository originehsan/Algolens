import 'package:isar/isar.dart';

part 'upsolve_local_state.g.dart';

@collection
class UpsolveLocalState {
  Id id = Isar.autoIncrement;

  /// Key format: "{contestId}_{index}"
  /// e.g. "1234_A"
  @Index(unique: true)
  late String problemKey;

  bool isCompleted = false;
  DateTime? completedAt;
}
