import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/app_button.dart';

// ──────────────────────────────
// EMPTY WIDGET
// No data state UI
// ──────────────────────────────

/// Empty state widget
///
/// Shows when list/data is empty
///
/// Usage:
/// EmptyWidget(
///   icon: Icons.inbox_rounded,
///   message: 'No contests found',
/// )
///
/// EmptyWidget(
///   icon: Icons.people_outline,
///   message: 'No friends yet',
///   actionLabel: 'Add Friend',
///   onAction: () => ...,
/// )
class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.icon,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.subtitle,
  });

  final IconData icon;
  final String message;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

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
            // ICON
            // ──────────────────

            Container(
              width: 72.r,
              height: 72.r,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(
                  alpha: 0.08,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withValues(
                    alpha: 0.15,
                  ),
                  width: 1.0,
                ),
              ),
              child: Icon(
                icon,
                color: AppColors.primary.withValues(
                  alpha: 0.60,
                ),
                size: 32.r,
              ),
            ),

            SizedBox(height: 16.h),

            // ──────────────────
            // MESSAGE
            // ──────────────────

            Text(
              message,
              style: AppTextStyles.h3.copyWith(
                color: Colors.white.withValues(
                  alpha: 0.70,
                ),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

            // ──────────────────
            // SUBTITLE
            // ──────────────────

            if (subtitle != null) ...[
              SizedBox(height: 6.h),
              Text(
                subtitle!,
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white.withValues(
                    alpha: 0.50,
                  ),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],

            // ──────────────────
            // ACTION BUTTON
            // ──────────────────

            if (actionLabel != null && onAction != null) ...[
              SizedBox(height: 24.h),
              AppButton(
                label: actionLabel!,
                onTap: onAction,
                type: AppButtonType.outline,
                width: 160.w,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
