// Pure Dart — no annotations
// Aggregates data for home screen

/// Readiness score for home screen
/// Computed from profile stats
/// Range: 0 to 100
class ReadinessScore {
  const ReadinessScore({
    required this.score,
    required this.label,
    required this.color,
  });

  final int score;
  final String label;

  /// Color hex string
  /// Use AppColors in UI
  final String color;

  factory ReadinessScore.fromProfile({
    required int rating,
    required int streakDays,
    required int problemsSolved,
    required int contestsParticipated,
  }) {
    // Simple scoring algorithm
    // Rating component: 0-40 pts
    final ratingScore =
        (rating / 3000 * 40).clamp(0, 40).toInt();

    // Streak component: 0-30 pts
    final streakScore =
        (streakDays / 30 * 30).clamp(0, 30).toInt();

    // Problems component: 0-20 pts
    final problemScore =
        (problemsSolved / 500 * 20).clamp(0, 20).toInt();

    // Contests component: 0-10 pts
    final contestScore =
        (contestsParticipated / 50 * 10).clamp(0, 10).toInt();

    final total =
        ratingScore + streakScore + problemScore + contestScore;

    final label = total >= 80
        ? 'Contest Ready'
        : total >= 60
            ? 'Good Shape'
            : total >= 40
                ? 'Improving'
                : 'Keep Going';

    final color = total >= 80
        ? '#22C55E'
        : total >= 60
            ? '#4DA3FF'
            : total >= 40
                ? '#F59E0B'
                : '#EF4444';

    return ReadinessScore(
      score: total,
      label: label,
      color: color,
    );
  }
}

/// Rating change from last contest
class RatingDelta {
  const RatingDelta({
    required this.delta,
    required this.isPositive,
  });

  final int delta;
  final bool isPositive;

  String get formatted => isPositive ? '+$delta' : '$delta';
}
