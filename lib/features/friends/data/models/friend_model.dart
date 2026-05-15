// Pure Dart — no annotations
// Used by friends_provider (P49)
// No local cache — always fresh

class FriendModel {
  const FriendModel({
    required this.handle,
    required this.rating,
    required this.maxRating,
    required this.rank,
    required this.avatar,
    required this.contestsParticipated,
  });

  final String handle;
  final int rating;
  final int maxRating;
  final String rank;
  final String avatar;
  final int contestsParticipated;

  factory FriendModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      FriendModel(
        handle: json['handle'] as String,
        rating: json['rating'] as int,
        maxRating: json['maxRating'] as int,
        rank: (json['rank'] as String?) ?? 'newbie',
        avatar: (json['avatar'] as String?) ?? '',
        contestsParticipated: (json['contestsParticipated'] as int?) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'handle': handle,
        'rating': rating,
        'maxRating': maxRating,
        'rank': rank,
        'avatar': avatar,
        'contestsParticipated': contestsParticipated,
      };

  // ───────────────────────────────
  // COMPUTED PROPERTIES
  // ───────────────────────────────

  /// Rating delta from peak
  int get ratingDelta => rating - maxRating;

  /// True if rated
  bool get isRated => rating > 0;
}
