import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/features/auth/screens/widgets/magnus_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Shared header for all auth screens.
/// Logo + overline + optional subtext.
///
/// For extra content (EmailChip, headline etc)
/// add directly in the screen hero widget.
///
/// Usage:
/// AuthHeader(
///   overline: 'CREATE MAGNUS ID',
/// )
///
/// AuthHeader(
///   overline: 'MAGNUS ACCESS',
///   subtext: 'Continue your climb.',
/// )
class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.overline,
    this.subtext,
    this.logoSize = 56,
  });

  final String overline;
  final String? subtext;
  final double logoSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Logo
        MagnusLogo(size: logoSize),

        SizedBox(height: 16.h),

        // Overline — always shown
        Text(
          overline,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.primary.withValues(
              alpha: 0.88,
            ),
            letterSpacing: 2.0,
          ),
          textAlign: TextAlign.center,
        ),

        // Subtext — optional
        if (subtext != null) ...[
          SizedBox(height: 8.h),
          Text(
            subtext!,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(
                alpha: 0.55,
              ),
              height: 1.55,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}