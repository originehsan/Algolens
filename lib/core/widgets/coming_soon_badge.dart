import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_text_styles.dart';

// ──────────────────────────────
// COMING SOON BADGE
// Locked feature chip
// ──────────────────────────────

/// "Coming Soon" badge widget
///
/// Used for locked/premium
/// features not yet available
///
/// Usage:
/// ComingSoonBadge()
///
/// ComingSoonBadge(
///   label: 'Premium',
/// )
class ComingSoonBadge extends StatelessWidget {
  const ComingSoonBadge({
    super.key,
    this.label = 'Coming Soon',
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 3.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFD700).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: const Color(0xFFFFD700).withValues(alpha: 0.35),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.lock_rounded,
            color: const Color(0xFFFFD700),
            size: 10.r,
          ),
          SizedBox(width: 4.w),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: const Color(
                0xFFFFD700,
              ),
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
