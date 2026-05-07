import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/app_button.dart';

// ──────────────────────────────
// ERROR WIDGET
// Error state UI
// ──────────────────────────────

/// Error state widget
///
/// Shows when a request fails
///
/// Usage:
/// AppErrorWidget(
///   message: 'Failed to load',
///   onRetry: () => ref
///     .invalidate(myProvider),
/// )
class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 32.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ──────────────────
            // ERROR ICON
            // ──────────────────

            Container(
              width: 72.r,
              height: 72.r,
              decoration: BoxDecoration(
                color: AppColors.danger.withValues(
                  alpha: 0.08,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.danger.withValues(
                    alpha: 0.20,
                  ),
                  width: 1.0,
                ),
              ),
              child: Icon(
                Icons.error_outline_rounded,
                color: AppColors.danger.withValues(
                  alpha: 0.80,
                ),
                size: 32.r,
              ),
            ),

            SizedBox(height: 16.h),

            // ──────────────────
            // ERROR MESSAGE
            // ──────────────────

            Text(
              'Something went wrong',
              style: AppTextStyles.h3.copyWith(
                color: Colors.white.withValues(
                  alpha: 0.80,
                ),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 6.h),

            Text(
              message,
              style: AppTextStyles.caption.copyWith(
                color: Colors.white.withValues(
                  alpha: 0.50,
                ),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 24.h),

            // ──────────────────
            // RETRY BUTTON
            // ──────────────────

            AppButton(
              label: 'Try Again',
              onTap: onRetry,
              type: AppButtonType.outline,
              width: 160.w,
              icon: Icons.refresh_rounded,
            ),
          ],
        ),
      ),
    );
  }
}
