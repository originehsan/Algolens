import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/error_widget.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/features/friends/providers/friends_provider.dart';

class ComparisonScreen extends ConsumerWidget {
  const ComparisonScreen({
    super.key,
    required this.handle1,
    required this.handle2,
  });

  final String handle1;
  final String handle2;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final compareAsync = ref.watch(
      compareRatingProvider(
        (handle1, handle2),
      ),
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
                'Comparison',
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
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    compareAsync.when(
                      loading: () => GlassCardShimmer(
                        height: 300.h,
                      ),
                      error: (e, s) => AppErrorWidget(
                        message: e is ApiException
                            ? e.message
                            : 'Something went wrong. Please try again.',
                        onRetry: () => ref.invalidate(
                          compareRatingProvider(
                            (
                              handle1,
                              handle2,
                            ),
                          ),
                        ),
                      ),
                      data: (data) => _ComparisonContent(
                        data: data,
                        handle1: handle1,
                        handle2: handle2,
                      ),
                    ),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────
// COMPARISON CONTENT
// Side by side stats
// ─────────────────────────────────

class _ComparisonContent extends StatelessWidget {
  const _ComparisonContent({
    required this.data,
    required this.handle1,
    required this.handle2,
  });

  final Map<String, dynamic> data;
  final String handle1;
  final String handle2;

  @override
  Widget build(BuildContext context) {
    final r1 = data['rating1'] as int? ?? 0;
    final r2 = data['rating2'] as int? ?? 0;
    final mr1 = data['maxRating1'] as int? ?? 0;
    final mr2 = data['maxRating2'] as int? ?? 0;
    final c1 = data['contestsParticipated1'] as int? ?? 0;
    final c2 = data['contestsParticipated2'] as int? ?? 0;
    final p1 = data['problemsSolved1'] as int? ?? 0;
    final p2 = data['problemsSolved2'] as int? ?? 0;

    return Column(
      children: [
        // Handle headers
        GlassCard(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  handle1,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                'vs',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(
                    alpha: 0.50,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  handle2,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.warning,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        // Rating comparison
        _StatRow(
          label: 'Rating',
          val1: r1,
          val2: r2,
        ),
        SizedBox(height: 10.h),
        // Max rating
        _StatRow(
          label: 'Max Rating',
          val1: mr1,
          val2: mr2,
        ),
        SizedBox(height: 10.h),
        // Contests
        _StatRow(
          label: 'Contests',
          val1: c1,
          val2: c2,
        ),
        SizedBox(height: 10.h),
        // Problems solved
        _StatRow(
          label: 'Problems',
          val1: p1,
          val2: p2,
        ),
      ],
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({
    required this.label,
    required this.val1,
    required this.val2,
  });

  final String label;
  final int val1;
  final int val2;

  @override
  Widget build(BuildContext context) {
    final v1Wins = val1 >= val2;
    final v2Wins = val2 >= val1;

    return GlassCard(
      child: Row(
        children: [
          // Value 1
          Expanded(
            child: Text(
              '$val1',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: v1Wins
                    ? AppColors.primary
                    : Colors.white.withValues(
                        alpha: 0.50,
                      ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Label
          SizedBox(
            width: 80.w,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(
                  alpha: 0.55,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Value 2
          Expanded(
            child: Text(
              '$val2',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: v2Wins
                    ? AppColors.warning
                    : Colors.white.withValues(
                        alpha: 0.50,
                      ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
