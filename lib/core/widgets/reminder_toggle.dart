import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';

/// Toggle row for reminder type selection
/// Used in ReminderSheet
/// across home + contests screens
class ReminderToggle extends StatelessWidget {
  const ReminderToggle({
    super.key,
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.color,
    required this.onChanged,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final bool value;
  final Color color;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: value
              ? color.withValues(alpha: 0.10)
              : Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: value
                ? color.withValues(alpha: 0.35)
                : Colors.white.withValues(alpha: 0.08),
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: value ? color : AppColors.textMuted,
              size: 20.r,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: value
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 22.r,
              height: 22.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: value ? color : Colors.transparent,
                border: Border.all(
                  color: value ? color : AppColors.textHint,
                  width: 1.5,
                ),
              ),
              child: value
                  ? Icon(
                      Icons.check_rounded,
                      size: 12.r,
                      color: Colors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}