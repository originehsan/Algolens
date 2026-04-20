import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/providers/ui_providers.dart';
import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/user_avatar.dart';

// ──────────────────────────────
// MAIN SCAFFOLD
// Shell for all main app tabs
// ──────────────────────────────

/// Main app shell with bottom nav
///
/// Tabs:
/// 0 → Home     (house icon)
/// 1 → Contests (trophy icon)
/// 2 → Practice (code icon)
/// 3 → Friends  (people icon)
///
/// Profile access:
/// → Avatar tap top right
/// → Routes to /profile
///
/// Usage:
/// Wrap tab screens with this
/// via ShellRoute in GoRouter
class MainScaffold extends ConsumerWidget {
  const MainScaffold({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final currentIndex = ref.watch(
      bottomNavIndexProvider,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: AppBackground(
        child: child,
      ),

      // ────────────────────────
      // BOTTOM NAV BAR
      // salomon_bottom_bar
      // ────────────────────────

      bottomNavigationBar: _BottomNav(
        currentIndex: currentIndex,
        onTap: (index) {
          ref
              .read(
                bottomNavIndexProvider.notifier,
              )
              .state = index;
          _navigateToTab(
            context,
            index,
          );
        },
      ),
    );
  }

  // ────────────────────────────
  // TAB NAVIGATION
  // Index → route path
  // ────────────────────────────

  void _navigateToTab(
    BuildContext context,
    int index,
  ) {
    final paths = [
      RoutePaths.home,
      RoutePaths.contests,
      RoutePaths.practice,
      RoutePaths.friends,
    ];
    context.go(paths[index]);
  }
}

// ──────────────────────────────
// BOTTOM NAV WIDGET
// salomon_bottom_bar styling
// ──────────────────────────────

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
        unselectedItemColor: Colors.white.withValues(
          alpha: 0.50,
        ),
        items: [
          // ──────────────────
          // HOME TAB
          // ──────────────────

          SalomonBottomBarItem(
            icon: const Icon(
              Icons.home_rounded,
            ),
            title: Text(
              'Home',
              style: AppTextStyles.caption.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            selectedColor: AppColors.primary,
          ),

          // ──────────────────
          // CONTESTS TAB
          // ──────────────────

          SalomonBottomBarItem(
            icon: const Icon(
              Icons.emoji_events_rounded,
            ),
            title: Text(
              'Contests',
              style: AppTextStyles.caption.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            selectedColor: AppColors.primary,
          ),

          // ──────────────────
          // PRACTICE TAB
          // ──────────────────

          SalomonBottomBarItem(
            icon: const Icon(
              Icons.code_rounded,
            ),
            title: Text(
              'Practice',
              style: AppTextStyles.caption.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            selectedColor: AppColors.primary,
          ),

          // ──────────────────
          // FRIENDS TAB
          // ──────────────────

          SalomonBottomBarItem(
            icon: const Icon(
              Icons.people_rounded,
            ),
            title: Text(
              'Friends',
              style: AppTextStyles.caption.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            selectedColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
