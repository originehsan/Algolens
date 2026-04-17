import 'package:isar/isar.dart';

part 'cached_profile.g.dart';

@collection
class CachedProfile {
  Id id = Isar.autoIncrement;

  // Unique handle for lookup
  @Index(unique: true)
  late String handle;

  // From GET /users/{handle}/profile
  late int rating;
  late int maxRating;
  late String rank;
  late int problemsSolved;
  late int contestsParticipated;
  late int streakDays;
  late String lastActiveDate;
  late String avatar;

  // Cache metadata
  late DateTime cachedAt;

  // Valid for 5 minutes
  // Matches backend Redis TTL
  bool get isValid => DateTime.now().difference(cachedAt).inMinutes < 5;
}
