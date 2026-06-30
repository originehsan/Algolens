import 'package:algolens/features/home/screens/widgets/rating_hero_card.dart';
import 'package:algolens/features/home/screens/widgets/stats_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:algolens/core/constants/app_constants.dart';
import 'package:algolens/core/constants/app_strings.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/utils/date_utils.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/empty_widget.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/section_header.dart';
import 'package:algolens/core/widgets/user_avatar.dart';
import 'package:algolens/features/contests/providers/contest_provider.dart';
import 'package:algolens/features/friends/providers/friends_provider.dart';
import 'package:algolens/features/home/providers/home_provider.dart';
import 'package:algolens/features/home/screens/widgets/contest_carousel.dart';
import 'package:algolens/features/home/screens/widgets/friend_pulse_row.dart';
import 'package:algolens/features/home/screens/widgets/today_focus_card.dart';
import 'package:algolens/features/practice/providers/practice_provider.dart';
import 'package:algolens/features/profile/data/models/profile_model.dart';
import 'package:algolens/features/profile/providers/profile_provider.dart';

// ─────────────────────────────────────────────────────────────────
// HOME SCREEN
// Resolves CF handle → delegates to _HomeBody
// Note: OfflineBanner now lives in MainScaffold, not here.
// ─────────────────────────────────────────────────────────────────

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final handleAsync = ref.watch(cfHandleProvider);

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: handleAsync.when(
          loading: () => const _HomeLoadingBody(),
          error: (e, _) => _HomeErrorBody(
            message:
                e is ApiException ? e.message : AppStrings.somethingWentWrong,
            onRetry: () => ref.invalidate(cfHandleProvider),
          ),
          data: (handle) {
            if (handle == null || handle.isEmpty) {
              return _HomeErrorBody(
                message: AppStrings.handleNotSet,
                onRetry: () => ref.invalidate(cfHandleProvider),
              );
            }
            return _HomeBody(handle: handle);
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// HOME BODY — all 6 sections
// ─────────────────────────────────────────────────────────────────

class _HomeBody extends ConsumerWidget {
  const _HomeBody({required this.handle});
  final String handle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider(handle));
    final readinessAsync = ref.watch(homeReadinessProvider);
    final deltaAsync = ref.watch(ratingDeltaProvider);
    final contestsAsync = ref.watch(upcomingContestsProvider);
    final leaderboardAsync = ref.watch(leaderboardProvider);
    final weakTopicsAsync = ref.watch(weakTopicsProvider);

    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.bgMid,
      displacement: 20,
      onRefresh: () async {
        HapticFeedback.mediumImpact();
        await Future.wait([
          ref.refresh(profileProvider(handle).future),
          ref.refresh(homeReadinessProvider.future),
          ref.refresh(ratingDeltaProvider.future),
          ref.refresh(upcomingContestsProvider.future),
          ref.refresh(leaderboardProvider.future),
          ref.refresh(weakTopicsProvider.future),
        ]);
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── S1 — Header panel (full bleed, own safe area) ──
          SliverToBoxAdapter(
            child: _HomeHeaderPanel(
              handle: handle,
              profileAsync: profileAsync,
            ),
          ),

          // ── Padded content ─────────────────────────────
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.screenHorizontalPaddingValue.w,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Gap(20.h),

                // S2 — Rating hero
                profileAsync.when(
                  loading: () => GlassCardShimmer(height: 148.h),
                  error: (_, __) => const SizedBox.shrink(),
                  data: (p) => RatingHeroCard(
                    profile: p,
                    readinessAsync: readinessAsync,
                    deltaAsync: deltaAsync,
                  ),
                ),

                Gap(14.h),
// S3 — Stats strip (merged card, vertical dividers)
                profileAsync.when(
                  loading: () => GlassCardShimmer(height: 86.h),
                  error: (_, __) => const SizedBox.shrink(),
                  data: (p) => StatsStrip(profile: p),
                ),

                Gap(28.h),

                // S4 header
                SectionHeader(
                  title: AppStrings.upcomingContests,
                  actionLabel: AppStrings.seeAll,
                  onAction: () => context.goNamed(RouteNames.contests),
                ),

                Gap(14.h),
              ]),
            ),
          ),

          // ── S4 — Carousel (full bleed, no padding) ─────
          SliverToBoxAdapter(
            child: contestsAsync.when(
              loading: () => Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.screenHorizontalPaddingValue.w,
                ),
                child: GlassCardShimmer(height: 230.h),
              ),
              error: (_, __) => const SizedBox.shrink(),
              data: (contests) {
                if (contests.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppConstants.screenHorizontalPaddingValue.w,
                    ),
                    child: const EmptyWidget(
                      icon: Icons.emoji_events_rounded,
                      message: AppStrings.noUpcomingContests,
                      subtitle: AppStrings.noUpcomingContestsSub,
                    ),
                  );
                }
                return ContestCarousel(
                  contests:
                      contests.take(AppConstants.homeCarouselMax).toList(),
                  handle: handle,
                );
              },
            ),
          ),

          // ── Padded remainder ───────────────────────────
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.screenHorizontalPaddingValue.w,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Gap(28.h),

                // S5 — Friends pulse
                leaderboardAsync.when(
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                  data: (rows) {
                    if (rows.isEmpty) return const SizedBox.shrink();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeader(
                          title: AppStrings.friendsPulse,
                          actionLabel: AppStrings.seeAll,
                          onAction: () => context.goNamed(RouteNames.friends),
                        ),
                        Gap(12.h),
                        _FriendsPulse(
                          rows: rows,
                          myHandle: handle,
                        ),
                        Gap(28.h),
                      ],
                    );
                  },
                ),

                // S6 — Today's focus
                weakTopicsAsync.when(
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                  data: (topics) {
                    if (topics.isEmpty) return const SizedBox.shrink();
                    final worst = topics.first;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeader(title: AppStrings.todayFocus),
                        Gap(12.h),
                        TodayFocusCard(
                          tag: worst.tag,
                          acRate: worst.acRate,
                          solvedCount: worst.solvedCount,
                          totalAttempts: worst.totalAttempts,
                          onTap: () => context.goNamed(RouteNames.practice),
                        ),
                      ],
                    );
                  },
                ),

                Gap(120.h),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// S1 — HEADER PANEL
