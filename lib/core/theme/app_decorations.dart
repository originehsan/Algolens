import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';

class AppDecorations {
  AppDecorations._();

  // ── Glass card — default ──
  static BoxDecoration glassCard({
    Color? borderColor,
    Color? glowColor,
    double? radius,
  }) =>
      BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.glassHighlight,
            AppColors.glassHighlight2,
          ],
        ),
        border: Border.all(
          color: borderColor ?? AppColors.glassBorder,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(
          radius ?? 20.r,
        ),
        boxShadow: [
          // Glow on border
          BoxShadow(
            color: glowColor ?? AppColors.glowPrimary,
            blurRadius: 20,
            spreadRadius: -2,
            offset: Offset.zero,
          ),
          // Depth shadow
          const BoxShadow(
            color: AppColors.glassShadow,
            blurRadius: 40,
            offset: Offset(0, 12),
          ),
        ],
      );

  // ── Glass card strong ──
  static BoxDecoration glassCardStrong({
    Color? borderColor,
    Color? glowColor,
  }) =>
      BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary.withValues(alpha: 0.16),
            AppColors.primary.withValues(alpha: 0.08),
          ],
        ),
        border: Border.all(
          color: borderColor ?? AppColors.primary.withValues(alpha: 0.30),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(
          20.r,
        ),
        boxShadow: [
          BoxShadow(
            color: glowColor ?? AppColors.primary.withValues(alpha: 0.22),
            blurRadius: 24,
            spreadRadius: -2,
            offset: Offset.zero,
          ),
          const BoxShadow(
            color: AppColors.glassShadow,
            blurRadius: 40,
            offset: Offset(0, 12),
          ),
        ],
      );

  // ── Input field ──
  static BoxDecoration inputField({
    bool focused = false,
    bool hasError = false,
    bool hasSuccess = false,
  }) {
    Color borderColor;
    Color glowColor;

    if (hasError) {
      borderColor = AppColors.danger.withValues(alpha: 0.50);
      glowColor = AppColors.glowDanger;
    } else if (hasSuccess) {
      borderColor = AppColors.success.withValues(alpha: 0.50);
      glowColor = AppColors.glowSuccess;
    } else if (focused) {
      borderColor = AppColors.primary.withValues(alpha: 0.55);
      glowColor = AppColors.glowPrimary;
    } else {
      borderColor = AppColors.glassBorder;
      glowColor = Colors.transparent;
    }

    return BoxDecoration(
      color: Colors.white.withValues(alpha: focused ? 0.09 : 0.07),
      border: Border.all(
        color: borderColor,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(
        12.r,
      ),
      boxShadow: focused || hasError || hasSuccess
          ? [
              BoxShadow(
                color: glowColor,
                blurRadius: 14,
                spreadRadius: -3,
                offset: Offset.zero,
              )
            ]
          : null,
    );
  }

  // ── Primary button ──
  static BoxDecoration primaryButton() => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2563EB).withValues(alpha: 0.90),
            const Color(0xFF1D4ED8).withValues(alpha: 0.94),
          ],
        ),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.48),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(
          14.r,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.32),
            blurRadius: 20,
            spreadRadius: -4,
            offset: const Offset(0, 4),
          ),
        ],
      );

  // ── Outline button ──
  static BoxDecoration outlineButton() => BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.16),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(
          14.r,
        ),
      );

  // ── Premium locked card ──
  static BoxDecoration premiumCard() => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.warning.withValues(alpha: 0.10),
            AppColors.warning.withValues(alpha: 0.04),
          ],
        ),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.28),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(
          18.r,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.glowWarning,
            blurRadius: 16,
            spreadRadius: -2,
            offset: Offset.zero,
          ),
        ],
      );

  // ── Notification banner ──
  static BoxDecoration notifBanner({
    Color? color,
  }) =>
      BoxDecoration(
        color: (color ?? AppColors.primary).withValues(alpha: 0.10),
        border: Border.all(
          color: (color ?? AppColors.primary).withValues(alpha: 0.25),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(
          14.r,
        ),
        boxShadow: [
          BoxShadow(
            color: (color ?? AppColors.primary).withValues(alpha: 0.12),
            blurRadius: 16,
            spreadRadius: -2,
            offset: Offset.zero,
          ),
        ],
      );
}
