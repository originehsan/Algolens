import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/page_wrapper.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/section_header.dart';
import 'package:algolens/core/widgets/stat_card.dart';
import 'package:algolens/core/widgets/user_avatar.dart';
import 'package:algolens/core/widgets/rank_chip.dart';
import 'package:algolens/core/widgets/contest_card.dart';
import 'package:algolens/core/widgets/loading_shimmer.dart';
import 'package:algolens/core/widgets/error_widget.dart';
import 'package:algolens/features/auth/providers/auth_provider.dart';
import 'package:algolens/features/profile/providers/profile_provider.dart';
import 'package:algolens/features/contests/providers/contest_provider.dart';
import 'package:algolens/features/contests/data/models/contest_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final CardSwiperController _cardController = CardSwiperController();
  final Set<int> _reminderSet = {};

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final handle = authState.handle ?? 'ehsan_cf';

    final profileAsync = ref.watch(profileProvider(handle));
    final contestsAsync = ref.watch(upcomingContestsProvider);

    return PageWrapper(
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(profileProvider(handle));
          ref.invalidate(upcomingContestsProvider);
        },
        color: AppColors.primary,
        backgroundColor: AppColors.bgMid,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              // SECTION 1 — Top Bar
              _buildTopBar(handle, profileAsync),
              SizedBox(height: 16.h),

              // SECTION 2 — Profile Summary
              profileAsync.when(
                loading: () => ShimmerCard(height: 90.h),
                error: (e, _) => AppErrorWidget(
                  message: e.toString(),
                  onRetry: () => ref.refresh(profileProvider(handle)),
                ),
                data: (profile) => _buildProfileCard(profile),
              ),
              SizedBox(height: 12.h),

              // SECTION 3 — Rating Card
              profileAsync.when(
                loading: () => ShimmerCard(height: 80.h),
                error: (e, _) => const SizedBox.shrink(),
                data: (profile) => _buildRatingCard(profile),
              ),
              SizedBox(height: 12.h),

              // SECTION 4 — Stats Row
              profileAsync.when(
                loading: () => Row(
                  children: [
                    Expanded(child: ShimmerCard(height: 70.h)),
                    SizedBox(width: 12.w),
                    Expanded(child: ShimmerCard(height: 70.h)),
                  ],
                ),
                error: (e, _) => const SizedBox.shrink(),
                data: (profile) => _buildStatsRow(profile),
              ),
              SizedBox(height: 20.h),

              // SECTION 5 — Upcoming Contests
              SectionHeader(
                title: 'Upcoming Contests',
                actionLabel: 'See All',
                onAction: () => context.push('/contests/all'),
              ),
              SizedBox(height: 12.h),
              contestsAsync.when(
                loading: () => ShimmerCard(height: 180.h),
                error: (e, _) => AppErrorWidget(
                  message: e.toString(),
                  onRetry: () => ref.invalidate(upcomingContestsProvider),
                ),
                data: (contests) => _buildContestSwiper(contests),
              ),
              SizedBox(height: 20.h),

              // SECTION 6 — Quick Actions
              const SectionHeader(title: 'Quick Actions'),
              SizedBox(height: 12.h),
              _buildQuickActions(context),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(String handle, AsyncValue profileAsync) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16.h,
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    _getGreeting(),
                    textStyle: AppTextStyles.caption,
                    speed: const Duration(milliseconds: 80),
                  ),
                ],
                totalRepeatCount: 1,
                displayFullTextOnTap: true,
              ),
            ),
            Text(handle, style: AppTextStyles.h2),
          ],
        ),
        profileAsync.when(
          loading: () => CircleAvatar(
            radius: 20.r,
            backgroundColor: AppColors.primary.withValues(alpha: 0.20),
            child: Icon(
              Icons.person_outline_rounded,
              color: AppColors.primary,
              size: 20.r,
            ),
          ),
          error: (e, _) => CircleAvatar(
            radius: 20.r,
            backgroundColor: AppColors.primary.withValues(alpha: 0.20),
          ),
          data: (profile) => GestureDetector(
            onTap: () => context.push('/profile'),
            child: UserAvatar(
              handle: profile.handle,
              rank: profile.rank,
              size: 40.r,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard(dynamic profile) {
    return GlassCard(
      child: Row(
        children: [
          UserAvatar(handle: profile.handle, rank: profile.rank, size: 52.r),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(profile.handle, style: AppTextStyles.bodyBold),
                SizedBox(height: 4.h),
                RankChip(rank: profile.rank),
                SizedBox(height: 4.h),
                Text(
                  'Active: ${profile.lastActiveDate}',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('🔥', style: TextStyle(fontSize: 16.sp)),
              Text(
                '${profile.streakDays}d',
                style: AppTextStyles.metricSmall.copyWith(
                  color: AppColors.success,
                  fontSize: 16.sp,
                ),
              ),
              Text('streak', style: AppTextStyles.caption),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingCard(dynamic profile) {
    return GlassCard(
      type: GlassCardType.primary,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CF RATING',
                  style: AppTextStyles.caption.copyWith(letterSpacing: 1.0),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${profile.rating}',
                  style: AppTextStyles.metricLarge.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                Text('Max: ${profile.maxRating}', style: AppTextStyles.caption),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RankChip(rank: profile.rank),
              SizedBox(height: 8.h),
              Text(
                'Top Rated',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(dynamic profile) {
    return Row(
      children: [
        Expanded(
          child:
              StatCard(
                    icon: Icons.check_circle_rounded,
                    iconColor: AppColors.success,
                    value: '${profile.problemsSolved}',
                    label: 'Problems Solved',
                  )
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 400.ms)
                  .slideX(begin: -0.1, end: 0, delay: 200.ms),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child:
              StatCard(
                    icon: Icons.emoji_events_rounded,
                    iconColor: AppColors.primary,
                    value: '${profile.contestsParticipated}',
                    label: 'Contests',
                  )
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 400.ms)
                  .slideX(begin: 0.1, end: 0, delay: 300.ms),
        ),
      ],
    );
  }

  Widget _buildContestSwiper(List<Contest> contests) {
    if (contests.isEmpty) {
      return GlassCard(
        child: Center(
          child: Text('No upcoming contests', style: AppTextStyles.body),
        ),
      );
    }

    return SizedBox(
      height: 180.h,
      child: CardSwiper(
        controller: _cardController,
        cardsCount: contests.length,
        numberOfCardsDisplayed: contests.length > 2 ? 3 : contests.length,
        backCardOffset: Offset(8.w, 0),
        padding: EdgeInsets.zero,
        scale: 0.92,
        isLoop: false,
        allowedSwipeDirection: const AllowedSwipeDirection.only(
          left: true,
          right: true,
        ),
        cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
          return ContestCard(
            contest: contests[index],
            isReminderSet: _reminderSet.contains(index),
            onReminderToggle: () {
              setState(() {
                if (_reminderSet.contains(index)) {
                  _reminderSet.remove(index);
                } else {
                  _reminderSet.add(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Reminder set for ${contests[index].name}'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                }
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GlassCard(
            onTap: () => context.push('/practice'),
            child: Column(
              children: [
                Icon(
                  Icons.lightbulb_rounded,
                  color: AppColors.warning,
                  size: 28.r,
                ),
                SizedBox(height: 8.h),
                Text('Practice', style: AppTextStyles.bodyBold),
                Text('Weak topics', style: AppTextStyles.caption),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: GlassCard(
            onTap: () => context.push('/upsolve'),
            child: Column(
              children: [
                Icon(Icons.queue_rounded, color: AppColors.primary, size: 28.r),
                SizedBox(height: 8.h),
                Text('Upsolve', style: AppTextStyles.bodyBold),
                Text('Unsolved problems', style: AppTextStyles.caption),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: GlassCard(
            onTap: () => context.push('/analysis'),
            child: Column(
              children: [
                Icon(
                  Icons.auto_awesome_rounded,
                  color: AppColors.success,
                  size: 28.r,
                ),
                SizedBox(height: 8.h),
                Text('AI Analysis', style: AppTextStyles.bodyBold),
                Text('Get insights', style: AppTextStyles.caption),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning,';
    if (hour < 17) return 'Good afternoon,';
    return 'Good evening,';
  }
}
