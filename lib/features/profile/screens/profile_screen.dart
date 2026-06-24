import 'package:algolens/core/local/share_profile_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/error_widget.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/loading_shimmer.dart';
import 'package:algolens/core/widgets/progress_bar_widget.dart';
import 'package:algolens/core/widgets/rank_chip.dart';
import 'package:algolens/core/widgets/section_header.dart';
import 'package:algolens/core/widgets/stat_card.dart';
import 'package:algolens/core/widgets/user_avatar.dart';
import 'package:algolens/features/profile/data/models/contest_history_model.dart';
import 'package:algolens/features/profile/data/models/profile_model.dart';
import 'package:algolens/features/profile/data/models/rating_graph_model.dart';
import 'package:algolens/features/profile/data/models/submission_stats_model.dart';
import 'package:algolens/features/profile/providers/profile_provider.dart';

// ─────────────────────────────────
// PROFILE SCREEN
// Loads own handle via cfHandleProvider
// then fetches all 4 data streams
// ─────────────────────────────────

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final handleAsync = ref.watch(cfHandleProvider);

    return handleAsync.when(
      loading: () => _LoadingView(),
      error: (e, s) => _ErrorView(
        message: e is ApiException
            ? e.message
            : 'Something went wrong. Please try again.',
        onRetry: () => ref.invalidate(cfHandleProvider),
      ),
      data: (handle) {
        if (handle == null || handle.isEmpty) {
          return _ErrorView(
            message: 'No CF handle found.\nPlease set up your handle.',
            onRetry: () => ref.invalidate(cfHandleProvider),
          );
        }
        return _ProfileContent(handle: handle);
      },
    );
  }
}

// ─────────────────────────────────
// PROFILE CONTENT
// Loads all data for handle
// ─────────────────────────────────

class _ProfileContent extends ConsumerWidget {
  const _ProfileContent({required this.handle});

