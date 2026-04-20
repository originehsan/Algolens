import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../core/providers/ui_providers.dart';
import '../theme/app_colors.dart';

class MainScaffold extends ConsumerWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  void _handleNavigation(
    BuildContext context,
    WidgetRef ref,
    int index,
    String route,
  ) {
    ref.read(bottomNavIndexProvider.notifier).state = index;
    context.go(route);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);
    return Scaffold(
      body: child,
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: (index) {
          final routes = [
            '/home',
            '/contests',
            '/practice',
            '/friends',
          ];
          _handleNavigation(context, ref, index, routes[index]);
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            selectedColor: AppColors.primary,
            unselectedColor: AppColors.textMuted,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.event_outlined),
            title: const Text('Contests'),
            selectedColor: AppColors.primary,
            unselectedColor: AppColors.textMuted,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.lightbulb_outlined),
            title: const Text('Practice'),
            selectedColor: AppColors.primary,
            unselectedColor: AppColors.textMuted,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.people_outlined),
            title: const Text('Friends'),
            selectedColor: AppColors.primary,
            unselectedColor: AppColors.textMuted,
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
