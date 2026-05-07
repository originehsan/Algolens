// Pure Dart — no annotations
// Used by profile_repository (P40)
// Cached in HiveService.cachedProfiles

class ProfileModel {
  const ProfileModel({
    required this.handle,
    required this.rating,
    required this.maxRating,
    required this.rank,
    required this.maxRank,
    required this.problemsSolved,
    required this.contestsParticipated,
    required this.streakDays,
    required this.lastActiveDate,
    required this.avatar,
  });

  final String handle;
  final int rating;
  final int maxRating;
  final String rank;
  final String maxRank;
  final int problemsSolved;
  final int contestsParticipated;
  final int streakDays;
  final String lastActiveDate;
  final String avatar;

  factory ProfileModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      ProfileModel(
        handle: json['handle'] as String,
        rating: json['rating'] as int,
        maxRating: json['maxRating'] as int,
        rank: json['rank'] as String,
        maxRank: (json['maxRank'] as String?) ?? '',
        problemsSolved: json['problemsSolved'] as int,
        contestsParticipated:
            json['contestsParticipated'] as int,
        streakDays: (json['streakDays'] as int?) ?? 0,
        lastActiveDate:
            (json['lastActiveDate'] as String?) ?? '',
        avatar: (json['avatar'] as String?) ?? '',
      );

  Map<String, dynamic> toJson() => {
        'handle': handle,
        'rating': rating,
        'maxRating': maxRating,
        'rank': rank,
        'maxRank': maxRank,
        'problemsSolved': problemsSolved,
        'contestsParticipated': contestsParticipated,
        'streakDays': streakDays,
        'lastActiveDate': lastActiveDate,
        'avatar': avatar,
      };

  // ───────────────────────────────
  // COMPUTED PROPERTIES
  // Used in UI directly
  // ───────────────────────────────

  /// Rating change from peak
  int get ratingDelta => rating - maxRating;

  /// True if rated on CF
  bool get isRated => rating > 0;
}
