import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:algolens/core/constants/app_strings.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/utils/rating_utils.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/progress_bar_widget.dart';
import 'package:algolens/core/widgets/rank_chip.dart';
import 'package:algolens/features/home/data/models/home_model.dart';
import 'package:algolens/features/profile/data/models/profile_model.dart';

/// Rating hero card for home screen Section 2
/// Shows: rating, peak, delta, rank, readiness bar
class RatingHeroCard extends StatelessWidget {
  const RatingHeroCard({
    super.key,
    required this.profile,
    required this.readinessAsync,
    required this.deltaAsync,
  });

  final ProfileModel profile;
  final AsyncValue<ReadinessScore> readinessAsync;
  final AsyncValue<RatingDelta?> deltaAsync;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GlassCard(
        type: GlassCardType.primary,
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppStrings.cfRating, style: AppTextStyles.label),
                      Gap(6.h),
                      Text(
                        '${profile.rating}',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 38.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RankChip(rank: profile.rank),
                    Gap(8.h),
                    deltaAsync.when(
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => const SizedBox.shrink(),
                      data: (delta) {
                        if (delta == null) return const SizedBox.shrink();
                        return _DeltaBadge(delta: delta);
                      },
                    ),
                  ],
                ),
              ],
            ),

            Gap(8.h),

            // Peak rating
            Row(
              children: [
                Text(
                  '${AppStrings.peak}  ',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
                Text(
                  '${profile.maxRating}',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),

            Gap(16.h),

            // Readiness bar
            readinessAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
              data: (r) => _ReadinessBar(readiness: r),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeltaBadge extends StatelessWidget {
  const _DeltaBadge({required this.delta});
  final RatingDelta delta;

  @override
  Widget build(BuildContext context) {
    final color = delta.isPositive ? AppColors.success : AppColors.danger;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: color.withValues(alpha: 0.30),
          width: 1.0,
        ),
      ),
      child: Text(
        delta.formatted,
        style: GoogleFonts.jetBrainsMono(
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class _ReadinessBar extends StatelessWidget {
  const _ReadinessBar({required this.readiness});
  final ReadinessScore readiness;

  @override
  Widget build(BuildContext context) {
    final color = RatingUtils.readinessColor(readiness.score);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              readiness.label,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${readiness.score}%',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
        Gap(8.h),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: readiness.score / 100),
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutCubic,
          builder: (_, v, __) => ProgressBarWidget(
            value: v,
            color: color,
          ),
        ),
      ],
    );
  }
}
