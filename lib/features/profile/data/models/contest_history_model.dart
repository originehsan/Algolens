// Pure Dart — no annotations
// Used by profile_repository (P40)
// Contest history list in profile_screen

class ContestHistoryModel {
  const ContestHistoryModel({
    required this.contestId,
    required this.contestName,
    required this.rank,
    required this.oldRating,
    required this.newRating,
    required this.ratingChange,
  });

  final int contestId;
  final String contestName;
  final int rank;
  final int oldRating;
  final int newRating;
  final int ratingChange;

  factory ContestHistoryModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      ContestHistoryModel(
        contestId: json['contestId'] as int,
        contestName: json['contestName'] as String,
        rank: json['rank'] as int,
        oldRating: json['oldRating'] as int,
        newRating: json['newRating'] as int,
        ratingChange: json['ratingChange'] as int,
      );

  Map<String, dynamic> toJson() => {
        'contestId': contestId,
        'contestName': contestName,
        'rank': rank,
        'oldRating': oldRating,
        'newRating': newRating,
        'ratingChange': ratingChange,
      };

  // ───────────────────────────────
  // COMPUTED PROPERTIES
  // ───────────────────────────────

  /// true = rating went up
  bool get isPositive => ratingChange >= 0;

  /// Formatted change: +17 or -23
  String get formattedChange =>
      ratingChange >= 0 ? '+$ratingChange' : '$ratingChange';
}
