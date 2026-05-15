import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
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
              title: Text(
                'Weak Topics',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () =>
                      context.goNamed(RouteNames.recommendations),
                  child: Text(
                    'Practice',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
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
                      message: e.toString(),
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
                          // Summary
                          _SummaryCard(topics: topics),
                          SizedBox(height: 20.h),

                          SectionHeader(
                            title: 'Topics to improve',
                            actionLabel: '${topics.length} topics',
                          ),
                          SizedBox(height: 12.h),

                          ...topics.map((t) => _TopicCard(topic: t)),

                          SizedBox(height: 12.h),

                          AppButton(
                            label: 'Get Practice Problems',
                            onTap: () =>
                                context.goNamed(RouteNames.recommendations),
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

// ─────────────────────────────────
// SUMMARY CARD
// Critical/High/Moderate counts
// ─────────────────────────────────

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.topics});

  final List<WeakTopicModel> topics;

  @override
  Widget build(BuildContext context) {
    final critical =
        topics.where((t) => t.severity == 'critical').length;
    final high = topics.where((t) => t.severity == 'high').length;
    final moderate =
        topics.where((t) => t.severity == 'moderate').length;

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
            style: GoogleFonts.jetBrainsMono(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
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
// TOPIC CARD
// Shows topic + AC rate bar
// ─────────────────────────────────

class _TopicCard extends StatelessWidget {
  const _TopicCard({required this.topic});
  final WeakTopicModel topic;

  @override
  Widget build(BuildContext context) {
    final color = Color(
      int.parse(
        topic.severityColor.replaceFirst('#', '0xFF'),
      ),
    );

    return GlassCard(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Severity indicator dot
              Container(
                width: 8.r,
                height: 8.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
              SizedBox(width: 10.w),

              // Topic name
              Expanded(
                child: Text(
                  topic.tag,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),

              // AC rate
              Text(
                topic.acRateFormatted,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          // AC rate progress bar
          ProgressBarWidget(
            value: topic.acRate,
            color: color,
          ),
          SizedBox(height: 8.h),

          // Stats row
          Row(
            children: [
              Text(
                '${topic.solvedCount} solved',
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.success.withValues(alpha: 0.80),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                '${topic.unsolvedCount} unsolved',
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.danger.withValues(alpha: 0.80),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                '${topic.totalAttempts} total',
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withValues(alpha: 0.50),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
