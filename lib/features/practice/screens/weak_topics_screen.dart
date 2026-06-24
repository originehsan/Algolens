import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/empty_widget.dart';
import 'package:algolens/core/widgets/error_widget.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/loading_shimmer.dart';
import 'package:algolens/core/widgets/progress_bar_widget.dart';
import 'package:algolens/core/widgets/section_header.dart';
import 'package:algolens/features/practice/data/models/weak_topic_model.dart';
import 'package:algolens/features/practice/providers/practice_provider.dart';

class WeakTopicsScreen extends ConsumerWidget {
  const WeakTopicsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topicsAsync = ref.watch(weakTopicsProvider);

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              floating: true,
              title: Text('Weak Topics', style: AppTextStyles.h2),
              actions: [
                TextButton(
                  // push — recommendations is outside ShellRoute
                  onPressed: () =>
                      context.pushNamed(RouteNames.recommendations),
                  child: Text('Practice', style: AppTextStyles.link),
                ),
              ],
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: 8.h),
                  topicsAsync.when(
                    loading: () => const PracticeListShimmer(),
                    error: (e, s) => AppErrorWidget(
                      message: e is ApiException
                          ? e.message
                          : 'Something went wrong. Please try again.',
                      onRetry: () => ref.invalidate(weakTopicsProvider),
                    ),
                    data: (topics) {
                      if (topics.isEmpty) {
                        return const EmptyWidget(
                          icon: Icons.auto_awesome_rounded,
                          message: 'No weak topics!',
                          subtitle: 'You\'re doing great across all topics.',
                        );
                      }
                      return Column(
                        children: [
                          _SummaryCard(topics: topics),
                          SizedBox(height: 20.h),
                          SectionHeader(
                            title: 'Topics to improve',
                            subtitle: '${topics.length} topics found',
                          ),
                          SizedBox(height: 12.h),
                          ...topics.map((t) => _TopicCard(topic: t)),
                          SizedBox(height: 12.h),
                          AppButton(
                            label: 'Get Practice Problems',
                            // push — recommendations outside ShellRoute
                            onTap: () =>
                                context.pushNamed(RouteNames.recommendations),
                            icon: Icons.arrow_forward_rounded,
                          ),
                          SizedBox(height: 100.h),
                        ],
                      );
                    },
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.topics});
  final List<WeakTopicModel> topics;

  @override
  Widget build(BuildContext context) {
    final critical = topics.where((t) => t.severity == 'critical').length;
    final high = topics.where((t) => t.severity == 'high').length;
    final moderate = topics.where((t) => t.severity == 'moderate').length;

    return GlassCard(
      child: Row(
        children: [
          _SeverityCount(
            label: 'Critical',
            count: critical,
            color: AppColors.danger,
          ),
          _SeverityCount(
            label: 'High',
            count: high,
            color: AppColors.warning,
          ),
          _SeverityCount(
            label: 'Moderate',
            count: moderate,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class _SeverityCount extends StatelessWidget {
  const _SeverityCount({
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
            style: AppTextStyles.metricMedium.copyWith(color: color),
          ),
          SizedBox(height: 4.h),
          Text(label, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({required this.topic});
  final WeakTopicModel topic;

  @override
  Widget build(BuildContext context) {
    final color = Color(
      int.parse(topic.severityColor.replaceFirst('#', '0xFF')),
    );

    return GlassCard(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8.r,
                height: 8.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(topic.tag, style: AppTextStyles.bodyBold),
              ),
              Text(
                topic.acRateFormatted,
                style: AppTextStyles.metricSmall.copyWith(
                  fontSize: 13.sp,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ProgressBarWidget(value: topic.acRate, color: color),
          SizedBox(height: 8.h),
          Row(
            children: [
              Text(
                '${topic.solvedCount} solved',
                style: AppTextStyles.hint.copyWith(
                  color: AppColors.success.withValues(alpha: 0.80),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                '${topic.unsolvedCount} unsolved',
                style: AppTextStyles.hint.copyWith(
                  color: AppColors.danger.withValues(alpha: 0.80),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                '${topic.totalAttempts} total',
                style: AppTextStyles.hint,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
