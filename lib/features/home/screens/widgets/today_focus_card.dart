import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:algolens/core/constants/app_constants.dart';
import 'package:algolens/core/constants/app_strings.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/glass_card.dart';

/// Today's Focus card for home screen S6
/// Shows worst weak topic with AC% bar
class TodayFocusCard extends StatelessWidget {
  const TodayFocusCard({
    super.key,
    required this.tag,
    required this.acRate,
    required this.solvedCount,
    required this.totalAttempts,
    required this.onTap,
  });

  final String tag;
  final double acRate;
  final int solvedCount;
  final int totalAttempts;
  final VoidCallback onTap;

  Color get _acColor {
    if (acRate < 25) return AppColors.danger;
    if (acRate < AppConstants.weakTopicAcThreshold) return AppColors.warning;
    return AppColors.primary;
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GlassCard(
        type: GlassCardType.warning,
        padding: EdgeInsets.all(18.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // AC rate badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 3.h,
                  ),
                  decoration: BoxDecoration(
                    color: _acColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(
                      color: _acColor.withValues(alpha: 0.30),
                      width: 0.8,
                    ),
                  ),
                  child: Text(
                    '${acRate.toStringAsFixed(1)}% AC',
                    style: AppTextStyles.label.copyWith(
                      color: _acColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.trending_up_rounded,
                  color: AppColors.warning.withValues(alpha: 0.70),
                  size: 18.r,
                ),
              ],
            ),

            Gap(12.h),

            Text(
              tag,
              style: AppTextStyles.h4.copyWith(
                color: AppColors.textPrimary,
              ),
            ),

            Gap(10.h),

            // AC progress bar (animated)
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: acRate / 100),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              builder: (_, v, __) => ClipRRect(
                borderRadius: BorderRadius.circular(3.r),
                child: LinearProgressIndicator(
                  value: v,
                  minHeight: 5.h,
                  backgroundColor: Colors.white.withValues(alpha: 0.08),
                  valueColor: AlwaysStoppedAnimation<Color>(_acColor),
                ),
              ),
            ),

            Gap(10.h),

            Row(
              children: [
                Text(
                  '$solvedCount solved · $totalAttempts attempts',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.40),
                        width: 1.0,
                      ),
                    ),
                    child: Text(
                      AppStrings.practice,
                      style: AppTextStyles.captionBold.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
