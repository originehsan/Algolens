import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/glass_card.dart';

// ──────────────────────────────
// STAT CARD
// Small metric display card
// ──────────────────────────────

/// Small metric card widget
///
/// Shows:
/// → Icon with color
/// → Value (large number)
/// → Label (small text)
///
/// Used in home screen
/// stats row (3 cards):
/// → Problems Solved
/// → Contests
/// → Streak Days
///
/// Usage:
/// StatCard(
///   icon: Icons.check_circle_rounded,
///   iconColor: AppColors.success,
///   value: '1842',
///   label: 'Solved',
/// )
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 14.h,
      ),
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ──────────────────
          // ICON
          // ──────────────────

          Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(
                8.r,
              ),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 16.r,
            ),
          ),

          SizedBox(height: 10.h),

          // ──────────────────
          // VALUE
          // Large bold number
          // ──────────────────

          Text(
            value,
            style: AppTextStyles.h2.copyWith(
              color: Colors.white.withValues(
                alpha: 0.95,
              ),
            ),
          ),

          SizedBox(height: 2.h),

          // ──────────────────
          // LABEL
          // Small descriptor
          // ──────────────────

          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: Colors.white.withValues(
                alpha: 0.55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────
// STAT CARD SHIMMER
// Loading placeholder
// ──────────────────────────────

/// Shimmer placeholder for StatCard
///
/// Usage:
/// StatCardShimmer()
class StatCardShimmer extends StatelessWidget {
  const StatCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCardShimmer(
      height: 100.h,
    );
  }
}
