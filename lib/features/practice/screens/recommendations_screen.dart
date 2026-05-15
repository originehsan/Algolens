import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
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
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
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
                      onRetry: () =>
                          ref.invalidate(recommendationsProvider),
                    ),
                    data: (problems) {
                      if (problems.isEmpty) {
                        return const EmptyWidget(
                          icon: Icons.check_circle_rounded,
                          message: 'All caught up!',
                          subtitle:
                              'No recommendations right now. Keep solving problems!',
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionHeader(
                            title: 'For you',
                            actionLabel: '${problems.length} problems',
                          ),
                          SizedBox(height: 12.h),

                          ...problems.map(
                            (p) => ProblemRow(
                              name: p.name,
                              rating: p.rating,
                              tags: p.tags,
                              contestId: p.contestId,
                              index: p.index,
                              url: p.url,
                              onTap: () async {
                                final uri = Uri.parse(p.url);
                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(
                                    uri,
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                              },
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
