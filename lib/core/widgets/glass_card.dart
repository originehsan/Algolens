import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsets? padding;
  final double? blur;
  final VoidCallback? onTap;
  final bool animate;

  const GlassCard({
    super.key,
    required this.child,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.blur,
    this.onTap,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    final card = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 20.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blur ?? 30.0,
          sigmaY: blur ?? 30.0,
        ),
        child: Container(
          padding: padding ?? EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 20.r),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.18),
                Colors.white.withOpacity(0.08),
              ],
            ),
            border: Border.all(
              color: borderColor ?? Colors.white.withOpacity(0.25),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );

    final wrappedCard = onTap != null
        ? GestureDetector(
            onTap: onTap,
            child: card,
          )
        : card;

    if (animate) {
      return wrappedCard
          .animate()
          .fadeIn(
            duration: 400.ms,
            curve: Curves.easeOut,
          )
          .slideY(
            begin: 0.08,
            end: 0,
            duration: 400.ms,
            curve: Curves.easeOut,
          );
    }

    return wrappedCard;
  }
}
