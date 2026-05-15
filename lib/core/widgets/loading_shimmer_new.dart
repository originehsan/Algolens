import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/widgets/glass_card.dart';

// ──────────────────────────────────────────
// LOADING SHIMMER
// Placeholder loading UI patterns
// ──────────────────────────────────────────

// ──────────────────────────────────────────
// CONTEST LIST SHIMMER
// ──────────────────────────────────────────

/// Contest list placeholder (3 items)
class ContestListShimmer extends StatelessWidget {
  const ContestListShimmer({
    super.key,
    this.count = 3,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        count,
        (index) => Padding(
          padding: EdgeInsets.only(
            bottom: index < count - 1 ? 12.h : 0,
          ),
          child: const GlassCardShimmer(
            height: 110,
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────
// PROBLEM LIST SHIMMER
// ──────────────────────────────────────────

/// Problem list placeholder (5 items)
class ProblemListShimmer extends StatelessWidget {
  const ProblemListShimmer({
    super.key,
    this.count = 5,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        count,
        (index) => Padding(
          padding: EdgeInsets.only(
            bottom: index < count - 1 ? 12.h : 0,
          ),
          child: const GlassCardShimmer(
            height: 80,
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────
// STATS ROW SHIMMER
// ──────────────────────────────────────────

/// Stats row placeholder (3 cards)
class StatsRowShimmer extends StatelessWidget {
  const StatsRowShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        3,
        (index) => Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: index < 2 ? 12.w : 0,
            ),
            child: const GlassCardShimmer(
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────
// PROFILE SHIMMER
// ──────────────────────────────────────────

/// Profile page placeholder
///
/// Hero section + chart + stats grid
class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Hero section
        const GlassCardShimmer(
          height: 160,
        ),

        SizedBox(height: 20.h),

        // Chart
        const GlassCardShimmer(
          height: 200,
        ),

        SizedBox(height: 20.h),

        // Stats grid
        Row(
          children: [
            const Expanded(
              child: GlassCardShimmer(
                height: 80,
              ),
            ),
            SizedBox(width: 12.w),
            const Expanded(
              child: GlassCardShimmer(
                height: 80,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────
// FRIENDS LIST SHIMMER
// ──────────────────────────────────────────

/// Friends list placeholder (4 items)
class FriendsListShimmer extends StatelessWidget {
  const FriendsListShimmer({
    super.key,
    this.count = 4,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        count,
        (index) => Padding(
          padding: EdgeInsets.only(
            bottom: index < count - 1 ? 12.h : 0,
          ),
          child: const GlassCardShimmer(
            height: 72,
          ),
        ),
      ),
    );
  }
}
