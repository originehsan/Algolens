import 'package:algolens/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Inline auth error — shown below the form card.
/// For field-level errors use [AuthField.errorText].
/// For feature-screen errors use AppErrorWidget in core/.
class AuthErrorWidget extends StatelessWidget {
  const AuthErrorWidget({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.error_outline_rounded,
          size: 14.r,
          color: AppColors.danger,
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            message,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.danger,
            ),
          ),
        ),
      ],
    );
  }
}