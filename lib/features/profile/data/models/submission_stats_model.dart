// Pure Dart — no annotations
// Used by profile_repository (P40)
// Verdict grid in profile_screenc

class SubmissionStatsModel {
  const SubmissionStatsModel({
    required this.totalSubmissions,
    required this.solvedProblems,
    required this.unSolvedProblems,
    required this.verdictsCount,
  });

  final int totalSubmissions;
  final int solvedProblems;
  final int unSolvedProblems;
  final Map<String, int> verdictsCount;

  factory SubmissionStatsModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      SubmissionStatsModel(
        totalSubmissions: json['totalSubmissions'] as int,
        solvedProblems: json['solvedProblems'] as int,
        unSolvedProblems: json['unSolvedProblems'] as int,
        verdictsCount: Map<String, int>.from(
          json['verdictsCount'] as Map,
        ),
      );

  Map<String, dynamic> toJson() => {
        'totalSubmissions': totalSubmissions,
        'solvedProblems': solvedProblems,
        'unSolvedProblems': unSolvedProblems,
        'verdictsCount': verdictsCount,
      };

  // ───────────────────────────────
  // VERDICT HELPERS
  // Used in profile_screen grid
  // ───────────────────────────────

 int get accepted => verdictsCount['ACCEPTED'] ?? 0;

  int get wrongAnswer =>
      verdictsCount['WRONG_ANSWER'] ?? 0;

  int get timeLimitExceeded =>
      verdictsCount['TIME_LIMIT_EXCEEDED'] ?? 0;

  int get memoryLimitExceeded =>
      verdictsCount['MEMORY_LIMIT_EXCEEDED'] ?? 0;

  int get runtimeError =>
      verdictsCount['RUNTIME_ERROR'] ?? 0;

  /// AC rate as 0.0 to 1.0
  double get acRate =>
      totalSubmissions == 0
          ? 0.0
          : accepted / totalSubmissions;
}
