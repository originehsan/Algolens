import 'package:algolens/features/contests/providers/contest_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:algolens/core/constants/app_strings.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/utils/contest_utils.dart';
import 'package:algolens/core/utils/duration_utils.dart';
import 'package:algolens/core/widgets/bell_button.dart';
import 'package:algolens/core/widgets/pulsing_dot.dart';
import 'package:algolens/core/widgets/stacked_card_carousel.dart';
import 'package:algolens/core/widgets/urgency_bar.dart';
import 'package:algolens/core/widgets/urgency_countdown.dart';
import 'package:algolens/features/contests/data/models/contest_model.dart';
import 'package:algolens/features/contests/screens/widgets/reminder_sheet.dart';
import 'package:algolens/features/profile/providers/profile_provider.dart';

/// JioHotstar-style contest carousel for home screen Section 4.
/// Full-bleed, no horizontal padding from the parent.
class ContestCarousel extends StatelessWidget {
  const ContestCarousel({
    super.key,
    required this.contests,
    required this.handle,
  });

  final List<ContestModel> contests;
  final String handle;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: StackedCardCarousel(
        cardHeight: 260.h,
        horizontalPadding: 20.w,
        peekWidth: 28,
        behindScale1: 0.96,
        behindScale2: 0.92,
        behindOpacity1: 0.75,
        behindOpacity2: 0.45,
        behindPeekY1: 8,
        behindPeekY2: 15,
        borderRadius: 20,
        surfaceColor: const Color(0xFF0F2040),
        autoPlayDuration: const Duration(seconds: 6),
        loop: true,
        showDots: true,
        settleInOnPageChange: true,
        items: contests
            .map((c) => _ContestCard(contest: c, handle: handle))
            .toList(),
      ),
    );
  }
}

// ── Single carousel card ───────────────────────────

class _ContestCard extends ConsumerWidget {
  const _ContestCard({required this.contest, required this.handle});

  final ContestModel contest;
  final String handle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasReminder = ref.watch(
      contestHasReminderProvider(contest.contestId),
    );

    final profileAsync = ref.watch(profileProvider(handle));
    final accent = ContestUtils.accentColor(contest.name);
    final isLive = contest.isLive;
    final isUpcoming = contest.isUpcoming;

