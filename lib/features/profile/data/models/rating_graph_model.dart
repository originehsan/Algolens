// Pure Dart — no annotations
// Used by profile_repository (P40)
// fl_chart data in profile_screen

class RatingGraphModel {
  const RatingGraphModel({
    required this.contestId,
    required this.contestName,
    required this.rating,
    required this.date,
  });

  final int contestId;
  final String contestName;
  final int rating;
  final String date;

  factory RatingGraphModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      RatingGraphModel(
        contestId: json['contestId'] as int,
        contestName: json['contestName'] as String,
        rating: json['rating'] as int,
        date: json['date'] as String,
      );

  Map<String, dynamic> toJson() => {
        'contestId': contestId,
        'contestName': contestName,
        'rating': rating,
        'date': date,
      };

  /// Parsed date for fl_chart
  DateTime get parsedDate =>
      DateTime.tryParse(date) ?? DateTime.now();
}
