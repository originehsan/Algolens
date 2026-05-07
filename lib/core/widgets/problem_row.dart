import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/glass_card.dart';

// ──────────────────────────────
// PROBLEM ROW
// Problem list item widget
// ──────────────────────────────

/// Problem list item
///
/// Features:
/// → Problem name + index
/// → Rating chip
/// → Tags row (scrollable)
/// → Verdict badge
/// → CF link tap
///
/// Usage:
/// ProblemRow(
///   contestId: 1991,
///   index: 'D',
///   name: 'Minimize the Diff',
///   rating: 1800,
///   tags: ['dp', 'greedy'],
///   verdict: 'WRONG_ANSWER',
///   url: 'https://...',
/// )
class ProblemRow extends StatelessWidget {
  const ProblemRow({
    super.key,
    required this.contestId,
    required this.index,
    required this.name,
    required this.rating,
    required this.tags,
    required this.url,
    this.verdict,
    this.onTap,
    this.trailing,
    this.margin,
  });

  final int contestId;
  final String index;
  final String name;
  final int rating;
  final List<String> tags;
  final String url;
  final String? verdict;
  final VoidCallback? onTap;
  final Widget? trailing;
  final EdgeInsetsGeometry? margin;

  // ────────────────────────────
  // RATING COLOR
  // CF rating color scale
  // ────────────────────────────

  Color get _ratingColor {
    if (rating >= 3000) {
      return const Color(0xFFFF0000);
    }
    if (rating >= 2600) {
      return const Color(0xFFFF0000);
    }
    if (rating >= 2400) {
      return const Color(0xFFFF3333);
    }
    if (rating >= 2100) {
      return const Color(0xFFFF8C00);
    }
    if (rating >= 1900) {
      return const Color(0xFFAA00AA);
    }
    if (rating >= 1600) {
      return const Color(0xFF0000FF);
    }
    if (rating >= 1400) {
      return const Color(0xFF03A89E);
    }
    if (rating >= 1200) {
      return AppColors.success;
    }
    return Colors.white.withValues(
      alpha: 0.60,
    );
  }

  // ────────────────────────────
  // VERDICT COLOR + LABEL
  // ────────────────────────────

  Color get _verdictColor {
    if (verdict == null) {
      return Colors.transparent;
    }
    return switch (verdict!) {
      'OK' => AppColors.success,
      'WRONG_ANSWER' => AppColors.danger,
      'TIME_LIMIT_EXCEEDED' => AppColors.warning,
      'MEMORY_LIMIT_EXCEEDED' => AppColors.warning,
      'RUNTIME_ERROR' => AppColors.danger,
      _ => Colors.white.withValues(
          alpha: 0.50,
        ),
    };
  }

  String get _verdictLabel {
    if (verdict == null) return '';
    return switch (verdict!) {
      'OK' => 'AC',
      'WRONG_ANSWER' => 'WA',
      'TIME_LIMIT_EXCEEDED' => 'TLE',
      'MEMORY_LIMIT_EXCEEDED' => 'MLE',
      'RUNTIME_ERROR' => 'RE',
      _ => verdict!.substring(0, 2),
    };
  }

  // ────────────────────────────
  // OPEN CF LINK
  // ────────────────────────────

  Future<void> _openLink() async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: margin,
      onTap: onTap ?? _openLink,
      padding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 12.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ──────────────────
          // PROBLEM INDEX
          // Letter label
          // ──────────────────

          Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(
                8.r,
              ),
            ),
            child: Center(
              child: Text(
                index,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // ──────────────────
          // PROBLEM DETAILS
          // Name + tags
          // ──────────────────

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // NAME + RATING ROW
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: AppTextStyles.body.copyWith(
                          color: Colors.white.withValues(
                            alpha: 0.90,
                          ),
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),

                    // RATING CHIP
                    _RatingChip(
                      rating: rating,
                      color: _ratingColor,
                    ),
                  ],
                ),

                SizedBox(height: 6.h),

                // TAGS ROW
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: tags
                        .map(
                          (tag) => Padding(
                            padding: EdgeInsets.only(
                              right: 4.w,
                            ),
                            child: _TagChip(
                              label: tag,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          // ──────────────────
          // RIGHT SIDE
          // Verdict + link
          // OR trailing widget
          // ──────────────────

          if (trailing != null)
            trailing!
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // VERDICT BADGE
                if (verdict != null)
                  _VerdictBadge(
                    label: _verdictLabel,
                    color: _verdictColor,
                  ),

                SizedBox(height: 6.h),

                // CF LINK ICON
                GestureDetector(
                  onTap: _openLink,
                  child: Icon(
                    Icons.open_in_new_rounded,
                    color: Colors.white.withValues(
                      alpha: 0.40,
                    ),
                    size: 16.r,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// ──────────────────────────────
// RATING CHIP
// ──────────────────────────────

class _RatingChip extends StatelessWidget {
  const _RatingChip({
    required this.rating,
    required this.color,
  });

  final int rating;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 6.w,
        vertical: 2.h,
      ),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 0.12,
        ),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          color: color.withValues(
            alpha: 0.30,
          ),
          width: 1.0,
        ),
      ),
      child: Text(
        '$rating',
        style: AppTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 10.sp,
        ),
      ),
    );
  }
}

// ──────────────────────────────
// TAG CHIP
// ──────────────────────────────

class _TagChip extends StatelessWidget {
  const _TagChip({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 6.w,
        vertical: 2.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(
          alpha: 0.06,
        ),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          color: Colors.white.withValues(
            alpha: 0.10,
          ),
          width: 1.0,
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: Colors.white.withValues(alpha: 0.60),
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ──────────────────────────────
// VERDICT BADGE
// ──────────────────────────────

class _VerdictBadge extends StatelessWidget {
  const _VerdictBadge({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 6.w,
        vertical: 2.h,
      ),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 0.15,
        ),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          color: color.withValues(
            alpha: 0.35,
          ),
          width: 1.0,
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 10.sp,
        ),
      ),
    );
  }
}
