class SubmissionStats {
  final int totalSubmissions;
  final int solvedProblems;
  final int unSolvedProblems;
  final Map<String, int> verdictsCount;

  const SubmissionStats({
    required this.totalSubmissions,
    required this.solvedProblems,
    required this.unSolvedProblems,
    required this.verdictsCount,
  });

  factory SubmissionStats.fromJson(Map<String, dynamic> json) {
    return SubmissionStats(
      totalSubmissions: json['totalSubmissions'] as int,
      solvedProblems: json['solvedProblems'] as int,
      unSolvedProblems: json['unSolvedProblems'] as int,
      verdictsCount: Map<String, int>.from(
        json['verdictsCount'] as Map,
      ),
    );
  }

  double get acceptanceRate {
    if (totalSubmissions == 0) return 0;
    return (solvedProblems / totalSubmissions) * 100;
  }
}
