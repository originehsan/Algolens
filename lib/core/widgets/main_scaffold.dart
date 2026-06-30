import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/widgets/offline_banner.dart';

class MainScaffold extends ConsumerWidget {
  const MainScaffold({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Sync tab index from actual route — not from provider
    // This handles deep links, back button, and direct navigation
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex = switch (location) {
      var l when l.startsWith(RoutePaths.contests) => 1,
      var l when l.startsWith(RoutePaths.practice) => 2,
      var l when l.startsWith(RoutePaths.friends) => 3,
      _ => 0,
    };

    return Material(
      color: Colors.transparent,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        // No AppBackground here — each screen has its own
        // OfflineBanner lives here (not per-screen) so it's
        // automatically present and SafeArea-correct on every tab.
        body: Column(
          children: [
            const SafeArea(bottom: false, child: OfflineBanner()),
            Expanded(child: child),
          ],
        ),
        bottomNavigationBar: _BottomNav(
          currentIndex: currentIndex,
          onTap: (index) => _navigateToTab(context, index),
        ),
      ),
    );
  }

  void _navigateToTab(BuildContext context, int index) {
    final paths = [
      RoutePaths.home,
      RoutePaths.contests,
      RoutePaths.practice,
      RoutePaths.friends,
    ];
    context.go(paths[index]);
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        bottom: 20.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.20),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.10),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      ),
      child: SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: onTap,
        margin: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 10.h,
        ),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: const Color(0xFF060B14).withValues(alpha: 0.40),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home_rounded),
            title: Text(
              'Home',
              style:
                  AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
            ),
            selectedColor: AppColors.primary,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.emoji_events_rounded),
            title: Text(
              'Contests',
              style:
                  AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
            ),
            selectedColor: AppColors.primary,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.code_rounded),
            title: Text(
              'Practice',
              style:
                  AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
            ),
            selectedColor: AppColors.primary,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.people_rounded),
            title: Text(
              'Friends',
              style:
                  AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
            ),
            selectedColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
