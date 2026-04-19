import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';

/// AlgoLens Decoration System
///
/// RULES:
/// → ALL cards must have glow shadow
/// → ALL cards must have depth shadow
/// → No colored backgrounds for
///   danger/warning cards
/// → Use border color change only
/// → All values from AppColors

class AppDecorations {
  AppDecorations._();

  // ──────────────────────────────
  // GLASS CARD DECORATIONS
  // ──────────────────────────────

  /// Default glass card
  /// Used for most cards
  static BoxDecoration glassCard({
    Color? borderColor,
    Color? glowColor,
    double? radius,
  }) =>
      BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.glassBg1,
            AppColors.glassBg2,
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
          BoxShadow(
            color: AppColors.glassShadow,
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
        ],
      );

  /// Primary blue glass card
  /// Used for rating card, key metrics
  static BoxDecoration glassCardPrimary({
    double? radius,
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
          color: AppColors.borderPrimary,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(
          radius ?? 20.r,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.22),
            blurRadius: 24,
            spreadRadius: -2,
            offset: Offset.zero,
          ),
          BoxShadow(
            color: AppColors.glassShadow,
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
        ],
      );

  /// Success glass card
  /// Used for verified, AC states
  /// Border only — no colored bg
  static BoxDecoration glassCardSuccess({
    double? radius,
  }) =>
      BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.glassBg1,
            AppColors.glassBg2,
          ],
        ),
        border: Border.all(
          color: AppColors.borderSuccess,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(
          radius ?? 20.r,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.glowSuccess,
            blurRadius: 16,
            spreadRadius: -2,
            offset: Offset.zero,
          ),
          BoxShadow(
            color: AppColors.glassShadow,
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
        ],
      );

  /// Danger glass card
  /// Used for errors, WA verdict
  /// Border only — no colored bg
  static BoxDecoration glassCardDanger({
    double? radius,
  }) =>
      BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.glassBg1,
            AppColors.glassBg2,
          ],
        ),
        border: Border.all(
          color: AppColors.borderDanger,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(
          radius ?? 20.r,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.glowDanger,
            blurRadius: 16,
            spreadRadius: -2,
            offset: Offset.zero,
          ),
          BoxShadow(
            color: AppColors.glassShadow,
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
        ],
      );

  /// Warning glass card
  /// Used for moderate difficulty
  /// Border only — no colored bg
  static BoxDecoration glassCardWarning({
    double? radius,
  }) =>
      BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.glassBg1,
            AppColors.glassBg2,
          ],
        ),
        border: Border.all(
          color: AppColors.borderWarning,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(
          radius ?? 20.r,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.glowWarning,
            blurRadius: 16,
            spreadRadius: -2,
            offset: Offset.zero,
          ),
          BoxShadow(
            color: AppColors.glassShadow,
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
        ],
      );

  /// Premium locked card
  /// Used for SMS/Voice features
  static BoxDecoration glassCardPremium({
    double? radius,
  }) =>
      BoxDecoration(
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
          radius ?? 18.r,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.glowWarning,
            blurRadius: 16,
            spreadRadius: -2,
            offset: Offset.zero,
          ),
          BoxShadow(
            color: AppColors.glassShadow,
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      );

  // ──────────────────────────────
  // INPUT FIELD DECORATIONS
  // ──────────────────────────────

  /// Default input field
  static BoxDecoration inputField({
    bool focused = false,
    bool hasError = false,
    bool hasSuccess = false,
  }) {
    Color borderColor;
    Color? glowColor;

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
      glowColor = null;
    }

    return BoxDecoration(
      color: Colors.white.withValues(alpha: focused ? 0.09 : 0.07),
      border: Border.all(
        color: borderColor,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(12.r),
      boxShadow: glowColor != null
          ? [
              BoxShadow(
                color: glowColor,
                blurRadius: 14,
                spreadRadius: -3,
                offset: Offset.zero,
              ),
            ]
          : null,
    );
  }

  // ──────────────────────────────
  // BUTTON DECORATIONS
  // ──────────────────────────────

  /// Primary button decoration
  static BoxDecoration primaryButton() => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryDark.withValues(alpha: 0.90),
            AppColors.primaryDeep.withValues(alpha: 0.94),
          ],
        ),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.48),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.32),
            blurRadius: 20,
            spreadRadius: -4,
            offset: const Offset(0, 4),
          ),
        ],
      );

  /// Outline button decoration
  static BoxDecoration outlineButton() => BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.16),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(14.r),
      );

  /// Ghost button — no background
  static BoxDecoration ghostButton() => BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
      );

  // ──────────────────────────────
  // NOTIFICATION BANNER
  // ──────────────────────────────

  /// Notification permission banner
  static BoxDecoration notifBanner({
    Color? color,
  }) =>
      BoxDecoration(
        color: (color ?? AppColors.primary).withValues(alpha: 0.10),
        border: Border.all(
          color: (color ?? AppColors.primary).withValues(alpha: 0.25),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: (color ?? AppColors.primary).withValues(alpha: 0.12),
            blurRadius: 16,
            spreadRadius: -2,
            offset: Offset.zero,
          ),
        ],
      );

  // ──────────────────────────────
  // CHIP DECORATIONS
  // ──────────────────────────────

  /// Chip decoration by type
  static BoxDecoration chip({
    required String type,
  }) {
    switch (type) {
      case 'primary':
        return BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.14),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.35),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(20.r),
        );
      case 'success':
        return BoxDecoration(
          color: AppColors.success.withValues(alpha: 0.12),
          border: Border.all(
            color: AppColors.success.withValues(alpha: 0.30),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(20.r),
        );
      case 'danger':
        return BoxDecoration(
          color: AppColors.danger.withValues(alpha: 0.12),
          border: Border.all(
            color: AppColors.danger.withValues(alpha: 0.30),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(20.r),
        );
      case 'warning':
        return BoxDecoration(
          color: AppColors.warning.withValues(alpha: 0.10),
          border: Border.all(
            color: AppColors.warning.withValues(alpha: 0.28),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(20.r),
        );
      default:
        return BoxDecoration(
          color: Colors.white.withValues(alpha: 0.07),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.14),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(20.r),
        );
    }
  }

  // ──────────────────────────────
  // HELPER — card by type string
  // ──────────────────────────────

  /// Get card decoration by type
  /// type: default/primary/success/
  ///       danger/warning/premium
  static BoxDecoration cardByType(
    String type, {
    double? radius,
  }) {
    switch (type) {
      case 'primary':
        return glassCardPrimary(
          radius: radius,
        );
      case 'success':
        return glassCardSuccess(
          radius: radius,
        );
      case 'danger':
        return glassCardDanger(
          radius: radius,
        );
      case 'warning':
        return glassCardWarning(
          radius: radius,
        );
      case 'premium':
        return glassCardPremium(
          radius: radius,
        );
      default:
        return glassCard(
          radius: radius,
        );
    }
  }
}
