class ProblemAnalysis {
  const ProblemAnalysis({
    required this.contestId,
    required this.problemIndex,
    required this.problemName,
    required this.likelyIssue,
    required this.conceptToStudy,
    required this.actionableTip,
  });

  final int contestId;
  final String problemIndex;
  final String problemName;
  final String likelyIssue;
  final String conceptToStudy;
  final String actionableTip;

  factory ProblemAnalysis.fromJson(Map<String, dynamic> json) =>
      ProblemAnalysis(
        contestId: (json['contestId'] as int?) ?? 0,
        problemIndex: (json['problemIndex'] as String?) ?? '',
        problemName: (json['problemName'] as String?) ?? '',
        likelyIssue: (json['likelyIssue'] as String?) ?? '',
        conceptToStudy: (json['conceptToStudy'] as String?) ?? '',
        actionableTip: (json['actionableTip'] as String?) ?? '',
      );

  Map<String, dynamic> toJson() => {
        'contestId': contestId,
        'problemIndex': problemIndex,
        'problemName': problemName,
        'likelyIssue': likelyIssue,
        'conceptToStudy': conceptToStudy,
        'actionableTip': actionableTip,
      };

  // Short label e.g. "1991D" — used in analysis card header
  String get shortLabel => '$contestId$problemIndex';

  // Direct CF problem URL
  String get url =>
      'https://codeforces.com/contest/$contestId/problem/$problemIndex';
}

// Renamed from AiAnalysisResponse → AnalysisResponse
// to match provider and repository usage
class AnalysisResponse {
  const AnalysisResponse({
    required this.problemAnalyses,
    required this.overallRecommendation,
  });

  final List<ProblemAnalysis> problemAnalyses;
  final String overallRecommendation;

  factory AnalysisResponse.fromJson(Map<String, dynamic> json) {
    // Handle multiple possible response keys from backend
    final analyses =
        json['problemAnalyses'] as List? ??
        json['analyses'] as List? ??
        [];

    return AnalysisResponse(
      problemAnalyses: analyses
          .map((e) => ProblemAnalysis.fromJson(e as Map<String, dynamic>))
          .toList(),
      // Handle both possible key names
      overallRecommendation:
          (json['overallRecommendation'] as String?) ??
          (json['recommendation'] as String?) ??
          '',
    );
  }

  Map<String, dynamic> toJson() => {
        'problemAnalyses': problemAnalyses.map((e) => e.toJson()).toList(),
        'overallRecommendation': overallRecommendation,
      };

  bool get isEmpty => problemAnalyses.isEmpty;
  int get totalAnalysed => problemAnalyses.length;
}