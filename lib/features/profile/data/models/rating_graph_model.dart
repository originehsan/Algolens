class RatingPoint {
  final int contestId;
  final String contestName;
  final int rating;
  final String date;

  const RatingPoint({
    required this.contestId,
    required this.contestName,
    required this.rating,
    required this.date,
  });

  factory RatingPoint.fromJson(Map<String, dynamic> json) {
    return RatingPoint(
      contestId: json['contestId'] as int,
      contestName: json['contestName'] as String,
      rating: json['rating'] as int,
      date: json['date'] as String,
    );
  }
}
