class ContestHistoryItem {
  final int contestId;
  final String contestName;
  final int rank;
  final int oldRating;
  final int newRating;
  final int ratingChange;

  const ContestHistoryItem({
    required this.contestId,
    required this.contestName,
    required this.rank,
    required this.oldRating,
    required this.newRating,
    required this.ratingChange,
  });

  factory ContestHistoryItem.fromJson(Map<String, dynamic> json) {
    return ContestHistoryItem(
      contestId: json['contestId'] as int,
      contestName: json['contestName'] as String,
      rank: json['rank'] as int,
      oldRating: json['oldRating'] as int,
      newRating: json['newRating'] as int,
      ratingChange: json['ratingChange'] as int,
    );
  }

  bool get isPositive => ratingChange > 0;
}
