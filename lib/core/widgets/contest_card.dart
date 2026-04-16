import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/countdown_timer.dart';
import 'package:algolens/features/contests/data/models/contest_model.dart';

class ContestCard extends StatelessWidget {
  final Contest contest;
  final VoidCallback onReminderToggle;
  final bool isReminderSet;

  const ContestCard({
    super.key,
    required this.contest,
    required this.onReminderToggle,
    this.isReminderSet = false,
  });

  Color _getBorderColor() {
    switch (contest.suitabilityLabel) {
      case 'Good Match':
        return AppColors.success.withOpacity(0.40);
      case 'Too Hard':
        return AppColors.danger.withOpacity(0.40);
      default:
        return AppColors.warning.withOpacity(0.40);
    }
  }

  Color _getSuitabilityColor() {
    switch (contest.suitabilityLabel) {
      case 'Good Match':
        return AppColors.success;
      case 'Too Hard':
        return AppColors.danger;
      default:
        return AppColors.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    final suitabilityColor = _getSuitabilityColor();

    return GlassCard(
      borderColor: _getBorderColor(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contest type badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 3.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.30),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  contest.type,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 10.sp,
                  ),
                ),
              ),
              const Spacer(),
              // Reminder bell button
              GestureDetector(
                onTap: onReminderToggle,
                child: Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: BoxDecoration(
                    color: isReminderSet
                        ? AppColors.success.withOpacity(0.15)
                        : Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: isReminderSet
                          ? AppColors.success.withOpacity(0.40)
                          : Colors.white.withOpacity(0.15),
                      width: 1.0,
                    ),
                  ),
                  child: Icon(
                    isReminderSet
                        ? Icons.notifications_active_rounded
                        : Icons.notifications_none_rounded,
                    color:
                        isReminderSet ? AppColors.success : AppColors.textMuted,
                    size: 16.r,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          // Contest name
          Text(
            contest.name,
            style: AppTextStyles.bodyBold,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),
          // Countdown timer
          Row(
            children: [
              Icon(
                Icons.timer_outlined,
                color: AppColors.primary,
                size: 14.r,
              ),
              SizedBox(width: 4.w),
              Text(
                'Starts in ',
                style: AppTextStyles.caption,
              ),
              CountdownTimer(
                startTimeSeconds: contest.startTimeSeconds,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          // Bottom row
          Row(
            children: [
              // Suitability badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 3.h,
                ),
                decoration: BoxDecoration(
                  color: suitabilityColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: suitabilityColor.withOpacity(0.40),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  contest.suitabilityLabel,
                  style: AppTextStyles.caption.copyWith(
                    color: suitabilityColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 10.sp,
                  ),
                ),
              ),
              const Spacer(),
              // Duration
              Icon(
                Icons.access_time_rounded,
                color: AppColors.textMuted,
                size: 12.r,
              ),
              SizedBox(width: 3.w),
              Text(
                contest.formattedDuration,
                style: AppTextStyles.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
