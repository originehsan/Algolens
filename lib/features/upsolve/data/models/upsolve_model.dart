class UpsolveModel {
  const UpsolveModel({
    required this.contestId,
    required this.index,
    required this.name,
    required this.rating,
    required this.tags,
    required this.bestVerdict,
    required this.url,
    required this.isCompleted,
    required this.isWeakTopic,
  });

  final int contestId;
  final String index;
  final String name;
  final int rating;
  final List<String> tags;
  final String bestVerdict;
  final String url;
  final bool isCompleted;
  final bool isWeakTopic;

  factory UpsolveModel.fromJson(
    Map<String, dynamic> json, {
    bool isCompleted = false,
    bool isWeakTopic = false,
  }) {
    final contestId = (json['contestId'] as int?) ?? 0;
    final index = (json['index'] as String?) ?? '';

    return UpsolveModel(
      contestId: contestId,
      index: index,
      name: (json['name'] as String?) ?? '',
      rating: (json['rating'] as int?) ?? 0,
      tags: (json['tags'] as List?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      bestVerdict: (json['bestVerdict'] as String?) ?? '',
      url: (json['url'] as String?) ??
          'https://codeforces.com/contest/$contestId/problem/$index',
      isCompleted: isCompleted,
      isWeakTopic: isWeakTopic,
    );
  }

  Map<String, dynamic> toJson() => {
        'contestId': contestId,
        'index': index,
        'name': name,
        'rating': rating,
        'tags': tags,
        'bestVerdict': bestVerdict,
        'url': url,
        'isCompleted': isCompleted,
        'isWeakTopic': isWeakTopic,
      };

  String get problemKey => '${contestId}_$index';

  UpsolveModel copyWith({bool? isCompleted}) => UpsolveModel(
        contestId: contestId,
        index: index,
        name: name,
        rating: rating,
        tags: tags,
        bestVerdict: bestVerdict,
        url: url,
        isCompleted: isCompleted ?? this.isCompleted,
        isWeakTopic: isWeakTopic,
      );

  String get verdictLabel => switch (bestVerdict) {
        'WRONG_ANSWER' => 'WA',
        'TIME_LIMIT_EXCEEDED' => 'TLE',
        'MEMORY_LIMIT_EXCEEDED' => 'MLE',
        'RUNTIME_ERROR' => 'RE',
        'COMPILATION_ERROR' => 'CE',
        _ => bestVerdict.isNotEmpty
            ? bestVerdict.substring(0, 2).toUpperCase()
            : '??',
      };
}