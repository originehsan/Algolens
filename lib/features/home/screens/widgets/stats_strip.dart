import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:algolens/core/constants/app_strings.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/features/profile/data/models/profile_model.dart';

/// Single merged stats card for home screen Section 3 —
/// solved / contests / streak shown side-by-side inside one
/// card, separated by vertical hairline dividers, rather than
/// three separate cards.
class StatsStrip extends StatelessWidget {
  const StatsStrip({super.key, required this.profile});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GlassCard(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
        child: Row(
          children: [
            Expanded(
              child: _StatCell(
                label: AppStrings.solved,
                value: '${profile.problemsSolved}',
                accent: AppColors.success,
              ),
            ),
            _VerticalDivider(),
            Expanded(
              child: _StatCell(
                label: AppStrings.contests,
                value: '${profile.contestsParticipated}',
                accent: AppColors.primary,
              ),
            ),
            _VerticalDivider(),
            Expanded(
              child: _StatCell(
                label: AppStrings.streak,
                value: '${profile.streakDays}',
                accent: AppColors.warning,
                highlighted: profile.streakDays > 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.label,
    required this.value,
    required this.accent,
    this.highlighted = false,
  });

  final String label;
  final String value;
  final Color accent;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: highlighted ? accent : AppColors.textPrimary,
            height: 1.1,
          ),
        ),
        Gap(4.h),
        Text(
          label,
          style: AppTextStyles.label.copyWith(color: AppColors.textMuted),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 32.h,
      color: Colors.white.withValues(alpha: 0.10),
    );
  }
}