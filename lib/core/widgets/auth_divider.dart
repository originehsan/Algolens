import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Fade-gradient divider with a centered label.
/// Used at the bottom of auth screens above
/// the secondary navigation link.
class AuthDivider extends StatelessWidget {
  const AuthDivider({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
       const  _FadeLine(leftToRight: true),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            label,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 9.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.25),
              letterSpacing: 1.5,
            ),
          ),
        ),
      const   _FadeLine(leftToRight: false),
      ],
    );
  }
}

class _FadeLine extends StatelessWidget {
  const _FadeLine({required this.leftToRight});

  final bool leftToRight;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: leftToRight
                ? [
                    Colors.transparent,
                    Colors.white.withValues(alpha: 0.08),
                  ]
                : [
                    Colors.white.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
          ),
        ),
      ),
    );
  }
}