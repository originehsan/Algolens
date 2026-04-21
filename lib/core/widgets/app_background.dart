import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';

// ──────────────────────────────
// APP BACKGROUND
// Base background for all screens
// ──────────────────────────────

/// Deep navy background with
/// 2 blue ambient orbs
///
/// Rules:
/// → Deep navy base ONLY
/// → Exactly 2 blue orbs
/// → NO purple — ever
/// → Always wraps child
/// → Used via PageWrapper
///
/// Usage:
/// AppBackground(
///   child: YourScreen(),
/// )
class AppBackground extends StatelessWidget {
  const AppBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ──────────────────────
        // BASE LAYER
        // Deep navy fill
        // ──────────────────────
        Positioned.fill(child: const ColoredBox(color: AppColors.bgBase)),

        // ──────────────────────
        // ORB 1 — TOP RIGHT
        // Large blue ambient glow
        // ──────────────────────
        Positioned(
          top: -120.h,
          right: -100.w,
          child: _GlowOrb(
            size: 380.r,
            color: AppColors.primary.withValues(alpha: 0.12),
          ),
        ),

        // ──────────────────────
        // ORB 2 — BOTTOM LEFT
        // Smaller blue accent orb
        // ──────────────────────
        Positioned(
          bottom: -140.h,
          left: -80.w,
          child: _GlowOrb(
            size: 300.r,
            color: AppColors.primary.withValues(alpha: 0.08),
          ),
        ),

        // ──────────────────────
        // CONTENT LAYER
        // Child renders on top
        // ──────────────────────
        Positioned.fill(child: child),
      ],
    );
  }
}

// ──────────────────────────────
// GLOW ORB
// Soft radial gradient circle
// ──────────────────────────────

/// Soft ambient glow orb
///
/// Radial gradient from
/// color → transparent
/// Creates depth effect
class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0.0)],
            stops: const [0.0, 1.0],
          ),
        ),
      ),
    );
  }
}
