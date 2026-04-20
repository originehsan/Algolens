import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/page_wrapper.dart';
import 'package:algolens/core/widgets/app_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        Color(0xFF2563EB),
                        Color(0xFF3B82F6),
                        Color(0xFF60A5FA),
                        Color(0xFF3B82F6),
                        Color(0xFF2563EB),
                      ],
                    ).createShader(bounds),
                    child: Text(
                      'AlgoLens',
                      style: AppTextStyles.display.copyWith(
                        color: Colors.white,
                        fontSize: 36.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideY(
                        begin: 0.3,
                        end: 0,
                        duration: 600.ms,
                        curve: Curves.easeOut,
                      ),
                  SizedBox(height: 12.h),
                  Text(
                    'Competitive Programming\nAnalytics Platform',
                    style: AppTextStyles.body,
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(
                        delay: 200.ms,
                        duration: 600.ms,
                      ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _featurePill('Track Rating'),
                      SizedBox(width: 8.w),
                      _featurePill('Analyze Weak Topics'),
                    ],
                  ).animate().fadeIn(
                        delay: 400.ms,
                        duration: 600.ms,
                      ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _featurePill('AI Insights'),
                      SizedBox(width: 8.w),
                      _featurePill('Friend Compare'),
                    ],
                  ).animate().fadeIn(
                        delay: 600.ms,
                        duration: 600.ms,
                      ),
                ],
              ),
            ),
            Column(
              children: [
                AppButton(
                  label: 'Get Started',
                  onTap: () => context.go('/register'),
                ).animate().fadeIn(
                      delay: 800.ms,
                      duration: 400.ms,
                    ),
                SizedBox(height: 12.h),
                AppButton(
                  label: 'Login',
                  type: AppButtonType.outline,
                  onTap: () => context.go('/login'),
                ).animate().fadeIn(
                      delay: 900.ms,
                      duration: 400.ms,
                    ),
                SizedBox(height: 40.h),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _featurePill(String label) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.25),
          width: 1.0,
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
