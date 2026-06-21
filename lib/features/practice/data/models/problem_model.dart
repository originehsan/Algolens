class ProblemModel {
  const ProblemModel({
    required this.contestId,
    required this.index,
    required this.name,
    required this.rating,
    required this.tags,
  });

  final int contestId;
  final String index;
  final String name;
  final int rating;
  final List<String> tags;

  factory ProblemModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      ProblemModel(
        contestId: json['contestId'] as int,
        index: json['index'] as String,
        name: json['name'] as String,
        rating: (json['rating'] as int?) ?? 0,
        tags: (json['tags'] as List?)
                ?.map((e) => e as String)
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        'contestId': contestId,
        'index': index,
        'name': name,
        'rating': rating,
        'tags': tags,
      };

  String get url =>
      'https://codeforces.com/contest/$contestId/problem/$index';

  String get problemKey => '${contestId}_$index';
}