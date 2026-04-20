import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/app_button.dart';

class AuthBottomLayout extends StatelessWidget {
  final String primaryButtonLabel;
  final VoidCallback onPrimaryPressed;
  final String switchText;
  final String switchLinkText;
  final VoidCallback onSwitchPressed;
  final bool isLoading;

  const AuthBottomLayout({
    super.key,
    required this.primaryButtonLabel,
    required this.onPrimaryPressed,
    required this.switchText,
    required this.switchLinkText,
    required this.onSwitchPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppButton(
          label: primaryButtonLabel,
          onTap: onPrimaryPressed,
          isLoading: isLoading,
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              switchText,
              style: AppTextStyles.caption,
            ),
            SizedBox(width: 4.w),
            GestureDetector(
              onTap: onSwitchPressed,
              child: Text(
                switchLinkText,
                style: AppTextStyles.captionBold.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
