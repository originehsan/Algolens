// Pure Dart — no annotations
// Used by friends_provider (P49)
// Leaderboard tab in friends_screen

class LeaderboardModel {
  const LeaderboardModel({
    required this.rank,
    required this.handle,
    required this.rating,
    required this.tier,
    required this.maxRating,
  });

  final int rank;
  final String handle;
  final int rating;
  final String tier;
  final int maxRating;

  factory LeaderboardModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      LeaderboardModel(
        rank: json['rank'] as int,
        handle: json['handle'] as String,
        rating: json['rating'] as int,
        tier: (json['tier'] as String?) ?? 'newbie',
        maxRating: (json['maxRating'] as int?) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'rank': rank,
        'handle': handle,
        'rating': rating,
        'tier': tier,
        'maxRating': maxRating,
      };

  // ───────────────────────────────
  // COMPUTED PROPERTIES
  // ───────────────────────────────

  /// Rank medal emoji
  String get rankEmoji => switch (rank) {
        1 => '🥇',
        2 => '🥈',
        3 => '🥉',
        _ => '#$rank',
      };
}
