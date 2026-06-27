import 'package:algolens/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

const _labels = ['Weak', 'Fair', 'Good', 'Strong'];

const _colors = [
  AppColors.danger,
  AppColors.warning,
  AppColors.primary,
  AppColors.success,
];

/// 4-segment password strength bar.
/// [strength] is 0–4. Pass 0 to hide the label.
/// Only render this widget when password is non-empty.
class PasswordStrength extends StatelessWidget {
  const PasswordStrength({
    super.key,
    required this.strength,
  });

  final int strength;

  @override
  Widget build(BuildContext context) {
    final hasStrength = strength > 0;
    final label = hasStrength ? _labels[strength - 1] : '';
    final color = hasStrength
        ? _colors[strength - 1]
        : Colors.transparent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Segments ────────────────
        Row(
          children: List.generate(4, (i) {
            final filled = i < strength;

            return Expanded(
              child: AnimatedContainer(
                duration: Duration(
                  milliseconds: 200 + (i * 60),
                ),
                height: 3.h,
                margin: EdgeInsets.only(
                  right: i < 3 ? 4.w : 0,
                ),
                decoration: BoxDecoration(
                  color: filled
                      ? color
                      : Colors.white.withValues(
                          alpha: 0.12,
                        ),
                  borderRadius:
                      BorderRadius.circular(2.r),
                ),
              ),
            );
          }),
        ),

        // ── Strength label ───────────
        if (hasStrength) ...[
          SizedBox(height: 4.h),
          Text(
            label,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ],
    );
  }
}