import 'package:algolens/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Usage:
/// AuthBottomLink(
///   prompt: 'Already have an account?',
///   action: 'Sign In',
///   onTap: onSignIn,
/// )
class AuthBottomLink extends StatelessWidget {
  const AuthBottomLink({
    super.key,
    required this.prompt,
    required this.action,
    required this.onTap,
  });

  final String prompt;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$prompt ',
          style: GoogleFonts.inter(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: Colors.white.withValues(
              alpha: 0.55,
            ),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            action,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}