import 'package:isar/isar.dart';

part 'cached_contest.g.dart';

@collection
class CachedContest {
  Id id = Isar.autoIncrement;

  // Unique CF contest ID
  @Index(unique: true)
  late int contestId;

  // From GET /contests/upcoming
  late String name;
  late String type;
  late int durationSeconds;
  late int startTimeSeconds;
  late int relativeTimeSeconds;

  // Cache metadata
  late DateTime cachedAt;

  // Valid for 1 hour
  // Matches backend Redis TTL
  bool get isValid => DateTime.now().difference(cachedAt).inHours < 1;

  // Not started yet
  bool get isUpcoming => relativeTimeSeconds < 0;

  // Started but not finished
  bool get isLive =>
      relativeTimeSeconds >= 0 && relativeTimeSeconds < durationSeconds;

  // Convert to DateTime
  DateTime get startDateTime => DateTime.fromMillisecondsSinceEpoch(
        startTimeSeconds * 1000,
      );

  // "2h" or "2h 30m"
  String get durationFormatted {
    final h = durationSeconds ~/ 3600;
    final m = (durationSeconds % 3600) ~/ 60;
    if (m == 0) return '${h}h';
    return '${h}h ${m}m';
  }

  // Difficulty from contest name
  // NOT from API — calculated locally
  String get difficulty {
    final n = name.toLowerCase();
    if (n.contains('div. 1 +') || n.contains('div. 1+')) return 'Hard';
    if (n.contains('div. 1')) return 'Hard';
    if (n.contains('div. 2')) return 'Moderate';
    if (n.contains('div. 3')) return 'Easy';
    if (n.contains('div. 4')) return 'Easy';
    if (n.contains('educational')) return 'Moderate';
    return 'Moderate';
  }
}
