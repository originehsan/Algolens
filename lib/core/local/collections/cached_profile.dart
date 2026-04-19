import 'package:isar/isar.dart';

part 'cached_profile.g.dart';

@collection
class CachedProfile {
  Id id = Isar.autoIncrement;

  /// CF handle as cache key
  @Index(unique: true)
  late String handle;

  /// Full JSON string of ProfileModel
  late String jsonData;

  /// Cache expiry — 5 minutes
  late DateTime cachedAt;

  /// Returns true if cache is fresh
  bool get isValid {
    return DateTime.now().difference(cachedAt).inMinutes < 5;
  }
}
