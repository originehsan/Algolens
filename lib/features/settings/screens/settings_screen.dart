import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:algolens/core/local/user_settings_service.dart';
import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/coming_soon_badge.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/rank_chip.dart';
import 'package:algolens/core/widgets/section_header.dart';
import 'package:algolens/core/widgets/user_avatar.dart';
import 'package:algolens/features/auth/providers/auth_provider.dart';
import 'package:algolens/features/profile/providers/profile_provider.dart';
import 'package:algolens/features/settings/providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(userSettingsProvider);
    final handleAsync = ref.watch(cfHandleProvider);
    final versionAsync = ref.watch(appVersionProvider);
    final logoutState = ref.watch(logoutProvider);

    // Navigate to login after logout success
    ref.listen(logoutProvider, (_, next) {
      if (next is AuthSuccess) {
        if (!context.mounted) return;
        ref.invalidate(cfHandleProvider);
        context.goNamed(RouteNames.login);
      }
    });

    final isLoggingOut = logoutState is AuthLoading;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              floating: true,
              // Back button — settings is pushed from profile
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 20.r,
                ),
              ),
              title: Text('Settings', style: AppTextStyles.h2),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: 8.h),

                  // Profile card
                  handleAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (handle) {
                      if (handle == null) return const SizedBox.shrink();
                      final profile = ref.watch(profileProvider(handle));
                      return GlassCard(
                        child: Row(
                          children: [
                            profile.when(
                              loading: () => Container(
                                width: 56.r,
                                height: 56.r,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary
                                      .withValues(alpha: 0.20),
                                ),
                              ),
                              error: (_, __) => UserAvatar(
                                handle: handle,
                                rank: '',
                                size: 56.r,
                              ),
                              data: (p) => UserAvatar(
                                handle: p.handle,
                                rank: p.rank,
                                avatarUrl: p.avatar,
                                size: 56.r,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(handle, style: AppTextStyles.h3),
                                  SizedBox(height: 6.h),
                                  profile.when(
                                    loading: () => const SizedBox.shrink(),
                                    error: (_, __) => const SizedBox.shrink(),
                                    data: (p) => RankChip(
                                      rank: p.rank,
                                      compact: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 20.h),

                  // Notifications
                  const SectionHeader(title: 'Notifications'),
                  SizedBox(height: 12.h),
                  settingsAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (s) => GlassCard(
                      child: Column(
                        children: [
                          _ToggleRow(
                            icon: Icons.notifications_rounded,
                            iconColor: AppColors.primary,
                            label: 'Contest Alerts',
                            subtitle: 'Remind me before contests',
                            value: s.contestAlertsEnabled,
                            onChanged: (v) => ref
                                .read(userSettingsServiceProvider)
                                .setContestAlerts(v),
                          ),
                          const _Divider(),
                          _ToggleRow(
                            icon: Icons.local_fire_department_rounded,
                            iconColor: AppColors.warning,
                            label: 'Streak Reminder',
                            subtitle: 'Daily streak notification',
                            value: s.streakReminderEnabled,
                            onChanged: (v) => ref
                                .read(userSettingsServiceProvider)
                                .setStreakReminder(v),
                          ),
                          const _Divider(),
                          _ToggleRow(
                            icon: Icons.lightbulb_rounded,
                            iconColor: AppColors.success,
                            label: 'Upsolve Reminder',
                            subtitle: 'Weekly upsolve nudge',
                            value: s.upsolveReminderEnabled,
                            onChanged: (v) => ref
                                .read(userSettingsServiceProvider)
                                .setUpsolveReminder(v),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Voice & SMS
                  const SectionHeader(title: 'Voice & SMS'),
                  SizedBox(height: 12.h),
                  settingsAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (s) => GlassCard(
                      child: Column(
                        children: [
                          _ToggleRow(
                            icon: Icons.record_voice_over_rounded,
                            iconColor: AppColors.primary,
                            label: 'Voice Reminder',
                            subtitle: 'Speak contest alerts aloud',
                            value: s.ttsEnabled,
                            onChanged: (v) => ref
                                .read(userSettingsServiceProvider)
                                .setTtsEnabled(v),
                          ),
                          const _Divider(),
                          const _LockedRow(
                            icon: Icons.sms_rounded,
                            label: 'SMS Alerts',
                            subtitle: 'Text alerts for contests',
                          ),
                          const _Divider(),
                          const _LockedRow(
                            icon: Icons.call_rounded,
                            label: 'Voice Calls',
                            subtitle: 'Phone alerts for contests',
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // App
                  const SectionHeader(title: 'App'),
                  SizedBox(height: 12.h),
                  settingsAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (s) => GlassCard(
                      child: Column(
                        children: [
                          _ToggleRow(
                            icon: Icons.widgets_rounded,
                            iconColor: AppColors.primary,
                            label: 'Home Widget',
                            subtitle: 'Show rating on home screen',
                            value: s.widgetEnabled,
                            onChanged: (v) => ref
                                .read(userSettingsServiceProvider)
                                .setWidgetEnabled(v),
                          ),
                          const _Divider(),
                          Consumer(
                            builder: (context, ref, _) {
                              final cacheState = ref.watch(clearCacheProvider);
                              final isClearing = cacheState is AsyncLoading;
                              return _ActionRow(
                                icon: Icons.cleaning_services_rounded,
                                iconColor: AppColors.warning,
                                label: 'Clear Cache',
                                subtitle:
                                    'Remove cached profile & contest data',
                                actionLabel:
                                    isClearing ? 'Clearing...' : 'Clear',
                                isLoading: isClearing,
                                onTap: isClearing
                                    ? null
                                    : () async {
                                        await ref
                                            .read(clearCacheProvider.notifier)
                                            .clear();
                                        if (!context.mounted) return;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Cache cleared!',
                                              style: AppTextStyles.body
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                            backgroundColor: AppColors.success,
                                          ),
                                        );
                                      },
                              );
                            },
                          ),
                          const _Divider(),
                          _InfoRow(
                            icon: Icons.info_outline_rounded,
                            label: 'App Version',
                            value: versionAsync.when(
                              loading: () => '...',
                              error: (_, __) => 'Unknown',
                              data: (v) => v,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Account
                  const SectionHeader(title: 'Account'),
                  SizedBox(height: 12.h),
                  GlassCard(
                    child: Column(
                      children: [
                        AppButton(
                          label: 'Sign Out',
                          onTap: isLoggingOut
                              ? null
                              : () =>
                                  ref.read(logoutProvider.notifier).logout(),
                          isLoading: isLoggingOut,
                          type: AppButtonType.outline,
                          icon: Icons.logout_rounded,
                        ),
                        SizedBox(height: 12.h),
                        AppButton(
                          label: 'Sign Out All Devices',
                          onTap: isLoggingOut
                              ? null
                              : () => ref
                                  .read(logoutProvider.notifier)
                                  .logoutAll(),
                          isLoading: isLoggingOut,
                          type: AppButtonType.danger,
                          icon: Icons.devices_rounded,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40.h),

                  Center(
                    child: Text(
                      'AlgoLens • Made with ♥ for CP',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white.withValues(alpha: 0.30),
                      ),
                    ),
                  ),

                  SizedBox(height: 100.h),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────
// TOGGLE ROW
// ─────────────────────────────────

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36.r,
          height: 36.r,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: iconColor, size: 18.r),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.bodyBold),
              SizedBox(height: 2.h),
              Text(subtitle, style: AppTextStyles.caption),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: AppColors.primary,
          activeTrackColor: AppColors.primary.withValues(alpha: 0.30),
          inactiveThumbColor: Colors.white.withValues(alpha: 0.50),
          inactiveTrackColor: Colors.white.withValues(alpha: 0.10),
        ),
      ],
    );
  }
}

// ─────────────────────────────────
// LOCKED ROW
// ─────────────────────────────────

class _LockedRow extends StatelessWidget {
  const _LockedRow({
    required this.icon,
    required this.label,
    required this.subtitle,
  });

  final IconData icon;
  final String label;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36.r,
          height: 36.r,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(
            icon,
            color: Colors.white.withValues(alpha: 0.30),
            size: 18.r,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    label,
                    style: AppTextStyles.bodyBold.copyWith(
                      color: Colors.white.withValues(alpha: 0.40),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  const ComingSoonBadge(),
                ],
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white.withValues(alpha: 0.30),
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: false,
          onChanged: null,
          inactiveThumbColor: Colors.white.withValues(alpha: 0.20),
          inactiveTrackColor: Colors.white.withValues(alpha: 0.06),
        ),
      ],
    );
  }
}

// ─────────────────────────────────
// ACTION ROW
// ─────────────────────────────────

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.subtitle,
    required this.actionLabel,
    required this.onTap,
    this.isLoading = false,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String subtitle;
  final String actionLabel;
  final VoidCallback? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36.r,
          height: 36.r,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: iconColor, size: 18.r),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.bodyBold),
              SizedBox(height: 2.h),
              Text(subtitle, style: AppTextStyles.caption),
            ],
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8.r),
              border:
                  Border.all(color: iconColor.withValues(alpha: 0.30)),
            ),
            child: isLoading
                ? SizedBox(
                    width: 14.r,
                    height: 14.r,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      color: iconColor,
                    ),
                  )
                : Text(
                    actionLabel,
                    style: AppTextStyles.captionBold
                        .copyWith(color: iconColor),
                  ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────
// INFO ROW
// ─────────────────────────────────

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36.r,
          height: 36.r,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(
            icon,
            color: Colors.white.withValues(alpha: 0.50),
            size: 18.r,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(child: Text(label, style: AppTextStyles.bodyBold)),
        Text(
          value,
          style: AppTextStyles.monoSmall.copyWith(
            color: Colors.white.withValues(alpha: 0.50),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────
// DIVIDER
// ─────────────────────────────────

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Divider(
        color: Colors.white.withValues(alpha: 0.08),
        height: 1,
      ),
    );
  }
}