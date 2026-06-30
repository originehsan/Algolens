
import 'package:flutter/material.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';

/// App-wide snackbar shortcuts
///
/// Usage:
/// SnackbarHelper.success(context, 'Reminder set');
/// SnackbarHelper.error(context, 'Handle not found');
///
/// Renders with the same glassmorphism treatment as GlassCard —
/// blurred, opaque-enough backing so text stays legible over any
/// content behind it, with a colored tint + border for semantics.
abstract class SnackbarHelper {
  SnackbarHelper._();

  static void success(BuildContext context, String message) =>
      _show(context, message, AppColors.success);

  static void error(BuildContext context, String message) =>
      _show(context, message, AppColors.danger);

  static void info(BuildContext context, String message) =>
      _show(context, message, AppColors.primary);

  static void warning(BuildContext context, String message) =>
      _show(context, message, AppColors.warning);

  static void _show(
    BuildContext context,
    String message,
    Color color,
  ) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          content: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: AppColors.bgCenter,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: color.withValues(alpha: 0.40),
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.18),
                  blurRadius: 18,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.30),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.50),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    message,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white.withValues(alpha: 0.95),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
  }
}
