import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/page_wrapper.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/section_header.dart';
import 'package:algolens/core/widgets/segmented_tab.dart';
import 'package:algolens/core/widgets/loading_shimmer.dart';
import 'package:algolens/core/widgets/error_widget.dart';
import 'package:algolens/core/widgets/empty_widget.dart';
import 'package:algolens/features/auth/providers/auth_provider.dart';
import 'package:algolens/features/upsolve/providers/upsolve_provider.dart';
import 'package:algolens/features/upsolve/data/models/upsolve_model.dart';

class UpsolveScreen extends ConsumerStatefulWidget {
  const UpsolveScreen({super.key});

  @override
  ConsumerState<UpsolveScreen> createState() => _UpsolveScreenState();
}

class _UpsolveScreenState extends ConsumerState<UpsolveScreen> {
  int _selectedTab = 0;
  final Set<String> _solvedProblems = {};

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final handle = authState.handle ?? 'ehsan_cf';
    final upsolveAsync = ref.watch(upsolveProvider(handle));

    return PageWrapper(
      title: 'Upsolve Queue',
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 12.h,
            ),
            child: SegmentedTab(
              tabs: const ['Pending', 'Solved'],
              selectedIndex: _selectedTab,
              onTabSelected: (index) => setState(
                () => _selectedTab = index,
              ),
            ),
          ),
          Expanded(
            child: upsolveAsync.when(
              loading: () => ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                children: [
                  ShimmerCard(height: 30.h),
                  SizedBox(height: 8.h),
                  const ShimmerList(count: 3),
                  SizedBox(height: 16.h),
                  ShimmerCard(height: 30.h),
                  SizedBox(height: 8.h),
                  const ShimmerList(count: 2),
                ],
              ),
              error: (error, _) => AppErrorWidget(
                message: error.toString(),
                onRetry: () => ref.refresh(
                  upsolveProvider(handle),
                ),
              ),
              data: (contests) {
                // Filter all problems
                final allProblems = contests.expand((c) => c.problems).toList();

                final pendingProblems = allProblems
                    .where((p) =>
                        !_solvedProblems.contains('${p.contestId}_${p.index}'))
                    .toList();

                final solvedProblems = allProblems
                    .where((p) =>
                        _solvedProblems.contains('${p.contestId}_${p.index}'))
                    .toList();

                if (_selectedTab == 0) {
                  return _buildPendingTab(
                    contests,
                    pendingProblems,
                    context,
                  );
                } else {
                  return _buildSolvedTab(
                    solvedProblems,
                    context,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingTab(
    List<UpsolveContest> contests,
    List<UpsolveItem> pendingProblems,
    BuildContext context,
  ) {
    if (pendingProblems.isEmpty) {
      return AppEmptyWidget(
        title: 'All Caught Up!',
        subtitle: 'You have solved all upsolve problems',
        icon: Icons.check_circle_outline_rounded,
        buttonLabel: 'Browse Contests',
        onButtonTap: () => context.push('/contests'),
      );
    }

    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      children: [
        // Summary bar
        GlassCard(
          padding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 10.h,
          ),
          child: Row(
            children: [
              Icon(
                Icons.queue_rounded,
                color: AppColors.primary,
                size: 18.r,
              ),
              SizedBox(width: 8.w),
              Text(
                '${pendingProblems.length} problems to upsolve',
                style: AppTextStyles.bodyBold,
              ),
              const Spacer(),
              Text(
                '${_solvedProblems.length} solved',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.success,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Contest groups
        ...contests.asMap().entries.map((entry) {
          final contest = entry.value;
          final pendingInContest = contest.problems
              .where((p) => !_solvedProblems.contains(
                    '${p.contestId}_${p.index}',
                  ))
              .toList();

          if (pendingInContest.isEmpty) {
            return const SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                title: 'Contest ${contest.contestId}',
              ),
              SizedBox(height: 8.h),
              ...pendingInContest.asMap().entries.map((problemEntry) {
                final problem = problemEntry.value;
                final key = '${problem.contestId}_${problem.index}';

                return Padding(
                  padding: EdgeInsets.only(
                    bottom: 10.h,
                  ),
                  child: GlassCard(
                    borderColor: problem.verdictColor.withValues(alpha: 0.40),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${problem.index}. ${problem.name}',
                                style: AppTextStyles.bodyBold,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 6.h),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.w,
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: problem.verdictColor
                                          .withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    child: Text(
                                      problem.verdictShort,
                                      style: AppTextStyles.caption.copyWith(
                                        color: problem.verdictColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    '${problem.rating}',
                                    style: AppTextStyles.metricSmall.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.h),
                              Wrap(
                                spacing: 4.w,
                                runSpacing: 4.h,
                                children: problem.tags
                                    .take(2)
                                    .map(
                                      (tag) => Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6.w,
                                          vertical: 2.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white
                                              .withValues(alpha: 0.06),
                                          borderRadius:
                                              BorderRadius.circular(6.r),
                                        ),
                                        child: Text(
                                          tag,
                                          style: AppTextStyles.caption.copyWith(
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () => _launchUrl(problem.url),
                              child: Container(
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.primary.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    color: AppColors.primary
                                        .withValues(alpha: 0.40),
                                  ),
                                ),
                                child: Icon(
                                  Icons.open_in_new_rounded,
                                  color: AppColors.primary,
                                  size: 16.r,
                                ),
                              ),
                            ),
                            SizedBox(height: 6.h),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _solvedProblems.add(key);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${problem.index} marked as solved!',
                                    ),
                                    backgroundColor: AppColors.success,
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.success.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    color: AppColors.success
                                        .withValues(alpha: 0.40),
                                  ),
                                ),
                                child: Icon(
                                  Icons.check_rounded,
                                  color: AppColors.success,
                                  size: 16.r,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
              SizedBox(height: 8.h),
            ],
          );
        }),
        SizedBox(height: 100.h),
      ],
    );
  }

  Widget _buildSolvedTab(
    List<UpsolveItem> solvedProblems,
    BuildContext context,
  ) {
    if (solvedProblems.isEmpty) {
      return const AppEmptyWidget(
        title: 'No Solved Problems Yet',
        subtitle: 'Mark problems as solved from Pending tab',
        icon: Icons.check_circle_outline_rounded,
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      itemCount: solvedProblems.length,
      itemBuilder: (context, index) {
        final problem = solvedProblems[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: GlassCard(
            borderColor: AppColors.success.withValues(alpha: 0.40),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: 20.r,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${problem.index}. ${problem.name}',
                        style: AppTextStyles.bodyBold,
                      ),
                      Text(
                        'Contest ${problem.contestId} • ${problem.rating}',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => _launchUrl(problem.url),
                  child: Icon(
                    Icons.open_in_new_rounded,
                    color: AppColors.primary,
                    size: 16.r,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
