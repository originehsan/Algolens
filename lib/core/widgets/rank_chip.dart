import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';

// ──────────────────────────────
// RANK CHIP
// Rank badge pill widget
// ──────────────────────────────

/// Compact rank badge
///
/// Color derived from rank string
/// via AppColors.rankColor()
///
/// Used on:
/// → Profile screen header
/// → Friends list items
/// → Leaderboard rows
///
/// Usage:
/// RankChip(
///   rank: 'specialist',
/// )
///
/// RankChip(
///   rank: 'legendary grandmaster',
///   compact: true,
/// )
class RankChip extends StatelessWidget {
  const RankChip({
    super.key,
    required this.rank,
    this.compact = false,
  });

  final String rank;

  /// compact = true shows
  /// abbreviated rank label
  final bool compact;

  // ────────────────────────────
  // RANK COLOR
  // From AppColors
  // ────────────────────────────

  Color get _color => AppColors.rankColor(rank);

  // ────────────────────────────
  // DISPLAY LABEL
  // Full or abbreviated
  // ────────────────────────────

  String get _label {
    if (!compact) return rank;
    return switch (rank.toLowerCase()) {
      'legendary grandmaster' => 'LGM',
      'international grandmaster' => 'IGM',
      'grandmaster' => 'GM',
      'international master' => 'IM',
      'master' => 'Master',
      'candidate master' => 'CM',
      'expert' => 'Expert',
      'specialist' => 'Specialist',
      'pupil' => 'Pupil',
      'newbie' => 'Newbie',
      _ => rank,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 6.w : 10.w,
        vertical: compact ? 2.h : 4.h,
      ),
      decoration: BoxDecoration(
        color: _color.withValues(
          alpha: 0.15,
        ),
        borderRadius: BorderRadius.circular(
          20.r,
        ),
        border: Border.all(
          color: _color.withValues(
            alpha: 0.35,
          ),
          width: 1.0,
        ),
      ),
      child: Text(
        _label,
        style: AppTextStyles.caption.copyWith(
          color: _color,
          fontWeight: FontWeight.w600,
          fontSize: compact ? 10.sp : 11.sp,
        ),
      ),
    );
  }
}
