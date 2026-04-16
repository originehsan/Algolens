class ProblemAnalysis {
  final int contestId;
  final String problemIndex;
  final String problemName;
  final String likelyIssue;
  final String conceptToStudy;
  final String actionableTip;

  const ProblemAnalysis({
    required this.contestId,
    required this.problemIndex,
    required this.problemName,
    required this.likelyIssue,
    required this.conceptToStudy,
    required this.actionableTip,
  });

  factory ProblemAnalysis.fromJson(Map<String, dynamic> json) {
    return ProblemAnalysis(
      contestId: json['contestId'] as int,
      problemIndex: json['problemIndex'] as String,
      problemName: json['problemName'] as String,
      likelyIssue: json['likelyIssue'] as String,
      conceptToStudy: json['conceptToStudy'] as String,
      actionableTip: json['actionableTip'] as String,
    );
  }
}

class AiAnalysisResponse {
  final List<ProblemAnalysis> problemAnalyses;
  final String overallRecommendation;

  const AiAnalysisResponse({
    required this.problemAnalyses,
    required this.overallRecommendation,
  });

  factory AiAnalysisResponse.fromJson(Map<String, dynamic> json) {
    return AiAnalysisResponse(
      problemAnalyses: (json['problemAnalyses'] as List)
          .map(
            (p) => ProblemAnalysis.fromJson(
              p as Map<String, dynamic>,
            ),
          )
          .toList(),
      overallRecommendation: json['overallRecommendation'] as String,
    );
  }
}
