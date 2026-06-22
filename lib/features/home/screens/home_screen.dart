import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/loading_shimmer.dart';
import 'package:algolens/core/widgets/offline_banner.dart';
import 'package:algolens/core/widgets/progress_bar_widget.dart';
import 'package:algolens/core/widgets/rank_chip.dart';
import 'package:algolens/core/widgets/section_header.dart';
import 'package:algolens/core/widgets/stat_card.dart';
import 'package:algolens/core/widgets/user_avatar.dart';
import 'package:algolens/features/home/data/models/home_model.dart';
import 'package:algolens/features/home/providers/home_provider.dart';
import 'package:algolens/features/profile/data/models/profile_model.dart';
import 'package:algolens/features/profile/providers/profile_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final handleAsync = ref.watch(cfHandleProvider);

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: handleAsync.when(
                loading: () => const _LoadingBody(),
                error: (e, s) => _ErrorBody(
                  error: e.toString(),
                  onRetry: () => ref.invalidate(cfHandleProvider),
                ),
                data: (handle) {
                  if (handle == null || handle.isEmpty) {
                    return _ErrorBody(
                      error: 'Handle not set',
                      onRetry: () => ref.invalidate(cfHandleProvider),
                    );
                  }
                  return _HomeBody(handle: handle);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeBody extends ConsumerWidget {
  const _HomeBody({required this.handle});
  final String handle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider(handle));
    final readinessAsync = ref.watch(homeReadinessProvider);
    final deltaAsync = ref.watch(ratingDeltaProvider);

    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.bgMid,
      onRefresh: () async {
        ref.invalidate(profileProvider(handle));
        ref.invalidate(homeReadinessProvider);
        ref.invalidate(ratingDeltaProvider);
      },
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 16.h,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _Header(
                  handle: handle,
                  profileAsync: profileAsync,
                  // push so user can go back to home
                  onAvatarTap: () => context.pushNamed(RouteNames.profile),
                ),
                SizedBox(height: 20.h),
                profileAsync.when(
                  loading: () => GlassCardShimmer(height: 140.h),
                  error: (e, s) => const SizedBox.shrink(),
                  data: (profile) => _RatingHeroCard(
                    profile: profile,
                    readinessAsync: readinessAsync,
                    deltaAsync: deltaAsync,
                  ),
                ),
                SizedBox(height: 16.h),
                profileAsync.when(
                  loading: () => const StatsRowShimmer(),
                  error: (e, s) => const SizedBox.shrink(),
                  data: (profile) => _StatsRow(profile: profile),
                ),
                SizedBox(height: 24.h),
                SectionHeader(
                  title: 'Upcoming Contests',
                  actionLabel: 'See all',
                  onAction: () => context.goNamed(RouteNames.contests),
                ),
                SizedBox(height: 12.h),
                GlassCard(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.r),
                      child: Column(
                        children: [
                          Icon(
                            Icons.emoji_events_rounded,
                            color: AppColors.primary.withValues(alpha: 0.50),
                            size: 32.r,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'Contest data coming soon',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withValues(alpha: 0.55),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 100.h),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.handle,
    required this.profileAsync,
    required this.onAvatarTap,
  });

  final String handle;
  final AsyncValue<ProfileModel> profileAsync;
  final VoidCallback onAvatarTap;

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _greeting(),
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withValues(alpha: 0.55),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                handle,
                style: GoogleFonts.inter(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        profileAsync.when(
          loading: () => Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.15),
            ),
          ),
          error: (_, __) => UserAvatar(
            handle: handle,
            rank: '',
            size: 44.r,
            onTap: onAvatarTap,
          ),
          data: (profile) => UserAvatar(
            handle: profile.handle,
            rank: profile.rank,
            avatarUrl: profile.avatar,
            size: 44.r,
            onTap: onAvatarTap,
          ),
        ),
      ],
    );
  }
}

class _RatingHeroCard extends StatelessWidget {
  const _RatingHeroCard({
    required this.profile,
    required this.readinessAsync,
    required this.deltaAsync,
  });

  final ProfileModel profile;
  final AsyncValue<ReadinessScore> readinessAsync;
  final AsyncValue<RatingDelta?> deltaAsync;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      type: GlassCardType.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rating',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.55),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${profile.rating}',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RankChip(rank: profile.rank),
                  SizedBox(height: 8.h),
                  deltaAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (delta) {
                      if (delta == null) return const SizedBox.shrink();
                      return Text(
                        delta.formatted,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: delta.isPositive
                              ? AppColors.success
                              : AppColors.danger,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          readinessAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (readiness) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      readiness.label,
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.70),
                      ),
                    ),
                    Text(
                      '${readiness.score}%',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                ProgressBarWidget(
                  value: readiness.score / 100,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.profile});
  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            icon: Icons.check_circle_rounded,
            iconColor: AppColors.success,
            value: '${profile.problemsSolved}',
            label: 'Solved',
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: StatCard(
            icon: Icons.emoji_events_rounded,
            iconColor: AppColors.warning,
            value: '${profile.contestsParticipated}',
            label: 'Contests',
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: StatCard(
            icon: Icons.local_fire_department_rounded,
            iconColor: AppColors.danger,
            value: '${profile.streakDays}',
            label: 'Streak',
          ),
        ),
      ],
    );
  }
}

class _LoadingBody extends StatelessWidget {
  const _LoadingBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        children: [
          GlassCardShimmer(height: 60.h),
          SizedBox(height: 20.h),
          GlassCardShimmer(height: 140.h),
          SizedBox(height: 16.h),
          const StatsRowShimmer(),
        ],
      ),
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({
    required this.error,
    required this.onRetry,
  });

  final String error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: AppColors.danger.withValues(alpha: 0.70),
              size: 48.r,
            ),
            SizedBox(height: 16.h),
            Text(
              error,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.60),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            TextButton(
              onPressed: onRetry,
              child: Text(
                'Retry',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}