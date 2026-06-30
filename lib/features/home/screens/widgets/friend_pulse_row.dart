import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';

/// Single leaderboard row for home
/// Friends Pulse section (S5)
/// Used only in home screen
class FriendPulseRow extends StatelessWidget {
  const FriendPulseRow({
    super.key,
    required this.rank,
    required this.handle,
    required this.rating,
    required this.tier,
    required this.isMe,
    required this.showDivider,
  });

  final int rank;
  final String handle;
  final int rating;
  final String tier;
  final bool isMe;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final rankColor = AppColors.rankColor(tier);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          decoration: BoxDecoration(
            color: isMe
                ? AppColors.primary.withValues(alpha: 0.08)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              // Rank number
              SizedBox(
                width: 24.w,
                child: Text(
                  '#$rank',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: isMe ? AppColors.primary : AppColors.textMuted,
                  ),
                ),
              ),
              Gap(10.w),

              // Avatar circle
              Container(
                width: 32.r,
                height: 32.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: rankColor.withValues(alpha: 0.15),
                  border: Border.all(
                    color: rankColor.withValues(alpha: 0.40),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    handle.isNotEmpty ? handle[0].toUpperCase() : '?',
                    style: AppTextStyles.captionBold.copyWith(
                      color: rankColor,
                    ),
                  ),
                ),
              ),
              Gap(10.w),

              // Handle + tier
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isMe ? '$handle (you)' : handle,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: isMe
                            ? AppColors.primary
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      tier,
                      style: AppTextStyles.caption.copyWith(
                        color: rankColor.withValues(alpha: 0.80),
                      ),
                    ),
                  ],
                ),
              ),

              // Rating
              Text(
                '$rating',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: isMe
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 0.5,
            color: AppColors.divider,
            indent: 16.w,
            endIndent: 16.w,
          ),
      ],
    );
  }
}
