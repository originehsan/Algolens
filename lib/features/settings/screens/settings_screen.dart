import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/page_wrapper.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/user_avatar.dart';
import 'package:algolens/core/widgets/rank_chip.dart';
import 'package:algolens/core/widgets/coming_soon_badge.dart';
import 'package:algolens/core/widgets/loading_shimmer.dart';
import 'package:algolens/features/auth/providers/auth_provider.dart';
import 'package:algolens/features/profile/providers/profile_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _contestReminders = true;
  bool _streakReminders = true;
  String _appVersion = '1.0.0';

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _appVersion = '${info.version}+${info.buildNumber}';
      });
    }
  }

  Future<void> _handleLogout() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.bgMid,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.15),
          ),
        ),
        title: Text(
          'Logout',
          style: AppTextStyles.h2,
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: AppTextStyles.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTextStyles.body.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(authStateProvider.notifier).logout();
              if (mounted) {
                context.go('/onboarding');
              }
            },
            child: Text(
              'Logout',
              style: AppTextStyles.bodyBold.copyWith(
                color: AppColors.danger,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final handle = authState.handle ?? 'ehsan_cf';
    final profileAsync = ref.watch(profileProvider(handle));

    return PageWrapper(
      title: 'Settings',
      showBackButton: true,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),

            // Account card
            profileAsync.when(
              loading: () => ShimmerCard(height: 80.h),
              error: (e, _) => GlassCard(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24.r,
                      backgroundColor:
                          AppColors.primary.withValues(alpha: 0.20),
                      child: Icon(
                        Icons.person_rounded,
                        color: AppColors.primary,
                        size: 24.r,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      handle,
                      style: AppTextStyles.bodyBold,
                    ),
                  ],
                ),
              ),
              data: (profile) => GlassCard(
                type: GlassCardType.primary,
                child: Row(
                  children: [
                    UserAvatar(
                      handle: profile.handle,
                      rank: profile.rank,
                      size: 48.r,
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.handle,
                            style: AppTextStyles.bodyBold,
                          ),
                          SizedBox(height: 4.h),
                          RankChip(
                            rank: profile.rank,
                            compact: true,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${profile.rating}',
                      style: AppTextStyles.metricSmall.copyWith(
                        color: AppColors.primary,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Notifications section
            Text(
              'Notifications',
              style: AppTextStyles.h3,
            ),
            SizedBox(height: 8.h),
            GlassCard(
              child: Column(
                children: [
                  _buildSwitchTile(
                    icon: Icons.event_note_rounded,
                    iconColor: AppColors.primary,
                    title: 'Contest Reminders',
                    subtitle: 'Get notified before contests start',
                    value: _contestReminders,
                    onChanged: (value) => setState(() {
                      _contestReminders = value;
                    }),
                  ),
                  const Divider(
                    color: AppColors.divider,
                    height: 1,
                  ),
                  _buildSwitchTile(
                    icon: Icons.local_fire_department_rounded,
                    iconColor: AppColors.warning,
                    title: 'Streak Reminders',
                    subtitle: 'Daily reminder to maintain streak',
                    value: _streakReminders,
                    onChanged: (value) => setState(() {
                      _streakReminders = value;
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // App info section
            Text(
              'About',
              style: AppTextStyles.h3,
            ),
            SizedBox(height: 8.h),
            GlassCard(
              child: Column(
                children: [
                  _buildInfoTile(
                    icon: Icons.info_outline_rounded,
                    title: 'App Version',
                    trailing: Text(
                      _appVersion,
                      style: AppTextStyles.metricSmall.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                  const Divider(
                    color: AppColors.divider,
                    height: 1,
                  ),
                  _buildInfoTile(
                    icon: Icons.code_rounded,
                    title: 'Backend',
                    trailing: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        'Connected',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.success,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: AppColors.divider,
                    height: 1,
                  ),
                  _buildInfoTile(
                    icon: Icons.science_outlined,
                    title: 'Environment',
                    trailing: Text(
                      'Development',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.warning,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Coming soon section
            Text(
              'Coming Soon',
              style: AppTextStyles.h3,
            ),
            SizedBox(height: 8.h),
            GlassCard(
              child: Column(
                children: [
                  _buildComingSoonTile(
                    'Dark / Light Theme',
                    Icons.palette_outlined,
                  ),
                  const Divider(
                    color: AppColors.divider,
                    height: 1,
                  ),
                  _buildComingSoonTile(
                    'Export Stats as PDF',
                    Icons.picture_as_pdf_outlined,
                  ),
                  const Divider(
                    color: AppColors.divider,
                    height: 1,
                  ),
                  _buildComingSoonTile(
                    'Widget Customization',
                    Icons.widgets_outlined,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Logout button
            AppButton(
              label: 'Logout',
              onTap: _handleLogout,
              type: AppButtonType.outline,
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 4.h,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 18.r,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyBold,
                ),
                Text(
                  subtitle,
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
            activeTrackColor: AppColors.primary.withValues(alpha: 0.30),
            inactiveThumbColor: AppColors.textMuted,
            inactiveTrackColor: Colors.white.withValues(alpha: 0.10),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required Widget trailing,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.textMuted,
            size: 18.r,
          ),
          SizedBox(width: 12.w),
          Text(
            title,
            style: AppTextStyles.body,
          ),
          const Spacer(),
          trailing,
        ],
      ),
    );
  }

  Widget _buildComingSoonTile(String title, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.textMuted,
            size: 18.r,
          ),
          SizedBox(width: 12.w),
          Text(
            title,
            style: AppTextStyles.body,
          ),
          const Spacer(),
          const ComingSoonBadge(),
        ],
      ),
    );
  }
}
