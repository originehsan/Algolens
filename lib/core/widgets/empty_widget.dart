import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/glass_card.dart';

class AppEmptyWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? buttonLabel;
  final VoidCallback? onButtonTap;
  final IconData icon;

  const AppEmptyWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.buttonLabel,
    this.onButtonTap,
    this.icon = Icons.inbox_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
        ),
        child: GlassCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: AppColors.textMuted,
                size: 56.r,
              ),
              SizedBox(height: 16.h),
              Text(
                title,
                style: AppTextStyles.h3,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                subtitle,
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
              ),
              if (buttonLabel != null) ...[
                SizedBox(height: 24.h),
                AppButton(
                  label: buttonLabel!,
                  onPressed: onButtonTap,
                  isOutline: true,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
