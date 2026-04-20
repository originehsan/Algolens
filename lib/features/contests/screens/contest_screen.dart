import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/page_wrapper.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/contest_card.dart';
import 'package:algolens/core/widgets/segmented_tab.dart';
import 'package:algolens/core/widgets/loading_shimmer.dart';
import 'package:algolens/core/widgets/error_widget.dart';
import 'package:algolens/core/widgets/empty_widget.dart';
import 'package:algolens/features/contests/providers/contest_provider.dart';

class ContestScreen extends ConsumerStatefulWidget {
  const ContestScreen({super.key});

  @override
  ConsumerState<ContestScreen> createState() => _ContestScreenState();
}

class _ContestScreenState extends ConsumerState<ContestScreen> {
  int _selectedTab = 0;
  final Set<int> _reminderSet = {};

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: 'Contests',
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 12.h,
            ),
            child: SegmentedTab(
              tabs: const [
                'Upcoming',
                'All',
                'Live',
              ],
              currentIndex: _selectedTab,
              onChanged: (index) {
                setState(
                  () => _selectedTab = index,
                );
              },
            ),
          ),
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 0:
        return _buildUpcomingTab();
      case 1:
        return _buildAllTab();
      case 2:
        return _buildLiveTab();
      default:
        return _buildUpcomingTab();
    }
  }

  Widget _buildUpcomingTab() {
    final contestsAsync = ref.watch(upcomingContestsProvider);

    return contestsAsync.when(
      loading: () => ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        itemCount: 4,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: ShimmerCard(height: 160.h),
        ),
      ),
      error: (error, _) => AppErrorWidget(
        message: error.toString(),
        onRetry: () => ref.invalidate(upcomingContestsProvider),
      ),
      data: (contests) {
        if (contests.isEmpty) {
          return const AppEmptyWidget(
            title: 'No Upcoming Contests',
            subtitle: 'Check back later for new contests',
            icon: Icons.event_busy_outlined,
          );
        }
        return ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          itemCount: contests.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: ContestCard(
                  contest: contests[index],
                  isReminderSet: _reminderSet.contains(index),
                  onReminderToggle: () {
                    setState(() {
                      if (_reminderSet.contains(index)) {
                        _reminderSet.remove(index);
                      } else {
                        _reminderSet.add(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Reminder set for ${contests[index].name}',
                            ),
                            backgroundColor: AppColors.success,
                          ),
                        );
                      }
                    });
                  },
                ));
          },
        );
      },
    );
  }

  Widget _buildAllTab() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: GlassCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.history_rounded,
                color: AppColors.primary,
                size: 40.r,
              ),
              SizedBox(height: 12.h),
              Text(
                'All Contests',
                style: AppTextStyles.h3,
              ),
              SizedBox(height: 8.h),
              Text(
                'Browse complete contest history',
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () => context.push('/contests/all'),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.40),
                    ),
                  ),
                  child: Text(
                    'View All Contests',
                    style: AppTextStyles.bodyBold.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLiveTab() {
    final contestsAsync = ref.watch(upcomingContestsProvider);

    return contestsAsync.when(
      loading: () => const ShimmerList(count: 3),
      error: (e, _) => AppErrorWidget(
        message: e.toString(),
        onRetry: () => ref.invalidate(upcomingContestsProvider),
      ),
      data: (contests) {
        final liveContests = contests.where((c) => c.isLive).toList();

        if (liveContests.isEmpty) {
          return const AppEmptyWidget(
            title: 'No Live Contests',
            subtitle: 'No contests are live right now',
            icon: Icons.live_tv_outlined,
          );
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          itemCount: liveContests.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: ContestCard(
                contest: liveContests[index],
                isReminderSet: false,
                onReminderToggle: () {},
              ),
            );
          },
        );
      },
    );
  }
}
