import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/page_wrapper.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/section_header.dart';
import 'package:algolens/core/widgets/loading_shimmer.dart';
import 'package:algolens/core/widgets/error_widget.dart';
import 'package:algolens/core/widgets/empty_widget.dart';
import 'package:algolens/features/auth/providers/auth_provider.dart';
import 'package:algolens/features/analysis/providers/analysis_provider.dart';
import 'package:algolens/features/analysis/data/models/analysis_model.dart';

class AIAnalysisScreen extends ConsumerWidget {
  const AIAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final handle = authState.handle ?? 'ehsan_cf';
    final analysisAsync = ref.watch(aiAnalysisProvider(handle));

    return PageWrapper(
      title: 'AI Analysis',
      showBackButton: true,
      child: analysisAsync.when(
        loading: () => ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          children: [
            SizedBox(height: 12.h),
            GlassCard(
              child: Row(
                children: [
                  SizedBox(
                    width: 20.r,
                    height: 20.r,
                    child: const CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Analyzing your problems...',
                    style: AppTextStyles.body,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            const ShimmerList(count: 3),
          ],
        ),
        error: (error, _) => AppErrorWidget(
          message: error.toString(),
          onRetry: () => ref.invalidate(aiAnalysisProvider(handle)),
        ),
        data: (analysis) {
          if (analysis.problemAnalyses.isEmpty) {
            return const AppEmptyWidget(
              title: 'No Analysis Available',
              subtitle: 'Participate in contests to get AI analysis',
              icon: Icons.auto_awesome_outlined,
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

                // Overall recommendation card
                GlassCard(
                  borderColor: AppColors.primary.withValues(alpha: 0.40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Icon(
                              Icons.auto_awesome_rounded,
                              color: AppColors.primary,
                              size: 20.r,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'AI Recommendation',
                            style: AppTextStyles.h3,
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        analysis.overallRecommendation,
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                const SectionHeader(
                  title: 'Problem Analysis',
                ),
                SizedBox(height: 12.h),

                // Problem analysis list
                ...analysis.problemAnalyses.asMap().entries.map(
                  (entry) {
                    final item = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: 12.h,
                      ),
                      child: _buildAnalysisCard(item),
                    );
                  },
                ),
                SizedBox(height: 100.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnalysisCard(ProblemAnalysis item) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Problem title
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.30),
                  ),
                ),
                child: Text(
                  '${item.contestId}${item.problemIndex}',
                  style: AppTextStyles.metricSmall.copyWith(
                    fontSize: 11.sp,
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  item.problemName,
                  style: AppTextStyles.bodyBold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Likely issue
          _buildInfoRow(
            icon: Icons.warning_amber_rounded,
            iconColor: AppColors.warning,
            label: 'Likely Issue',
            content: item.likelyIssue,
          ),
          SizedBox(height: 8.h),

          // Concept to study
          _buildInfoRow(
            icon: Icons.school_rounded,
            iconColor: AppColors.primary,
            label: 'Study This',
            content: item.conceptToStudy,
          ),
          SizedBox(height: 8.h),

          // Actionable tip
          _buildInfoRow(
            icon: Icons.tips_and_updates_rounded,
            iconColor: AppColors.success,
            label: 'Action',
            content: item.actionableTip,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(5.r),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 14.r,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  color: iconColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                content,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
