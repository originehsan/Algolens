import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';

// ──────────────────────────────
// SECTION HEADER
// Title + optional See All
// ──────────────────────────────

/// Section header widget
///
/// Used at top of every
/// content section
///
/// Usage:
/// SectionHeader(
///   title: 'Upcoming Contests',
/// )
///
/// SectionHeader(
///   title: 'Friends',
///   actionLabel: 'See all',
///   onAction: () => context
///     .push(RoutePaths.friends),
/// )
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ──────────────────────
        // TITLE
        // ──────────────────────

        Text(
          title,
          style: AppTextStyles.h3,
        ),

        // ──────────────────────
        // SEE ALL ACTION
        // Only if provided
        // ──────────────────────

        if (actionLabel != null && onAction != null)
          GestureDetector(
            onTap: onAction,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  actionLabel!,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 2.w),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.primary,
                  size: 10.r,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
