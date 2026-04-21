import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:algolens/features/auth/screens/splash_screen.dart';

// ──────────────────────────────
// ROUTE NAMES
// All named routes as constants
// ──────────────────────────────

/// All route name constants
///
/// Usage:
/// context.goNamed(
///   RouteNames.home,
/// );
abstract class RouteNames {
  RouteNames._();

  static const String splash = 'splash';
  static const String onboarding = 'onboarding';
  static const String register = 'register';
  static const String emailVerification = 'email-verification';
  static const String login = 'login';
  static const String forgotPassword = 'forgot-password';
  static const String resetPassword = 'reset-password';
  static const String cfHandleSetup = 'cf-handle-setup';
  static const String home = 'home';
  static const String contests = 'contests';
  static const String allContests = 'all-contests';
  static const String practice = 'practice';
  static const String recommendations = 'recommendations';
  static const String upsolve = 'upsolve';
  static const String profile = 'profile';
  static const String friends = 'friends';
  static const String comparison = 'comparison';
  static const String aiAnalysis = 'ai-analysis';
  static const String settings = 'settings';
}

// ──────────────────────────────
// ROUTE PATHS
// All path strings as constants
// ──────────────────────────────

/// All route path constants
abstract class RoutePaths {
  RoutePaths._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String register = '/register';
  static const String emailVerification = '/email-verification';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String cfHandleSetup = '/cf-handle-setup';
  static const String home = '/home';
  static const String contests = '/contests';
  static const String allContests = '/all-contests';
  static const String practice = '/practice';
  static const String recommendations = '/recommendations';
  static const String upsolve = '/upsolve';
  static const String profile = '/profile';
  static const String friends = '/friends';
  static const String comparison = '/comparison';
  static const String aiAnalysis = '/ai-analysis';
  static const String settings = '/settings';
}

// ──────────────────────────────
// ROUTER PROVIDER
// ──────────────────────────────

/// GoRouter provider
///
/// Usage in main.dart:
/// MaterialApp.router(
///   routerConfig: ref.watch(
///     routerProvider,
///   ),
/// )
final routerProvider = Provider<GoRouter>((ref) {
  return AppRouter.router(ref);
});

// ──────────────────────────────
// APP ROUTER
// ──────────────────────────────

/// GoRouter configuration
///
/// Auth guard logic:
/// → Check accessToken in
///   SecureStorage
/// → Check cfHandle in
///   SecureStorage
/// → Redirect accordingly
abstract class AppRouter {
  AppRouter._();

  static GoRouter router(Ref ref) {
    return GoRouter(
      initialLocation: RoutePaths.splash,
      debugLogDiagnostics: true,

      // ────────────────────────
      // AUTH REDIRECT
      // Simplified - splash handles auth
      // ────────────────────────

      redirect: (context, state) {
        /// Always allow splash on startup
        /// Splash screen handles auth logic
        /// and redirects appropriately
        return null;
      },

      // ────────────────────────
      // ROUTES
      // All app screens
      // ────────────────────────

      routes: [
        // ──────────────────────
        // AUTH ROUTES
        // ──────────────────────

        GoRoute(
          path: RoutePaths.splash,
          name: RouteNames.splash,
          builder: (context, state) => const SplashScreen(),
        ),

        GoRoute(
          path: RoutePaths.onboarding,
          name: RouteNames.onboarding,
          builder: (context, state) => const _PlaceholderScreen(
            label: 'Onboarding',
          ),
        ),

        GoRoute(
          path: RoutePaths.register,
          name: RouteNames.register,
          builder: (context, state) => const _PlaceholderScreen(
            label: 'Register',
          ),
        ),

        GoRoute(
          path: RoutePaths.emailVerification,
          name: RouteNames.emailVerification,
          builder: (context, state) => const _PlaceholderScreen(
            label: 'Email Verification',
          ),
        ),

        GoRoute(
          path: RoutePaths.login,
          name: RouteNames.login,
          builder: (context, state) => const _PlaceholderScreen(
            label: 'Login',
          ),
        ),

        GoRoute(
          path: RoutePaths.forgotPassword,
          name: RouteNames.forgotPassword,
          builder: (context, state) => const _PlaceholderScreen(
            label: 'Forgot Password',
          ),
        ),

        GoRoute(
          path: RoutePaths.resetPassword,
          name: RouteNames.resetPassword,
          builder: (context, state) => const _PlaceholderScreen(
            label: 'Reset Password',
          ),
        ),

        GoRoute(
          path: RoutePaths.cfHandleSetup,
          name: RouteNames.cfHandleSetup,
          builder: (context, state) => const _PlaceholderScreen(
            label: 'CF Handle Setup',
          ),
        ),

        // ──────────────────────
        // MAIN APP ROUTES
        // ──────────────────────

        GoRoute(
          path: RoutePaths.home,
          name: RouteNames.home,
          builder: (context, state) => const _PlaceholderScreen(
            label: 'Home',
          ),
        ),

        GoRoute(
          path: RoutePaths.contests,
          name: RouteNames.contests,
          builder: (context, state) => const _PlaceholderScreen(
            label: 'Contests',
          ),
        ),

        GoRoute(
          path: RoutePaths.allContests,
          name: RouteNames.allContests,
          builder: (context, state) => const _PlaceholderScreen(
            label: 'All Contests',
          ),
        ),

        GoRoute(
          path: RoutePaths.practice,
          name: RouteNames.practice,
          builder: (context, state) => const _PlaceholderScreen(
            label: 'Practice',
          ),
        ),

        GoRoute(
          path: RoutePaths.recommendations,
          name: RouteNames.recommendations,
          builder: (context, state) => const _PlaceholderScreen(
            label: 'Recommendations',
          ),
        ),

        GoRoute(
          path: RoutePaths.upsolve,
          name: RouteNames.upsolve,
          builder: (context, state) => const _PlaceholderScreen(
            label: 'Upsolve',
          ),
        ),

        GoRoute(
          path: RoutePaths.profile,
          name: RouteNames.profile,
          builder: (context, state) => const _PlaceholderScreen(
            label: 'Profile',
          ),
        ),

        GoRoute(
          path: RoutePaths.friends,
          name: RouteNames.friends,
          builder: (context, state) => const _PlaceholderScreen(
            label: 'Friends',
          ),
        ),

        GoRoute(
          path: RoutePaths.comparison,
          name: RouteNames.comparison,
          builder: (context, state) => const _PlaceholderScreen(
            label: 'Comparison',
          ),
        ),

        GoRoute(
          path: RoutePaths.aiAnalysis,
          name: RouteNames.aiAnalysis,
          builder: (context, state) => const _PlaceholderScreen(
            label: 'AI Analysis',
          ),
        ),

        GoRoute(
          path: RoutePaths.settings,
          name: RouteNames.settings,
          builder: (context, state) => const _PlaceholderScreen(
            label: 'Settings',
          ),
        ),
      ],

      // ────────────────────────
      // ERROR ROUTE
      // ────────────────────────

      errorBuilder: (context, state) => _PlaceholderScreen(
        label: 'Error: ${state.error}',
      ),
    );
  }
}

// ──────────────────────────────
// PLACEHOLDER SCREEN
// Temp until real screens built
// Replace one by one per prompt
// ──────────────────────────────

/// Temporary placeholder screen
///
/// Shows route label in center
/// Replace with real screen
/// when building that feature
class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060B14),
      body: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
