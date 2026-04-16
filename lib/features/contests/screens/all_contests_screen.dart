import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/page_wrapper.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/loading_shimmer.dart';
import 'package:algolens/core/widgets/error_widget.dart';
import 'package:algolens/features/contests/providers/contest_provider.dart';
import 'package:algolens/features/contests/data/models/contest_model.dart';

class AllContestsScreen extends ConsumerStatefulWidget {
  const AllContestsScreen({super.key});

  @override
  ConsumerState<AllContestsScreen> createState() => _AllContestsScreenState();
}

class _AllContestsScreenState extends ConsumerState<AllContestsScreen> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final allContestsAsync = ref.watch(allContestsProvider(_currentPage));

    return PageWrapper(
      title: 'All Contests',
      showBackButton: true,
      child: Column(
        children: [
          Expanded(
            child: allContestsAsync.when(
              loading: () => ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                itemCount: 6,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                    bottom: 12.h,
                  ),
                  child: ShimmerCard(
                    height: 80.h,
                  ),
                ),
              ),
              error: (e, _) => AppErrorWidget(
                message: e.toString(),
                onRetry: () => ref.invalidate(
                  allContestsProvider(_currentPage),
                ),
              ),
              data: (data) {
                final contests = (data['content'] as List)
                    .map((c) => Contest.fromJson(c as Map<String, dynamic>))
                    .toList();
                final pageData = data['page'] as Map<String, dynamic>;
                final totalPages = pageData['totalPages'] as int;

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                        ),
                        itemCount: contests.length,
                        itemBuilder: (context, index) {
                          final contest = contests[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: 10.h,
                            ),
                            child: GlassCard(
                              padding: EdgeInsets.all(12.r),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40.r,
                                    height: 40.r,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary
                                          .withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        contest.type,
                                        style: AppTextStyles.caption.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 9.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          contest.name,
                                          style: AppTextStyles.bodyBold,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        Text(
                                          contest.formattedStartTime,
                                          style: AppTextStyles.caption,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    contest.formattedDuration,
                                    style: AppTextStyles.monoSmall,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Pagination
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 12.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: _currentPage > 0
                                ? () => setState(() => _currentPage--)
                                : null,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: _currentPage > 0
                                    ? AppColors.primary.withValues(alpha: 0.15)
                                    : Colors.white.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: _currentPage > 0
                                      ? AppColors.primary
                                          .withValues(alpha: 0.40)
                                      : Colors.white.withValues(alpha: 0.10),
                                ),
                              ),
                              child: Text(
                                'Previous',
                                style: AppTextStyles.caption.copyWith(
                                  color: _currentPage > 0
                                      ? AppColors.primary
                                      : AppColors.textHint,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Page ${_currentPage + 1} of $totalPages',
                            style: AppTextStyles.caption,
                          ),
                          GestureDetector(
                            onTap: _currentPage < totalPages - 1
                                ? () => setState(() => _currentPage++)
                                : null,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: _currentPage < totalPages - 1
                                    ? AppColors.primary.withValues(alpha: 0.15)
                                    : Colors.white.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: _currentPage < totalPages - 1
                                      ? AppColors.primary
                                          .withValues(alpha: 0.40)
                                      : Colors.white.withValues(alpha: 0.10),
                                ),
                              ),
                              child: Text(
                                'Next',
                                style: AppTextStyles.caption.copyWith(
                                  color: _currentPage < totalPages - 1
                                      ? AppColors.primary
                                      : AppColors.textHint,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
