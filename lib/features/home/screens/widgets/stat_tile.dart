import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/glass_card.dart';

/// Single stat tile for home stats row
/// Used only inside home_screen → stays
/// in features/home/screens/widgets/
class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.accent,
    this.highlighted = false,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color accent;

  /// true = value rendered in accent color
  /// Used for streak when streak > 0
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GlassCard(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 14.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: accent.withValues(alpha: 0.80),
              size: 18.r,
            ),
            Gap(8.h),
            Text(
              value,
              style: GoogleFonts.jetBrainsMono(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: highlighted ? accent : AppColors.textPrimary,
                height: 1.1,
              ),
            ),
            Gap(3.h),
            Text(
              label,
              style: AppTextStyles.label.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
