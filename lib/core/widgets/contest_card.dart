import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/countdown_timer.dart';

// ──────────────────────────────
// CONTEST STATUS
// ──────────────────────────────

/// Contest status enum
enum ContestStatus {
  upcoming,
  live,
  finished,
}

// ──────────────────────────────
// CONTEST CARD
// Full contest display card
// ──────────────────────────────

/// Contest card widget
///
/// Features:
/// → Live/Upcoming status badge
/// → Difficulty chip
/// → Countdown timer
/// → Bell reminder button
/// → Tap → open CF link
/// → Duration display
///
/// Usage:
/// ContestCard(
///   contestId: 1991,
///   name: 'CF Round 992 (Div. 2)',
///   status: ContestStatus.upcoming,
///   difficulty: 'Moderate',
///   startDateTime: DateTime(...),
///   durationFormatted: '2h 0m',
///   hasReminder: false,
///   onReminderTap: () => ...,
/// )
class ContestCard extends StatelessWidget {
  const ContestCard({
    super.key,
    required this.contestId,
    required this.name,
    required this.status,
    required this.difficulty,
    required this.startDateTime,
    required this.durationFormatted,
    required this.hasReminder,
    required this.onReminderTap,
    this.margin,
  });

  final int contestId;
  final String name;
  final ContestStatus status;
  final String difficulty;
  final DateTime startDateTime;
  final String durationFormatted;
  final bool hasReminder;
  final VoidCallback onReminderTap;
  final EdgeInsetsGeometry? margin;

  // ────────────────────────────
  // CF CONTEST URL
  // ────────────────────────────

  String get _contestUrl => 'https://codeforces.com'
      '/contest/$contestId';

  // ────────────────────────────
  // STATUS BADGE COLOR
  // ────────────────────────────

  Color get _statusColor => switch (status) {
        ContestStatus.live => AppColors.danger,
        ContestStatus.upcoming => AppColors.primary,
        ContestStatus.finished => Colors.white.withValues(
            alpha: 0.50,
          ),
      };

  // ────────────────────────────
  // STATUS LABEL
  // ────────────────────────────

  String get _statusLabel => switch (status) {
        ContestStatus.live => 'LIVE',
        ContestStatus.upcoming => 'UPCOMING',
        ContestStatus.finished => 'FINISHED',
      };

  // ────────────────────────────
  // DIFFICULTY COLOR
  // ────────────────────────────

  Color get _difficultyColor => switch (difficulty.toLowerCase()) {
        'easy' => AppColors.success,
        'moderate' => AppColors.warning,
        'hard' => AppColors.danger,
        _ => AppColors.primary,
      };

  // ────────────────────────────
  // OPEN CF LINK
  // ────────────────────────────

  Future<void> _openLink() async {
    final uri = Uri.parse(_contestUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: margin,
      onTap: _openLink,
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ──────────────────
          // TOP ROW
          // Status + Bell
          // ──────────────────

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // STATUS BADGE
              _StatusBadge(
                label: _statusLabel,
                color: _statusColor,
                isLive: status == ContestStatus.live,
              ),

              // BELL ICON
              GestureDetector(
                onTap: onReminderTap,
                child: Container(
                  width: 32.r,
                  height: 32.r,
                  decoration: BoxDecoration(
                    color: hasReminder
                        ? AppColors.primary.withValues(
                            alpha: 0.20,
                          )
                        : Colors.white.withValues(
                            alpha: 0.06,
                          ),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: hasReminder
                          ? AppColors.primary.withValues(
                              alpha: 0.40,
                            )
                          : Colors.white.withValues(
                              alpha: 0.10,
                            ),
                      width: 1.0,
                    ),
                  ),
                  child: Icon(
                    hasReminder
                        ? Icons.notifications_active_rounded
                        : Icons.notifications_none_rounded,
                    color: hasReminder
                        ? AppColors.primary
                        : Colors.white.withValues(
                            alpha: 0.50,
                          ),
                    size: 16.r,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          // ──────────────────
          // CONTEST NAME
          // ──────────────────

          Text(
            name,
            style: AppTextStyles.h4.copyWith(
              color: Colors.white.withValues(
                alpha: 0.90,
              ),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: 10.h),

          // ──────────────────
          // BOTTOM ROW
          // Difficulty + Timer
          // + Duration
          // ──────────────────

          Row(
            children: [
              // DIFFICULTY CHIP
              _DifficultyChip(
                label: difficulty,
                color: _difficultyColor,
              ),

              SizedBox(width: 8.w),

              // DURATION
              Icon(
                Icons.access_time_rounded,
                color: Colors.white.withValues(
                  alpha: 0.50,
                ),
                size: 12.r,
              ),
              SizedBox(width: 4.w),
              Text(
                durationFormatted,
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white.withValues(
                    alpha: 0.50,
                  ),
                ),
              ),

              const Spacer(),

              // COUNTDOWN TIMER
              if (status != ContestStatus.finished)
                CountdownTimer(
                  targetTime: startDateTime,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────
// STATUS BADGE
// Live / Upcoming chip
// ──────────────────────────────

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
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 3.h,
      ),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 0.15,
        ),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: color.withValues(
            alpha: 0.35,
          ),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLive) ...[
            Container(
              width: 6.r,
              height: 6.r,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 4.w),
          ],
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────
// DIFFICULTY CHIP
// Easy / Moderate / Hard
// ──────────────────────────────

class _DifficultyChip extends StatelessWidget {
  const _DifficultyChip({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 3.h,
      ),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 0.12,
        ),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: color.withValues(
            alpha: 0.30,
          ),
          width: 1.0,
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 10.sp,
        ),
      ),
    );
  }
}
