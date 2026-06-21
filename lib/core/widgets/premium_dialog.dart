import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/glass_card.dart';

/// Shown when user taps a locked premium feature (SMS/Voice).
/// Call from anywhere: PremiumDialog.show(context)
class PremiumDialog extends StatelessWidget {
  const PremiumDialog({super.key});

  /// Static convenience method — no provider or widget tree needed.
  static Future<void> show(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.70),
      builder: (_) => const PremiumDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: GlassCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Crown icon — amber to signal premium
            Container(
              width: 64.r,
              height: 64.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.warning.withValues(alpha: 0.15),
                border: Border.all(
                  color: AppColors.warning.withValues(alpha: 0.40),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.workspace_premium_rounded,
                color: AppColors.warning,
                size: 32.r,
              ),
            ),

            SizedBox(height: 16.h),

            Text(
              'Premium Feature',
              style: AppTextStyles.h2,
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 8.h),

            Text(
              'SMS and Voice Call alerts are premium features coming soon to AlgoLens.',
              style: AppTextStyles.body.copyWith(
                color: Colors.white.withValues(alpha: 0.65),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 20.h),

            const _FeatureRow(
              icon: Icons.sms_rounded,
              label: 'SMS contest alerts',
            ),
            SizedBox(height: 10.h),
            const _FeatureRow(
              icon: Icons.call_rounded,
              label: 'Voice call reminders',
            ),
            SizedBox(height: 10.h),
            const _FeatureRow(
              icon: Icons.verified_rounded,
              label: 'CF handle verification',
            ),

            SizedBox(height: 24.h),

            // Coming soon banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppColors.warning.withValues(alpha: 0.25),
                ),
              ),
              child: Text(
                '🚀  Coming Soon',
                style: AppTextStyles.bodyBold.copyWith(
                  color: AppColors.warning,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 16.h),

            AppButton(
              label: 'Got it',
              onTap: () => Navigator.pop(context),
              type: AppButtonType.outline,
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32.r,
          height: 32.r,
          decoration: BoxDecoration(
            color: AppColors.warning.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: AppColors.warning, size: 16.r),
        ),
        SizedBox(width: 12.w),
        Text(
          label,
          style: AppTextStyles.body.copyWith(
            color: Colors.white.withValues(alpha: 0.80),
          ),
        ),
        const Spacer(),
        Icon(Icons.check_rounded, color: AppColors.warning, size: 16.r),
      ],
    );
  }
}