    final division = _divisionSubtitle(contest.name);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F2040),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.fromLTRB(18.r, 18.r, 18.r, 18.r),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: status badge (Live/Today/Upcoming) + bell
            Row(
              children: [
                _StatusBadge(
                  label: _statusLabel(contest),
                  color: _statusColor(contest),
                  isLive: isLive,
                ),
                const Spacer(),
                BellButton(
                  hasReminder: hasReminder,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (_) => ReminderSheet(contest: contest),
                    );
                  },
                ),
              ],
            ),

            Gap(14.h),

            // CF logo + title block (division shown once, as subtitle)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/cf_logo.png',
                  width: 38.r,
                  height: 38.r,
                  fit: BoxFit.contain,
                ),
                Gap(14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _titleWithoutDivision(contest.name),
                        style: AppTextStyles.h4.copyWith(
                          color: AppColors.textPrimary,
                          height: 1.25,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (division != null) ...[
                        Gap(2.h),
                        Text(
                          division,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            Gap(14.h),

            // Fit badge — green / amber / red, only on pure-division rounds
            profileAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
              data: (profile) {
                final fitLabel = ContestUtils.ratingFitLabel(
                  contest.name,
                  profile.rating,
                );
                if (fitLabel == null) return const SizedBox.shrink();

                final Color fitColor;
                if (ContestUtils.isTooToughFit(fitLabel)) {
                  fitColor = AppColors.danger;
                } else if (ContestUtils.isStretchFit(fitLabel)) {
                  fitColor = AppColors.warning;
                } else if (ContestUtils.isOpenToAll(fitLabel)) {
                  fitColor = AppColors.textMuted;
                } else {
                  fitColor = AppColors.success;
                }

                return Padding(
                  padding: EdgeInsets.only(bottom: 14.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: fitColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(13.r),
                      border: Border.all(
                        color: fitColor.withValues(alpha: 0.30),
                        width: 1.0,
                      ),
                    ),
                    child: Text(
                      fitLabel,
                      style: AppTextStyles.captionBold.copyWith(
                        color: fitColor,
                      ),
                    ),
                  ),
                );
              },
            ),

            Divider(
              height: 1,
              thickness: 1,
              color: Colors.white.withValues(alpha: 0.09),
            ),

            Gap(12.h),

            // Meta row: duration left, countdown/ends-in right
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  DurationUtils.formatSeconds(contest.durationSeconds),
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
                const Spacer(),
                if (isLive)
                  _LiveEndsIn(
                    startTime: contest.startDateTime,
                    durationSeconds: contest.durationSeconds,
                  )
                else
                  UrgencyCountdown(targetTime: contest.startDateTime),
              ],
            ),

            if (isUpcoming) ...[
              Gap(8.h),
              UrgencyBar(
                targetTime: contest.startDateTime,
                accentColor: accent,
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Status badge label: LIVE / TODAY / UPCOMING
  String _statusLabel(ContestModel c) {
    if (c.isLive) return AppStrings.live;
    final hoursLeft = c.startDateTime.difference(DateTime.now()).inHours;
    if (hoursLeft < 24) return 'TODAY';
    return 'UPCOMING';
  }

  /// Status badge color matching the urgency system
  Color _statusColor(ContestModel c) {
    if (c.isLive) return AppColors.danger;
    final hoursLeft = c.startDateTime.difference(DateTime.now()).inHours;
    if (hoursLeft < 24) return AppColors.warning;
    return AppColors.primary;
  }

  /// Returns the title with any "(Div. X...)" suffix stripped.
  /// "Codeforces Round 1000 (Div. 1 + Div. 2)" → "Codeforces Round 1000"
  String _titleWithoutDivision(String name) {
    final idx = name.indexOf('(Div');
    if (idx == -1) return name;
    return name.substring(0, idx).trim();
  }

  /// Extracts just the division text from parentheses.
  /// "Codeforces Round 1000 (Div. 1 + Div. 2)" → "Div. 1 + Div. 2"
  String? _divisionSubtitle(String name) {
    final start = name.indexOf('(Div');
    if (start == -1) return null;
    final end = name.indexOf(')', start);
    if (end == -1) return null;
    return name.substring(start + 1, end).trim();
  }
}

// ── Status badge ─────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.label,
    required this.color,
    required this.isLive,
  });

  final String label;
  final Color color;
  final bool isLive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: color.withValues(alpha: 0.40),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLive) ...[
            PulsingDot(color: color),
            Gap(5.w),
          ],
          Text(
            label,
            style: AppTextStyles.label.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Live contest: shows time remaining until it ends ────

class _LiveEndsIn extends StatefulWidget {
  const _LiveEndsIn({
    required this.startTime,
    required this.durationSeconds,
  });

  final DateTime startTime;
  final int durationSeconds;

  @override
  State<_LiveEndsIn> createState() => _LiveEndsInState();
}

class _LiveEndsInState extends State<_LiveEndsIn> {
  late final DateTime _endTime = widget.startTime.add(
    Duration(seconds: widget.durationSeconds),
  );

  @override
  Widget build(BuildContext context) {
    final remaining = _endTime.difference(DateTime.now());
    if (remaining.isNegative) {
      return Text(
        'Ending soon',
        style: AppTextStyles.label.copyWith(
          color: AppColors.danger,
          letterSpacing: 0.5,
        ),
      );
    }
    final h = remaining.inHours;
    final m = remaining.inMinutes.remainder(60);
    final label = h > 0 ? 'Ends in ${h}h ${m}m' : 'Ends in ${m}m';
    return Text(
      label,
      style: AppTextStyles.label.copyWith(
        color: AppColors.danger,
        letterSpacing: 0.3,
      ),
    );
  }
}
