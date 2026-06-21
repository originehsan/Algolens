import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: AppTextStyles.h3),
            if (actionLabel != null && onAction != null)
              GestureDetector(
                onTap: onAction,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      actionLabel!,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.primary,
                      size: 10.r,
                    ),
                  ],
                ),
              ),
          ],
        ),
        // Show subtitle below title if provided
        if (subtitle != null) ...[
          SizedBox(height: 2.h),
          Text(
            subtitle!,
            style: AppTextStyles.caption,
          ),
        ],
      ],
    );
  }
}