// Curved bottom edge, color reaches absolute screen top, content
// pushed below status bar via SafeArea(bottom: false).
// ─────────────────────────────────────────────────────────────────

class _HomeHeaderPanel extends StatelessWidget {
  const _HomeHeaderPanel({
    required this.handle,
    required this.profileAsync,
  });

  final String handle;
  final AsyncValue<ProfileModel> profileAsync;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.bgMid,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppConstants.screenHorizontalPaddingValue.w,
            20.h,
            AppConstants.screenHorizontalPaddingValue.w,
            24.h,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppDateUtils.greeting(),
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textMuted,
                        letterSpacing: 0.4,
                      ),
                    ),
                    Gap(6.h),
                    Text(
                      handle,
                      style: AppTextStyles.h1.copyWith(
                        fontFamily: 'JetBrainsMono',
                        fontSize: 26.sp,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              profileAsync.when(
                loading: () => const _AvatarShimmer(),
                error: (_, __) => UserAvatar(
                  handle: handle,
                  rank: '',
                  size: 50.r,
                  onTap: () => context.pushNamed(RouteNames.profile),
                ),
                data: (p) => UserAvatar(
                  handle: p.handle,
                  rank: p.rank,
                  avatarUrl: p.avatar,
                  size: 50.r,
                  onTap: () => context.pushNamed(RouteNames.profile),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvatarShimmer extends StatelessWidget {
  const _AvatarShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.r,
      height: 50.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary.withValues(alpha: 0.12),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// S3 — STATS ROW
// ───────────────────────────────────────────────────────────────

// ─────────────────────────────────────────────────────────────────
// S5 — FRIENDS PULSE
// ─────────────────────────────────────────────────────────────────

class _FriendsPulse extends StatelessWidget {
  const _FriendsPulse({
    required this.rows,
    required this.myHandle,
  });

  final List<dynamic> rows;
  final String myHandle;

  @override
  Widget build(BuildContext context) {
    final limited = rows.take(AppConstants.homeFriendPulseMax).toList();
    return RepaintBoundary(
      child: GlassCard(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Column(
          children: List.generate(limited.length, (i) {
            final row = limited[i];
            final isLast = i == limited.length - 1;
            return FriendPulseRow(
              rank: row.rank,
              handle: row.handle,
              rating: row.rating,
              tier: row.tier,
              isMe: row.handle == myHandle,
              showDivider: !isLast,
            );
          }),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// LOADING BODY
// ─────────────────────────────────────────────────────────────────

class _HomeLoadingBody extends StatelessWidget {
  const _HomeLoadingBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.screenHorizontalPaddingValue.w,
        vertical: 16.h,
      ),
      child: Column(
        children: [
          Gap(16.h),
          GlassCardShimmer(height: 130.h),
          Gap(12.h),
          GlassCardShimmer(height: 86.h),
          Gap(20.h),
          GlassCardShimmer(height: 230.h),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// ERROR BODY
// ─────────────────────────────────────────────────────────────────

class _HomeErrorBody extends StatelessWidget {
  const _HomeErrorBody({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: AppColors.danger.withValues(alpha: 0.70),
              size: 48.r,
            ),
            Gap(16.h),
            Text(
              message,
              style: AppTextStyles.body.copyWith(
                color: AppColors.textMuted,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(20.h),
            GestureDetector(
              onTap: onRetry,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 10.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.40),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  AppStrings.retry,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
