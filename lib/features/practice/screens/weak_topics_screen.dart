import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/page_wrapper.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/section_header.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/loading_shimmer.dart';
import 'package:algolens/core/widgets/error_widget.dart';
import 'package:algolens/core/widgets/empty_widget.dart';
import 'package:algolens/core/widgets/progress_bar_widget.dart';
import 'package:algolens/core/widgets/coming_soon_badge.dart';
import 'package:algolens/features/auth/providers/auth_provider.dart';
import 'package:algolens/features/practice/providers/practice_provider.dart';
import 'package:algolens/features/practice/data/models/weak_topic_model.dart';

class WeakTopicsScreen extends ConsumerWidget {
  const WeakTopicsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final handle = authState.handle ?? 'ehsan_cf';
    final weakTopicsAsync = ref.watch(weakTopicsProvider(handle));

    return PageWrapper(
      title: 'Practice',
      child: weakTopicsAsync.when(
        loading: () => ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          children: [
            SizedBox(height: 12.h),
            ShimmerCard(height: 200.h),
            SizedBox(height: 16.h),
            const ShimmerList(count: 4),
          ],
        ),
        error: (error, _) => AppErrorWidget(
          message: error.toString(),
          onRetry: () => ref.refresh(
            weakTopicsProvider(handle),
          ),
        ),
        data: (topics) {
          if (topics.isEmpty) {
            return const AppEmptyWidget(
              title: 'No Weak Topics Found',
              subtitle: 'Keep solving problems to get analysis',
              icon: Icons.analytics_outlined,
            );
          }
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.h),

                // Summary card
                GlassCard(
                  borderColor: AppColors.warning.withValues(alpha: 0.40),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.analytics_outlined,
                          color: AppColors.warning,
                          size: 24.r,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${topics.length} Weak Topics Found',
                              style: AppTextStyles.bodyBold,
                            ),
                            Text(
                              'Focus on these to improve your rating',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                SectionHeader(
                  title: 'Your Weak Areas',
                  actionLabel: 'Practice',
                  onActionTap: () => context.push(
                    '/practice/recommendations',
                  ),
                ),
                SizedBox(height: 12.h),

                // Topics list
                ...topics.asMap().entries.map(
                  (entry) {
                    final topic = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: 12.h,
                      ),
                      child: _buildTopicCard(
                        topic,
                      ),
                    );
                  },
                ),

                SizedBox(height: 16.h),
                AppButton(
                  label: 'Practice Weak Topics',
                  onPressed: () => context.push(
                    '/practice/recommendations',
                  ),
                ),
                SizedBox(height: 16.h),

                // Coming soon section
                const SectionHeader(
                  title: 'Coming Soon',
                ),
                SizedBox(height: 8.h),
                GlassCard(
                  child: Column(
                    children: [
                      _buildComingSoonRow(
                        'LeetCode Analysis',
                        Icons.code_outlined,
                      ),
                      SizedBox(height: 10.h),
                      _buildComingSoonRow(
                        'CodeChef Analysis',
                        Icons.restaurant_outlined,
                      ),
                      SizedBox(height: 10.h),
                      _buildComingSoonRow(
                        'AI Topic Suggestions',
                        Icons.auto_awesome_outlined,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopicCard(WeakTopic topic) {
    return GlassCard(
      borderColor: topic.severityColor.withValues(alpha: 0.40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  topic.tag,
                  style: AppTextStyles.bodyBold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 3.h,
                ),
                decoration: BoxDecoration(
                  color: topic.severityColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: topic.severityColor.withValues(alpha: 0.40),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  topic.severity,
                  style: AppTextStyles.caption.copyWith(
                    color: topic.severityColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ProgressBarWidget(
            percentage: topic.acRate,
            color: topic.severityColor,
            showPercentageText: true,
            label: 'Acceptance Rate',
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Text(
                '${topic.solvedCount} solved',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.success,
                ),
              ),
              Text(
                ' / ',
                style: AppTextStyles.caption,
              ),
              Text(
                '${topic.totalAttempts} attempts',
                style: AppTextStyles.caption,
              ),
            ],
          ),
        ],
      ),
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
