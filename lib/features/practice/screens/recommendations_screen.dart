import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/empty_widget.dart';
import 'package:algolens/core/widgets/error_widget.dart';
import 'package:algolens/core/widgets/loading_shimmer.dart';
import 'package:algolens/core/widgets/problem_row.dart';
import 'package:algolens/core/widgets/section_header.dart';
import 'package:algolens/features/practice/providers/practice_provider.dart';

class RecommendationsScreen extends ConsumerWidget {
  const RecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final problemsAsync = ref.watch(recommendationsProvider);

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              floating: true,
              title: Text(
                'Recommendations',
                style: AppTextStyles.h2,
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: 8.h),
                  problemsAsync.when(
                    loading: () => const PracticeListShimmer(),
                    error: (e, s) => AppErrorWidget(
                      message: e.toString(),
                      onRetry: () => ref.invalidate(recommendationsProvider),
                    ),
                    data: (problems) {
                      if (problems.isEmpty) {
                        return const EmptyWidget(
                          icon: Icons.check_circle_rounded,
                          message: 'All caught up!',
                          subtitle: 'No recommendations right now. Keep solving problems!',
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionHeader(
                            title: 'For you',
                            subtitle: '${problems.length} problems',
                          ),
                          SizedBox(height: 12.h),
                          ...problems.map(
                            (p) => ProblemRow(
                              contestId: p.contestId,
                              index: p.index,
                              name: p.name,
                              rating: p.rating,
                              tags: p.tags,
                              url: p.url,
                            ),
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