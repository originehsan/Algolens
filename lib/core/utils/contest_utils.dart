import 'package:flutter/material.dart';
import 'package:algolens/core/constants/app_constants.dart';
import 'package:algolens/core/constants/app_strings.dart';
import 'package:algolens/core/theme/app_colors.dart';

abstract class ContestUtils {
  ContestUtils._();

  /// Contest name → display type label
  /// "Codeforces Round 900 (Div. 2)"
  /// → "DIV 2"
  static String typeLabel(String name) {
    final n = name.toLowerCase();
    if (n.contains('educational')) return AppStrings.edu;
    if (n.contains('div. 1') && n.contains('div. 2')) {
      return AppStrings.div1Plus2;
    }
    if (n.contains('div. 1')) return AppStrings.div1;
    if (n.contains('div. 2')) return AppStrings.div2;
    if (n.contains('div. 3')) return AppStrings.div3;
    if (n.contains('div. 4')) return AppStrings.div4;
    if (n.contains('icpc')) return AppStrings.icpc;
    return AppStrings.cf;
  }

  /// Contest name → accent color
  static Color accentColor(String name) {
    final n = name.toLowerCase();
    if (n.contains('educational')) return AppColors.success;
    if (n.contains('div. 1') && !n.contains('div. 2')) return AppColors.danger;
    if (n.contains('div. 3') || n.contains('div. 4')) return AppColors.warning;
    return AppColors.primary;
  }

  /// Remaining duration → urgency color
  /// < 60 min  → danger red
  /// < 24 hr   → warning amber
  /// else      → primary blue
  static Color urgencyColor(Duration remaining) {
    final mins = remaining.inMinutes;
    if (mins <= AppConstants.urgencyRedMinutes) return AppColors.danger;
    if (mins <= AppConstants.urgencyAmberMinutes) return AppColors.warning;
    return AppColors.primary;
  }

  /// Urgency bar progress 0.0–1.0
  /// Based on 7-day window
  static double urgencyProgress(Duration remaining) {
    const window = AppConstants.urgencyWindowDays * 86400;
    return 1.0 - (remaining.inSeconds / window).clamp(0.0, 1.0);
  }

  /// Hive notification ID formula
  /// contestId * 100 + minutesBefore
  static int notifId(int contestId, int minutesBefore) =>
      contestId * AppConstants.notifIdMultiplier + minutesBefore;

  /// Returns a short rating-fit label, or null if no badge should show.
  ///
  /// No badge for:
  /// → Combined Div.1+2 rounds (open to all by design)
  /// → Educational rounds (open to all)
  /// → ICPC rounds (open to all)
  /// → Unknown contest type
  ///
  /// Three tiers for pure-division rounds:
  /// "Matches your rating" — solidly within the division's range (green).
  /// "Might be tough"      — within 300 points outside the range,
  ///                          a real stretch worth attempting (amber).
  /// "Too tough"           — far outside the range, honest signal
  ///                          rather than silence (red).
  static String? ratingFitLabel(String contestName, int userRating) {
    final n = contestName.toLowerCase();
    final isCombined = n.contains('div. 1') && n.contains('div. 2');
    final isEducational = n.contains('educational');
    final isIcpc = n.contains('icpc');
    if (isCombined || isEducational || isIcpc) return 'Open to all';

    int? min;
    int? max;
    if (n.contains('div. 4')) {
      max = 1400;
    } else if (n.contains('div. 3')) {
      max = 1600;
    } else if (n.contains('div. 2')) {
      min = 1200;
      max = 2100;
    } else if (n.contains('div. 1')) {
      min = 1900;
    } else {
      return null;
    }

    final fitsLow = min == null || userRating >= min;
    final fitsHigh = max == null || userRating <= max;
    if (fitsLow && fitsHigh) return 'Matches your rating';

    const stretchMargin = 300;
    final closeLow = min != null && userRating >= min - stretchMargin;
    final closeHigh = max != null && userRating <= max + stretchMargin;
    if ((min == null || closeLow) && (max == null || closeHigh)) {
      return 'Might be tough';
    }

    return 'Too tough';
  }

  /// True if [label] is the "stretch" tier — amber styling.
  static bool isStretchFit(String label) => label == 'Might be tough';

  /// True if [label] is the "far outside range" tier — red styling.
  static bool isTooToughFit(String label) => label == 'Too tough';

  /// True if [label] is the neutral "open to everyone" tier.
  static bool isOpenToAll(String label) => label == 'Open to all';
}
