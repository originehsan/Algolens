class Problem {
  final int contestId;
  final String index;
  final String name;
  final int rating;
  final List<String> tags;

  const Problem({
    required this.contestId,
    required this.index,
    required this.name,
    required this.rating,
    required this.tags,
  });

  factory Problem.fromJson(Map<String, dynamic> json) {
    return Problem(
      contestId: json['contestId'] as int,
      index: json['index'] as String,
      name: json['name'] as String,
      rating: json['rating'] as int,
      tags: List<String>.from(
        json['tags'] as List,
      ),
    );
  }

  String get cfUrl =>
      'https://codeforces.com/contest/$contestId/problem/$index';
}
