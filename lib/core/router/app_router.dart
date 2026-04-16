import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:algolens/core/storage/secure_storage.dart';
import 'package:algolens/features/auth/screens/splash_screen.dart';
import 'package:algolens/features/auth/screens/onboarding_screen.dart';
import 'package:algolens/features/auth/screens/login_screen.dart';
import 'package:algolens/features/auth/screens/register_screen.dart';
import 'package:algolens/features/auth/screens/email_verification_screen.dart';
import 'package:algolens/features/auth/screens/forgot_password_screen.dart';
import 'package:algolens/features/auth/screens/reset_password_screen.dart';
import 'package:algolens/features/home/screens/home_screen.dart';
import 'package:algolens/features/contests/screens/contest_screen.dart';
import 'package:algolens/features/contests/screens/all_contests_screen.dart';
import 'package:algolens/features/practice/screens/weak_topics_screen.dart';
import 'package:algolens/features/practice/screens/recommendations_screen.dart';
import 'package:algolens/features/upsolve/screens/upsolve_screen.dart';
import 'package:algolens/features/profile/screens/profile_screen.dart';
import 'package:algolens/features/friends/screens/friends_screen.dart';
import 'package:algolens/features/friends/screens/comparison_screen.dart';
import 'package:algolens/features/analysis/screens/ai_analysis_screen.dart';
import 'package:algolens/features/settings/screens/settings_screen.dart';

class MainScaffold extends StatefulWidget {
  final Widget child;
  const MainScaffold({
    super.key,
    required this.child,
  });

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  static const List<String> _routes = [
    '/home',
    '/contests',
    '/practice',
    '/upsolve',
    '/profile',
  ];

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
    context.go(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.40),
          border: Border(
            top: BorderSide(
              color: Colors.white.withOpacity(0.10),
              width: 0.5,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home_rounded,
                  label: 'Home',
                ),
                _buildNavItem(
                  index: 1,
                  icon: Icons.event_note_outlined,
                  activeIcon: Icons.event_note_rounded,
                  label: 'Contests',
                ),
                _buildNavItem(
                  index: 2,
                  icon: Icons.lightbulb_outlined,
                  activeIcon: Icons.lightbulb_rounded,
                  label: 'Practice',
                ),
                _buildNavItem(
                  index: 3,
                  icon: Icons.queue_outlined,
                  activeIcon: Icons.queue_rounded,
                  label: 'Upsolve',
                ),
                _buildNavItem(
                  index: 4,
                  icon: Icons.person_outline_rounded,
                  activeIcon: Icons.person_rounded,
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF2563EB).withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isActive
              ? Border.all(
                  color: const Color(0xFF2563EB).withOpacity(0.30),
                  width: 1.0,
                )
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color:
                  isActive ? const Color(0xFF2563EB) : const Color(0xFF718096),
              size: 22,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive
                    ? const Color(0xFF2563EB)
                    : const Color(0xFF718096),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final appRouter = GoRouter(
  initialLocation: '/splash',
  redirect: (context, state) async {
    final isLoggedIn = await SecureStorage.isLoggedIn();
    final isAuthRoute = state.matchedLocation.startsWith('/login') ||
        state.matchedLocation.startsWith('/register') ||
        state.matchedLocation.startsWith('/onboarding') ||
        state.matchedLocation.startsWith('/splash') ||
        state.matchedLocation.startsWith('/verify-email') ||
        state.matchedLocation.startsWith('/forgot-password') ||
        state.matchedLocation.startsWith('/reset-password');

    if (!isLoggedIn && !isAuthRoute) {
      return '/onboarding';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/verify-email',
      builder: (context, state) {
        final email = state.uri.queryParameters['email'] ?? '';
        return EmailVerificationScreen(email: email);
      },
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/reset-password',
      builder: (context, state) => const ResetPasswordScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final curved = CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              );
              return FadeTransition(
                opacity: curved,
                child: ScaleTransition(
                  scale: Tween<double>(
                    begin: 0.95,
                    end: 1.0,
                  ).animate(curved),
                  child: child,
                ),
              );
            },
          ),
        ),
        GoRoute(
          path: '/contests',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const ContestScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final curved = CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              );
              return FadeTransition(
                opacity: curved,
                child: ScaleTransition(
                  scale: Tween<double>(
                    begin: 0.95,
                    end: 1.0,
                  ).animate(curved),
                  child: child,
                ),
              );
            },
          ),
        ),
        GoRoute(
          path: '/contests/all',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const AllContestsScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final curved = CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              );
              return FadeTransition(
                opacity: curved,
                child: ScaleTransition(
                  scale: Tween<double>(
                    begin: 0.95,
                    end: 1.0,
                  ).animate(curved),
                  child: child,
                ),
              );
            },
          ),
        ),
        GoRoute(
          path: '/practice',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const WeakTopicsScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final curved = CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              );
              return FadeTransition(
                opacity: curved,
                child: ScaleTransition(
                  scale: Tween<double>(
                    begin: 0.95,
                    end: 1.0,
                  ).animate(curved),
                  child: child,
                ),
              );
            },
          ),
        ),
        GoRoute(
          path: '/practice/recommendations',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const RecommendationsScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final curved = CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              );
              return FadeTransition(
                opacity: curved,
                child: ScaleTransition(
                  scale: Tween<double>(
                    begin: 0.95,
                    end: 1.0,
                  ).animate(curved),
                  child: child,
                ),
              );
            },
          ),
        ),
        GoRoute(
          path: '/upsolve',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const UpsolveScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final curved = CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              );
              return FadeTransition(
                opacity: curved,
                child: ScaleTransition(
                  scale: Tween<double>(
                    begin: 0.95,
                    end: 1.0,
                  ).animate(curved),
                  child: child,
                ),
              );
            },
          ),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const ProfileScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final curved = CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              );
              return FadeTransition(
                opacity: curved,
                child: ScaleTransition(
                  scale: Tween<double>(
                    begin: 0.95,
                    end: 1.0,
                  ).animate(curved),
                  child: child,
                ),
              );
            },
          ),
        ),
        GoRoute(
          path: '/friends',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const FriendsScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final curved = CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              );
              return FadeTransition(
                opacity: curved,
                child: ScaleTransition(
                  scale: Tween<double>(
                    begin: 0.95,
                    end: 1.0,
                  ).animate(curved),
                  child: child,
                ),
              );
            },
          ),
        ),
        GoRoute(
          path: '/comparison',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const ComparisonScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final curved = CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              );
              return FadeTransition(
                opacity: curved,
                child: ScaleTransition(
                  scale: Tween<double>(
                    begin: 0.95,
                    end: 1.0,
                  ).animate(curved),
                  child: child,
                ),
              );
            },
          ),
        ),
        GoRoute(
          path: '/analysis',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const AIAnalysisScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final curved = CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              );
              return FadeTransition(
                opacity: curved,
                child: ScaleTransition(
                  scale: Tween<double>(
                    begin: 0.95,
                    end: 1.0,
                  ).animate(curved),
                  child: child,
                ),
              );
            },
          ),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const SettingsScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final curved = CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              );
              return FadeTransition(
                opacity: curved,
                child: ScaleTransition(
                  scale: Tween<double>(
                    begin: 0.95,
                    end: 1.0,
                  ).animate(curved),
                  child: child,
                ),
              );
            },
          ),
        ),
      ],
    ),
  ],
);
