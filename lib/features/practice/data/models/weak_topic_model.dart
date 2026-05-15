class WeakTopicModel {
  const WeakTopicModel({
    required this.tag,
    required this.totalAttempts,
    required this.solvedCount,
    required this.unsolvedCount,
    required this.acRate,
    required this.severity,
  });

  final String tag;
  final int totalAttempts;
  final int solvedCount;
  final int unsolvedCount;
  final double acRate;

  /// critical / high / moderate
  final String severity;

  factory WeakTopicModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final acRate = (json['acRate'] as num?)?.toDouble() ?? 0.0;

    final severity =
        (json['severity'] as String?) ?? _computeSeverity(acRate);

    return WeakTopicModel(
      tag: json['tag'] as String,
      totalAttempts: (json['totalAttempts'] as int?) ?? 0,
      solvedCount: (json['solvedCount'] as int?) ?? 0,
      unsolvedCount: (json['unsolvedCount'] as int?) ?? 0,
      acRate: acRate,
      severity: severity,
    );
  }

  static String _computeSeverity(double acRate) {
    if (acRate < 0.40) return 'critical';
    if (acRate < 0.60) return 'high';
    return 'moderate';
  }

  Map<String, dynamic> toJson() => {
        'tag': tag,
        'totalAttempts': totalAttempts,
        'solvedCount': solvedCount,
        'unsolvedCount': unsolvedCount,
        'acRate': acRate,
        'severity': severity,
      };

  // ───────────────────────────────
  // COMPUTED PROPERTIES
  // ───────────────────────────────

  String get severityColor => switch (severity) {
        'critical' => '#EF4444',
        'high' => '#F59E0B',
        _ => '#4DA3FF',
      };

  String get acRateFormatted =>
      '${(acRate * 100).toStringAsFixed(0)}%';

  bool get isCritical => severity == 'critical';
}
