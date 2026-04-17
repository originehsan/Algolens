import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/page_wrapper.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/app_button.dart';

class EmailVerificationScreen extends StatelessWidget {
  final String email;

  const EmailVerificationScreen({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: 'Verify Email',
      showBackButton: true,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlassCard(
              child: Column(
                children: [
                  Icon(
                    Icons.mark_email_unread_rounded,
                    color: AppColors.primary,
                    size: 64.r,
                  ).animate().fadeIn(duration: 600.ms).scale(
                        begin: const Offset(0.5, 0.5),
                        end: const Offset(1.0, 1.0),
                        duration: 600.ms,
                        curve: Curves.easeOut,
                      ),
                  SizedBox(height: 20.h),
                  Text(
                    'Check Your Email',
                    style: AppTextStyles.h2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'We sent a verification link to',
                    style: AppTextStyles.body,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    email,
                    style: AppTextStyles.bodyBold.copyWith(
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Click the link in the email to verify your account',
                    style: AppTextStyles.caption,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            AppButton(
              label: 'Back to Login',
              onPressed: () => context.go('/login'),
              isOutline: true,
            ),
          ],
        ),
      ),
    );
  }
}
