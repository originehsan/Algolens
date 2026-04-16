import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/glass_card.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final String? sublabel;
  final bool isMonospace;
  final IconData? icon;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.sublabel,
    this.isMonospace = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.all(14.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: valueColor ?? AppColors.textMuted,
                  size: 14.r,
                ),
                SizedBox(width: 4.w),
              ],
              Text(
                label,
                style: AppTextStyles.caption,
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: isMonospace
                ? AppTextStyles.monoLarge.copyWith(
                    color: valueColor ?? AppColors.textPrimary,
                    fontSize: 22.sp,
                  )
                : AppTextStyles.heading.copyWith(
                    color: valueColor ?? AppColors.textPrimary,
                  ),
          ),
          if (sublabel != null) ...[
            SizedBox(height: 2.h),
            Text(
              sublabel!,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textHint,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
