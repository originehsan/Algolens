import 'package:isar/isar.dart';

part 'cached_contest.g.dart';

@collection
class CachedContest {
  Id id = Isar.autoIncrement;

  /// Cache key: "upcoming" or "all"
  @Index(unique: true)
  late String cacheKey;

  /// JSON string of contest list
  late String jsonData;

  /// Cache expiry — 1 hour
  late DateTime cachedAt;

  /// Returns true if cache is fresh
  bool get isValid {
    return DateTime.now().difference(cachedAt).inHours < 1;
  }
}