  final String handle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider(handle));
    final graphAsync = ref.watch(ratingGraphProvider(handle));
    final statsAsync = ref.watch(submissionStatsProvider(handle));
    final historyAsync = ref.watch(contestHistoryProvider(handle));

    return profileAsync.when(
      loading: () => _LoadingView(),
      error: (e, s) => _ErrorView(
        message: e is ApiException
            ? e.message
            : 'Something went wrong. Please try again.',
        onRetry: () {
          ref.invalidate(profileProvider(handle));
          ref.invalidate(ratingGraphProvider(handle));
          ref.invalidate(submissionStatsProvider(handle));
          ref.invalidate(contestHistoryProvider(handle));
        },
      ),
      data: (profile) => AppBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: RefreshIndicator(
            color: AppColors.primary,
            backgroundColor: AppColors.bgMid,
            onRefresh: () async {
              ref.invalidate(profileProvider(handle));
              ref.invalidate(ratingGraphProvider(handle));
              ref.invalidate(submissionStatsProvider(handle));
              ref.invalidate(contestHistoryProvider(handle));
            },
            child: CustomScrollView(
              slivers: [
                // ──────────────────────
                // APP BAR
                // ──────────────────────
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  floating: true,
                  title: Text(
                    'Profile',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () =>
                          ShareProfileService.share(context, profile),
                      icon: Icon(
                        Icons.share_rounded,
                        color: Colors.white.withValues(alpha: 0.70),
                        size: 22.r,
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          context.pushNamed(RouteNames.settings),
                      icon: Icon(
                        Icons.settings_rounded,
                        color: Colors.white.withValues(alpha: 0.70),
                        size: 22.r,
                      ),
                    ),
                  ],
                ),

                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(height: 8.h),

                      // ──────────────────────
                      // HEADER CARD
                      // ──────────────────────
                      _HeaderCard(profile: profile),

                      SizedBox(height: 16.h),

                      // ──────────────────────
                      // RATING HERO CARD
                      // ──────────────────────
                      _RatingCard(profile: profile),

                      SizedBox(height: 16.h),

                      // ──────────────────────
                      // STATS ROW
                      // ──────────────────────
                      Row(
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
                      ),

                      SizedBox(height: 20.h),

                      // ──────────────────────
                      // RATING GRAPH
                      // ──────────────────────
                      const SectionHeader(title: 'Rating History'),
                      SizedBox(height: 12.h),
                      graphAsync.when(
                        loading: () => GlassCardShimmer(height: 200.h),
                        error: (e, s) => const SizedBox.shrink(),
                        data: (graph) => _RatingGraph(data: graph),
                      ),

                      SizedBox(height: 20.h),

                      // ──────────────────────
                      // VERDICT STATS
                      // ──────────────────────
                      const SectionHeader(title: 'Submission Stats'),
                      SizedBox(height: 12.h),
                      statsAsync.when(
                        loading: () => GlassCardShimmer(height: 160.h),
                        error: (e, s) => const SizedBox.shrink(),
                        data: (stats) => _VerdictGrid(stats: stats),
                      ),

                      SizedBox(height: 20.h),

                      // ──────────────────────
                      // CONTEST HISTORY
                      // ──────────────────────
                      const SectionHeader(title: 'Contest History'),
                      SizedBox(height: 12.h),
                      historyAsync.when(
                        loading: () => GlassCardShimmer(height: 200.h),
                        error: (e, s) => const SizedBox.shrink(),
                        data: (history) => _ContestHistory(items: history),
                      ),

                      SizedBox(height: 20.h),

                      // ──────────────────────
                      // ACTION BUTTONS
                      // Friends + AI Analysis
                      // ──────────────────────
                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              label: 'Friends',
                              type: AppButtonType.outline,
                              icon: Icons.people_rounded,
                              onTap: () =>
                                  context.pushNamed(RouteNames.friends),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: AppButton(
                              label: 'AI Analysis',
                              icon: Icons.auto_awesome_rounded,
                              onTap: () =>
                                  context.pushNamed(RouteNames.aiAnalysis),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 100.h),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────
// HEADER CARD
// Avatar + handle + rank chip
// ─────────────────────────────────

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.profile});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        children: [
          UserAvatar(
            handle: profile.handle,
            rank: profile.rank,
            avatarUrl: profile.avatar,
            size: 64.r,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.handle,
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 6.h),
                RankChip(rank: profile.rank),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────
// RATING CARD
// Current + max + ratingDelta + rank
// ─────────────────────────────────

class _RatingCard extends StatelessWidget {
  const _RatingCard({required this.profile});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final isPositive = profile.ratingDelta >= 0;

    return GlassCard(
      type: GlassCardType.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Rating',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.55),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${profile.rating}',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: 12.w),
              Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Max: ${profile.maxRating}',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.55),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      isPositive
                          ? '+${profile.ratingDelta}'
                          : '${profile.ratingDelta}',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: isPositive
                            ? AppColors.success
                            : AppColors.danger,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              RankChip(rank: profile.rank),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────
// RATING GRAPH
// fl_chart line chart
// ─────────────────────────────────

class _RatingGraph extends StatelessWidget {
  const _RatingGraph({required this.data});

  final List<RatingGraphModel> data;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return GlassCard(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Text(
              'No rating history yet',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.55),
              ),
            ),
          ),
        ),
      );
    }

    final spots = data
        .asMap()
        .entries
        .map((e) => FlSpot(e.key.toDouble(), e.value.rating.toDouble()))
        .toList();

    final minY = data
            .map((e) => e.rating)
            .reduce((a, b) => a < b ? a : b)
            .toDouble() -
        100;

    final maxY = data
            .map((e) => e.rating)
            .reduce((a, b) => a > b ? a : b)
            .toDouble() +
        100;

    return GlassCard(
      child: SizedBox(
        height: 200.h,
        child: LineChart(
          LineChartData(
            minY: minY,
            maxY: maxY,
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: const FlTitlesData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: AppColors.primary,
                barWidth: 2,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  color: AppColors.primary.withValues(alpha: 0.10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────
// VERDICT GRID
// AC rate bar + AC/WA/TLE/MLE
// ─────────────────────────────────

class _VerdictGrid extends StatelessWidget {
  const _VerdictGrid({required this.stats});

  final SubmissionStatsModel stats;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          ProgressBarWidget(
            value: stats.acRate,
            color: AppColors.success,
            label: 'AC Rate',
            showPercentage: true,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              _VerdictItem(
                label: 'AC',
                count: stats.accepted,
                color: AppColors.success,
              ),
              _VerdictItem(
                label: 'WA',
                count: stats.wrongAnswer,
                color: AppColors.danger,
              ),
              _VerdictItem(
                label: 'TLE',
                count: stats.timeLimitExceeded,
                color: AppColors.warning,
              ),
              _VerdictItem(
                label: 'MLE',
                count: stats.memoryLimitExceeded,
                color: AppColors.warning,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VerdictItem extends StatelessWidget {
  const _VerdictItem({
    required this.label,
    required this.count,
    required this.color,
  });

  final String label;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            '$count',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.55),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────
// CONTEST HISTORY
// Last 10 entries
// ─────────────────────────────────

class _ContestHistory extends StatelessWidget {
  const _ContestHistory({required this.items});

  final List<ContestHistoryModel> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return GlassCard(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Text(
              'No contest history yet',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.55),
              ),
            ),
          ),
        ),
      );
    }

    final limited = items.length > 10 ? items.sublist(0, 10) : items;

    return Column(
      children: limited.map((item) => _ContestItem(item: item)).toList(),
    );
  }
}

class _ContestItem extends StatelessWidget {
  const _ContestItem({required this.item});

  final ContestHistoryModel item;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Text(
                '#${item.rank}',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              item.contestName,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.80),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            item.formattedChange,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: item.isPositive ? AppColors.success : AppColors.danger,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────
// LOADING VIEW
// ─────────────────────────────────

class _LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 16.h,
            ),
            child: const ProfileShimmer(),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────
// ERROR VIEW
// ─────────────────────────────────

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AppErrorWidget(
          message: message,
          onRetry: onRetry,
        ),
      ),
    );
  }
}