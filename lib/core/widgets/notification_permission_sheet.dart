import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/local/notification_permission_service.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/glass_card.dart';

/// Shown once on first launch when notification permission hasn't been asked.
/// Snapchat-style — non-dismissible until user makes a choice.
/// Call from anywhere: final granted = await NotificationPermissionSheet.show(context)
class NotificationPermissionSheet extends ConsumerWidget {
  const NotificationPermissionSheet({super.key});

  /// Returns true if user granted permission, false if denied or dismissed.
  static Future<bool> show(BuildContext context) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      builder: (_) => const NotificationPermissionSheet(),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GlassCard(
      margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle — visual affordance even though drag is disabled
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 20.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),

          // Bell icon
          Container(
            width: 64.r,
            height: 64.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.12),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.35),
                width: 1.5,
              ),
            ),
            child: Icon(
              Icons.notifications_rounded,
              color: AppColors.primary,
              size: 32.r,
            ),
          ),

          SizedBox(height: 16.h),

          Text(
            'Stay ahead of contests',
            style: AppTextStyles.h2,
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 8.h),

          Text(
            'Get notified before Codeforces contests start so you never miss one.',
            style: AppTextStyles.body.copyWith(
              color: Colors.white.withValues(alpha: 0.60),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 20.h),

          const _BenefitRow(
            icon: Icons.timer_rounded,
            label: 'Reminders before contests',
          ),
          SizedBox(height: 10.h),
          const _BenefitRow(
            icon: Icons.local_fire_department_rounded,
            label: 'Daily streak nudges',
          ),
          SizedBox(height: 10.h),
          const _BenefitRow(
            icon: Icons.lightbulb_rounded,
            label: 'Weekly upsolve reminders',
          ),

          SizedBox(height: 24.h),

          // Allow button — triggers OS permission dialog
          AppButton(
            label: 'Allow Notifications',
            onTap: () async {
              final svc = ref.read(notificationPermissionServiceProvider);
              final granted = await svc.requestPermission();
              // mounted check after async gap
              if (!context.mounted) return;
              Navigator.pop(context, granted);
            },
            icon: Icons.notifications_active_rounded,
          ),

          SizedBox(height: 12.h),

          // Not now — marks as asked but doesn't request permission
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Not now',
              style: AppTextStyles.body.copyWith(
                color: Colors.white.withValues(alpha: 0.50),
              ),
            ),
          ),

          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({required this.icon, required this.label});

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
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: AppColors.primary, size: 16.r),
        ),
        SizedBox(width: 12.w),
        Text(
          label,
          style: AppTextStyles.body.copyWith(
            color: Colors.white.withValues(alpha: 0.80),
          ),
        ),
        const Spacer(),
        Icon(Icons.check_circle_rounded, color: AppColors.success, size: 16.r),
      ],
    );
  }
}