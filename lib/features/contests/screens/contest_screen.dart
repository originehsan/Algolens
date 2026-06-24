import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/contest_card.dart';
import 'package:algolens/core/widgets/error_widget.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/loading_shimmer.dart';
import 'package:algolens/core/widgets/offline_banner.dart';
import 'package:algolens/core/widgets/segmented_tab.dart';
import 'package:algolens/features/contests/data/models/contest_model.dart';
import 'package:algolens/features/contests/providers/contest_provider.dart';

class ContestScreen extends ConsumerStatefulWidget {
  const ContestScreen({super.key});

  @override
  ConsumerState<ContestScreen> createState() => _ContestScreenState();
}

class _ContestScreenState extends ConsumerState<ContestScreen> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final contestsAsync = ref.watch(upcomingContestsProvider);

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    floating: true,
                    title: Text(
                      'Contests',
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    actions: [
                      TextButton(
                        // push — allContests is outside ShellRoute
                        onPressed: () => context.pushNamed(
                          RouteNames.allContests,
                        ),
                        child: Text(
                          'All',
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
                        SegmentedTab(
                          tabs: const ['Upcoming', 'Live', 'All'],
                          currentIndex: _tabIndex,
                          onChanged: (i) => setState(() => _tabIndex = i),
                        ),
                        SizedBox(height: 16.h),
                        contestsAsync.when(
                          loading: () => const ContestListShimmer(),
                          error: (e, s) => AppErrorWidget(
                            message: e is ApiException
                                ? e.message
                                : 'Failed to load contests. Please try again.',
                            onRetry: () =>
                                ref.invalidate(upcomingContestsProvider),
                          ),
                          data: (all) {
                            final filtered = _filter(all);
                            if (filtered.isEmpty) {
                              return _EmptyContests(tabIndex: _tabIndex);
                            }
                            return Column(
                              children: filtered
                                  .map((c) => _ContestCardWithReminder(
                                        contest: c,
                                      ))
                                  .toList(),
                            );
                          },
                        ),
                        SizedBox(height: 100.h),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<ContestModel> _filter(List<ContestModel> all) {
    return switch (_tabIndex) {
      0 => all.where((c) => c.isUpcoming).toList(),
      1 => all.where((c) => c.isLive).toList(),
      _ => all,
    };
  }
}

class _ContestCardWithReminder extends ConsumerWidget {
  const _ContestCardWithReminder({required this.contest});
  final ContestModel contest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reminders = ref.watch(
      contestReminderProvider(contest.contestId),
    );

    final status = contest.isLive
        ? ContestStatus.live
        : contest.isUpcoming
            ? ContestStatus.upcoming
            : ContestStatus.finished;

    return ContestCard(
      contestId: contest.contestId,
      name: contest.name,
      status: status,
      difficulty: contest.difficulty,
      startDateTime: contest.startDateTime,
      durationFormatted: contest.durationFormatted,
      hasReminder: reminders.isNotEmpty,
      margin: EdgeInsets.only(bottom: 12.h),
      onReminderTap: () => _showReminderSheet(context, contest),
    );
  }

  void _showReminderSheet(BuildContext context, ContestModel contest) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _ReminderBottomSheet(contest: contest),
    );
  }
}

class _ReminderBottomSheet extends ConsumerStatefulWidget {
  const _ReminderBottomSheet({required this.contest});
  final ContestModel contest;

  @override
  ConsumerState<_ReminderBottomSheet> createState() =>
      _ReminderBottomSheetState();
}

class _ReminderBottomSheetState extends ConsumerState<_ReminderBottomSheet> {
  double _sliderValue = 30;

  @override
  Widget build(BuildContext context) {
    // Watch live — updates when reminders added/removed
    final currentReminders = ref.watch(
      contestReminderProvider(widget.contest.contestId),
    );

    return GlassCard(
      margin: EdgeInsets.all(16.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Set Reminder',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            widget.contest.name,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.55),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 20.h),
          Text(
            '${_sliderValue.toInt()} minutes before',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          Slider(
            value: _sliderValue,
            min: 0,
            max: 120,
            divisions: 24,
            activeColor: AppColors.primary,
            inactiveColor: AppColors.primary.withValues(alpha: 0.20),
            onChanged: (v) => setState(() => _sliderValue = v),
          ),
          Row(
            children: [30, 60, 120]
                .map((mins) => Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: GestureDetector(
                        onTap: () =>
                            setState(() => _sliderValue = mins.toDouble()),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: _sliderValue == mins
                                ? AppColors.primary.withValues(alpha: 0.20)
                                : Colors.white.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: _sliderValue == mins
                                  ? AppColors.primary.withValues(alpha: 0.40)
                                  : Colors.white.withValues(alpha: 0.10),
                            ),
                          ),
                          child: Text(
                            '${mins}m',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: _sliderValue == mins
                                  ? AppColors.primary
                                  : Colors.white.withValues(alpha: 0.60),
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          SizedBox(height: 20.h),
          AppButton(
            label: 'Add Reminder',
            onTap: () async {
              final messenger = ScaffoldMessenger.of(context);
              final navigator = Navigator.of(context);

              final added = await ref.read(addReminderProvider.notifier).add(
                    contestId: widget.contest.contestId,
                    contestName: widget.contest.name,
                    minutesBefore: _sliderValue.toInt(),
                    startDateTime: widget.contest.startDateTime,
                  );

              if (!mounted) return;
              if (!added) {
                messenger.showSnackBar(
                  SnackBar(
                    content: Text(
                      'Max 3 reminders per contest',
                      style: GoogleFonts.inter(color: Colors.white),
                    ),
                    backgroundColor: AppColors.danger,
                  ),
                );
              }
              navigator.pop();
            },
          ),
          if (currentReminders.isNotEmpty) ...[
            SizedBox(height: 16.h),
            Text(
              'Current reminders',
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.70),
              ),
            ),
            SizedBox(height: 8.h),
            ...currentReminders.map(
              (mins) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  '$mins min before',
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.80),
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () => ref.read(removeReminderProvider.notifier).remove(
                        contestId: widget.contest.contestId,
                        minutesBefore: mins,
                      ),
                  child: Icon(
                    Icons.close_rounded,
                    color: AppColors.danger,
                    size: 18.r,
                  ),
                ),
              ),
            ),
          ],
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}

class _EmptyContests extends StatelessWidget {
  const _EmptyContests({required this.tabIndex});
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    final message = switch (tabIndex) {
      0 => 'No upcoming contests',
      1 => 'No live contests right now',
      _ => 'No contests found',
    };

    return GlassCard(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(32.r),
          child: Column(
            children: [
              Icon(
                Icons.emoji_events_outlined,
                color: AppColors.primary.withValues(alpha: 0.50),
                size: 40.r,
              ),
              SizedBox(height: 12.h),
              Text(
                message,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withValues(alpha: 0.55),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
