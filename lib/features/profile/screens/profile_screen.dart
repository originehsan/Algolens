import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/page_wrapper.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/section_header.dart';
import 'package:algolens/core/widgets/stat_card.dart';
import 'package:algolens/core/widgets/user_avatar.dart';
import 'package:algolens/core/widgets/rank_chip.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/loading_shimmer.dart';
import 'package:algolens/core/widgets/error_widget.dart';
import 'package:algolens/core/widgets/coming_soon_badge.dart';
import 'package:algolens/features/auth/providers/auth_provider.dart';
import 'package:algolens/features/profile/providers/profile_provider.dart';
import 'package:fl_chart/fl_chart.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final handle = authState.handle ?? 'ehsan_cf';
    final profileAsync = ref.watch(profileProvider(handle));
    final ratingGraphAsync = ref.watch(ratingGraphProvider(handle));
    final submissionStatsAsync = ref.watch(submissionStatsProvider(handle));

    return PageWrapper(
      title: 'Profile',
      actions: [
        IconButton(
          icon: Icon(
            Icons.settings_outlined,
            color: Colors.white,
            size: 22.r,
          ),
          onPressed: () => context.push('/settings'),
        ),
      ],
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(profileProvider(handle));
          ref.invalidate(ratingGraphProvider(handle));
          ref.invalidate(submissionStatsProvider(handle));
        },
        color: AppColors.primary,
        backgroundColor: AppColors.bgMid,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),

              // Profile header card
              profileAsync.when(
                loading: () => ShimmerCard(height: 100.h),
                error: (e, _) => AppErrorWidget(
                  message: e.toString(),
                  onRetry: () => ref.invalidate(
                    profileProvider(handle),
                  ),
                ),
                data: (profile) => GlassCard(
                  type: GlassCardType.primary,
                  child: Row(
                    children: [
                      UserAvatar(
                        handle: profile.handle,
                        rank: profile.rank,
                        size: 64.r,
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile.handle,
                              style: AppTextStyles.h2,
                            ),
                            SizedBox(height: 4.h),
                            RankChip(
                              rank: profile.rank,
                            ),
                            SizedBox(height: 6.h),
                            Row(
                              children: [
                                Text(
                                  '${profile.rating}',
                                  style: AppTextStyles.metricLarge.copyWith(
                                    color: AppColors.primary,
                                    fontSize: 22.sp,
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  '/ ${profile.maxRating} max',
                                  style: AppTextStyles.caption,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '🔥 ${profile.streakDays}d',
                            style: AppTextStyles.bodyBold.copyWith(
                              color: AppColors.success,
                            ),
                          ),
                          Text(
                            'streak',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              // Stats row
              profileAsync.when(
                loading: () => Row(
                  children: [
                    Expanded(child: ShimmerCard(height: 70.h)),
                    SizedBox(width: 12.w),
                    Expanded(child: ShimmerCard(height: 70.h)),
                    SizedBox(width: 12.w),
                    Expanded(child: ShimmerCard(height: 70.h)),
                  ],
                ),
                error: (e, _) => const SizedBox.shrink(),
                data: (profile) => Row(
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
                        iconColor: AppColors.primary,
                        value: '${profile.contestsParticipated}',
                        label: 'Contests',
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: StatCard(
                        icon: Icons.local_fire_department_rounded,
                        iconColor: AppColors.warning,
                        value: '${profile.streakDays}d',
                        label: 'Streak',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Rating graph
              const SectionHeader(
                title: 'Rating History',
              ),
              SizedBox(height: 12.h),
              ratingGraphAsync.when(
                loading: () => ShimmerCard(height: 180.h),
                error: (e, _) => const SizedBox.shrink(),
                data: (points) => Padding(
                  padding: EdgeInsets.zero,
                  child: GlassCard(
                    padding: EdgeInsets.all(16.r),
                    child: SizedBox(
                      height: 180.h,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            horizontalInterval: 200,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: Colors.white.withValues(alpha: 0.08),
                                strokeWidth: 1,
                              );
                            },
                          ),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40.w,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    style: AppTextStyles.monoSmall.copyWith(
                                      fontSize: 9.sp,
                                    ),
                                  );
                                },
                              ),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: false,
                              ),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: false,
                              ),
                            ),
                            bottomTitles: const AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: false,
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: points
                                  .asMap()
                                  .entries
                                  .map(
                                    (e) => FlSpot(
                                      e.key.toDouble(),
                                      e.value.rating.toDouble(),
                                    ),
                                  )
                                  .toList(),
                              isCurved: true,
                              color: AppColors.primary,
                              barWidth: 2.5,
                              isStrokeCapRound: true,
                              dotData: FlDotData(
                                show: true,
                                getDotPainter: (spot, percent, barData, index) {
                                  return FlDotCirclePainter(
                                    radius: 3.r,
                                    color: AppColors.primary,
                                    strokeWidth: 1.5,
                                    strokeColor:
                                        Colors.white.withValues(alpha: 0.5),
                                  );
                                },
                              ),
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppColors.primary.withValues(alpha: 0.25),
                                    AppColors.primary.withValues(alpha: 0.0),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 300.ms, duration: 600.ms).slideY(
                      begin: 0.1,
                      end: 0,
                      delay: 300.ms,
                      duration: 600.ms,
                    ),
              ),
              SizedBox(height: 20.h),

              // Submission stats
              const SectionHeader(
                title: 'Submission Stats',
              ),
              SizedBox(height: 12.h),
              submissionStatsAsync.when(
                loading: () => ShimmerCard(height: 80.h),
                error: (e, _) => const SizedBox.shrink(),
                data: (stats) => GlassCard(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildVerdictStat(
                            'AC',
                            stats.verdictsCount['ACCEPTED'] ?? 0,
                            AppColors.success,
                          ),
                          _buildVerdictStat(
                            'WA',
                            stats.verdictsCount['WRONG_ANSWER'] ?? 0,
                            AppColors.danger,
                          ),
                          _buildVerdictStat(
                            'TLE',
                            stats.verdictsCount['TIME_LIMIT_EXCEEDED'] ?? 0,
                            AppColors.warning,
                          ),
                          _buildVerdictStat(
                            'MLE',
                            stats.verdictsCount['MEMORY_LIMIT_EXCEEDED'] ?? 0,
                            AppColors.warning,
                          ),
                          _buildVerdictStat(
                            'RE',
                            stats.verdictsCount['RUNTIME_ERROR'] ?? 0,
                            AppColors.textMuted,
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Submissions',
                              style: AppTextStyles.caption,
                            ),
                            Text(
                              '${stats.totalSubmissions}',
                              style: AppTextStyles.metricSmall.copyWith(
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Friends and Compare
              const SectionHeader(
                title: 'Social',
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'Friends',
                      onTap: () => context.push('/friends'),
                      type: AppButtonType.outline,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: AppButton(
                      label: 'Compare',
                      onTap: () => context.push('/comparison'),
                      type: AppButtonType.outline,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              AppButton(
                label: 'Get AI Analysis',
                onTap: () => context.push('/analysis'),
              ),
              SizedBox(height: 20.h),

              // Coming soon
              const SectionHeader(
                title: 'Coming Soon',
              ),
              SizedBox(height: 8.h),
              GlassCard(
                child: Column(
                  children: [
                    _buildComingSoonRow(
                      'LeetCode Integration',
                      Icons.code_outlined,
                    ),
                    SizedBox(height: 10.h),
                    _buildComingSoonRow(
                      'CodeChef Integration',
                      Icons.restaurant_outlined,
                    ),
                    SizedBox(height: 10.h),
                    _buildComingSoonRow(
                      'College Leaderboard',
                      Icons.school_outlined,
                    ),
                    SizedBox(height: 10.h),
                    _buildComingSoonRow(
                      'Activity Heatmap',
                      Icons.grid_view_outlined,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerdictStat(String label, int count, Color color) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: AppTextStyles.metricSmall.copyWith(
            color: color,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: color.withValues(alpha: 0.80),
          ),
        ),
      ],
    );
  }

  Widget _buildComingSoonRow(String label, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.textMuted,
          size: 18.r,
        ),
        SizedBox(width: 10.w),
        Text(
          label,
          style: AppTextStyles.body,
        ),
        const Spacer(),
        const ComingSoonBadge(),
      ],
    );
  }
}
