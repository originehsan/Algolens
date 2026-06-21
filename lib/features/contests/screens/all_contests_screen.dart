import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/contest_card.dart';
import 'package:algolens/core/widgets/error_widget.dart';
import 'package:algolens/core/widgets/loading_shimmer.dart';
import 'package:algolens/features/contests/providers/contest_provider.dart';

class AllContestsScreen extends ConsumerWidget {
  const AllContestsScreen({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final contestsAsync = ref.watch(
      allContestsProvider,
    );
    final notifier = ref.read(
      allContestsProvider.notifier,
    );

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              floating: true,
              title: Text(
                'All Contests',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              sliver: contestsAsync.when(
                loading: () => const SliverToBoxAdapter(
                  child: ContestListShimmer(
                    count: 8,
                  ),
                ),
                error: (e, s) => SliverToBoxAdapter(
                  child: AppErrorWidget(
                    message: e.toString(),
                    onRetry: () => notifier.refresh(),
                  ),
                ),
                data: (contests) => SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      // Load more at end
                      if (index == contests.length) {
                        if (notifier.hasMore) {
                          notifier.loadMore();
                          return Padding(
                            padding: EdgeInsets.all(16.r),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.all(16.r),
                          child: Center(
                            child: Text(
                              'No more contests',
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                color: Colors.white.withValues(alpha: 0.40),
                              ),
                            ),
                          ),
                        );
                      }

                      final c = contests[index];
                      final status = c.isLive
                          ? ContestStatus.live
                          : c.isUpcoming
                              ? ContestStatus.upcoming
                              : ContestStatus.finished;

                      return ContestCard(
                        contestId: c.contestId,
                        name: c.name,
                        status: status,
                        difficulty: c.difficulty,
                        startDateTime: c.startDateTime,
                        durationFormatted: c.durationFormatted,
                        hasReminder: false,
                        onReminderTap: () {},
                        margin: EdgeInsets.only(
                          bottom: 12.h,
                        ),
                      );
                    },
                    childCount: contests.length + 1,
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
