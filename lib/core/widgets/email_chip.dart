import 'package:algolens/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Email address shown in a mono styled chip.
/// Used on email verification and
/// forgot password success screens.
class EmailChip extends StatelessWidget {
  const EmailChip({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(
          alpha: 0.08,
        ),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.primary.withValues(
            alpha: 0.20,
          ),
          width: 1,
        ),
      ),
      child: Text(
        email,
        style: GoogleFonts.jetBrainsMono(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.primary,
        ),
      ),
    );
  }
}