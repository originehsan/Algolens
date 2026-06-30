import 'package:flutter/material.dart';
import 'package:algolens/core/theme/app_colors.dart';

abstract class RatingUtils {
  RatingUtils._();

  /// Rating → rank string
  static String rankFromRating(int rating) {
    if (rating >= 3000) return 'Legendary Grandmaster';
    if (rating >= 2600) return 'International Grandmaster';
    if (rating >= 2400) return 'Grandmaster';
    if (rating >= 2300) return 'International Master';
    if (rating >= 2100) return 'Master';
    if (rating >= 1900) return 'Candidate Master';
    if (rating >= 1600) return 'Expert';
    if (rating >= 1400) return 'Specialist';
    if (rating >= 1200) return 'Pupil';
    return 'Newbie';
  }

  /// Rank string → color
  /// Same as AppColors.rankColor()
  /// but accessible from utils layer
  static Color colorFromRank(String rank) =>
      AppColors.rankColor(rank);

  /// Rating → color directly
  static Color colorFromRating(int rating) =>
      colorFromRank(rankFromRating(rating));

  /// Format delta "+30" or "-5"
  static String formatDelta(int delta) =>
      delta >= 0 ? '+$delta' : '$delta';

  /// Is rating delta positive?
  static bool isPositiveDelta(int delta) => delta >= 0;

  /// Readiness score 0–100
  /// rating:40 + streak:30 +
  /// problems:20 + contests:10
  static int readinessScore({
    required int rating,
    required int streakDays,
    required int problemsSolved,
    required int contestsParticipated,
  }) {
    final r = (rating / 3000 * 40).clamp(0, 40).toInt();
    final s = (streakDays / 30 * 30).clamp(0, 30).toInt();
    final p = (problemsSolved / 500 * 20).clamp(0, 20).toInt();
    final c = (contestsParticipated / 50 * 10).clamp(0, 10).toInt();
    return r + s + p + c;
  }

  /// Score → readiness label
  static String readinessLabel(int score) {
    if (score >= 80) return 'Contest Ready';
    if (score >= 60) return 'Good Shape';
    if (score >= 40) return 'Improving';
    return 'Keep Going';
  }

  /// Score → readiness color
  static Color readinessColor(int score) {
    if (score >= 80) return AppColors.success;
    if (score >= 60) return AppColors.primary;
    if (score >= 40) return AppColors.warning;
    return AppColors.danger;
  }
}