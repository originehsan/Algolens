import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:algolens/features/auth/screens/splash_screen.dart';
import 'package:algolens/features/auth/screens/onboarding_screen.dart';
import 'package:algolens/features/auth/screens/register_screen.dart';
import 'package:algolens/features/auth/screens/email_verification_screen.dart';
import 'package:algolens/features/auth/screens/login_screen.dart';
import 'package:algolens/features/auth/screens/forgot_password_screen.dart';
import 'package:algolens/features/auth/screens/otp_screen.dart';
import 'package:algolens/features/auth/screens/cf_handle_setup_screen.dart';
import 'package:algolens/features/auth/screens/reset_password_screen.dart';
import 'package:algolens/features/home/screens/home_screen.dart';
import 'package:algolens/features/contests/screens/contest_screen.dart';
import 'package:algolens/features/contests/screens/all_contests_screen.dart';
import 'package:algolens/features/profile/screens/profile_screen.dart';
import 'package:algolens/features/friends/screens/friends_screen.dart';
import 'package:algolens/features/friends/screens/comparison_screen.dart';
import 'package:algolens/features/practice/screens/weak_topics_screen.dart';
import 'package:algolens/features/practice/screens/recommendations_screen.dart';
import 'package:algolens/features/upsolve/screens/upsolve_screen.dart';
import 'package:algolens/features/analysis/screens/ai_analysis_screen.dart';
import 'package:algolens/features/settings/screens/settings_screen.dart';

// ─────────────────────────────────
// ROUTE NAMES
// ─────────────────────────────────

abstract class RouteNames {
  RouteNames._();

  static const String splash = 'splash';
  static const String onboarding = 'onboarding';
  static const String register = 'register';
  static const String emailVerification =
      'email-verification';
  static const String login = 'login';
  static const String forgotPassword = 'forgot-password';
  static const String otpVerification =
      'otp-verification'; // ← NEW
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

// ─────────────────────────────────
// ROUTE PATHS
// ─────────────────────────────────

abstract class RoutePaths {
  RoutePaths._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String register = '/register';
  static const String emailVerification =
      '/email-verification';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String otpVerification =
      '/otp-verification'; // ← NEW
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

// ─────────────────────────────────
// ROUTER PROVIDER
// ─────────────────────────────────

final routerProvider = Provider<GoRouter>((ref) {
  return AppRouter.router(ref);
});

abstract class AppRouter {
  AppRouter._();

  static GoRouter router(Ref ref) {
    return GoRouter(
      initialLocation: RoutePaths.splash,
      debugLogDiagnostics: true,
      redirect: (context, state) => null,

      routes: [
        // ── Auth routes ───────────────

        GoRoute(
          path: RoutePaths.splash,
          name: RouteNames.splash,
          builder: (context, state) =>
              const SplashScreen(),
        ),

        GoRoute(
          path: RoutePaths.onboarding,
          name: RouteNames.onboarding,
          builder: (context, state) =>
              const OnboardingScreen(),
        ),

        GoRoute(
          path: RoutePaths.register,
          name: RouteNames.register,
          builder: (context, state) =>
              const RegisterScreen(),
        ),

        GoRoute(
          path: RoutePaths.emailVerification,
          name: RouteNames.emailVerification,
          builder: (context, state) {
            final email =
                state.extra as String? ?? '';
            return EmailVerificationScreen(
              email: email,
            );
          },
        ),

        GoRoute(
          path: RoutePaths.login,
          name: RouteNames.login,
          builder: (context, state) =>
              const LoginScreen(),
        ),

        GoRoute(
          path: RoutePaths.forgotPassword,
          name: RouteNames.forgotPassword,
          builder: (context, state) =>
              const ForgotPasswordScreen(),
        ),

        // ── OTP verification ──────────
        // Receives: email (String)
        // Passes to reset: email + otp (Map)

        GoRoute(
          path: RoutePaths.otpVerification,
          name: RouteNames.otpVerification,
          builder: (context, state) {
            final email =
                state.extra as String? ?? '';
            return OtpScreen(email: email);
          },
        ),

        // ── Reset password ────────────
        // Receives: { email, otp } (Map)

        GoRoute(
          path: RoutePaths.resetPassword,
          name: RouteNames.resetPassword,
          builder: (context, state) {
            final extra = state.extra
                as Map<String, String>? ??
                {};
            return ResetPasswordScreen(
              email: extra['email'] ?? '',
              otp: extra['otp'] ?? '',
            );
          },
        ),

        GoRoute(
          path: RoutePaths.cfHandleSetup,
          name: RouteNames.cfHandleSetup,
          builder: (context, state) =>
              const CfHandleSetupScreen(),
        ),

        // ── Main app routes ───────────

        GoRoute(
          path: RoutePaths.home,
          name: RouteNames.home,
          builder: (context, state) =>
              const HomeScreen(),
        ),

        GoRoute(
          path: RoutePaths.contests,
          name: RouteNames.contests,
          builder: (context, state) =>
              const ContestScreen(),
        ),

        GoRoute(
          path: RoutePaths.allContests,
          name: RouteNames.allContests,
          builder: (context, state) =>
              const AllContestsScreen(),
        ),

        GoRoute(
          path: RoutePaths.practice,
          name: RouteNames.practice,
          builder: (context, state) =>
              const WeakTopicsScreen(),
        ),

        GoRoute(
          path: RoutePaths.recommendations,
          name: RouteNames.recommendations,
          builder: (context, state) =>
              const RecommendationsScreen(),
        ),

        GoRoute(
          path: RoutePaths.upsolve,
          name: RouteNames.upsolve,
          builder: (context, state) =>
              const UpsolveScreen(),
        ),

        GoRoute(
          path: RoutePaths.profile,
          name: RouteNames.profile,
          builder: (context, state) =>
              const ProfileScreen(),
        ),

        GoRoute(
          path: RoutePaths.friends,
          name: RouteNames.friends,
          builder: (context, state) =>
              const FriendsScreen(),
        ),

        GoRoute(
          path: RoutePaths.comparison,
          name: RouteNames.comparison,
          builder: (context, state) {
            final handles =
                state.extra as (String, String)? ??
                    ('', '');
            return ComparisonScreen(
              handle1: handles.$1,
              handle2: handles.$2,
            );
          },
        ),

        GoRoute(
          path: RoutePaths.aiAnalysis,
          name: RouteNames.aiAnalysis,
          builder: (context, state) =>
              const AiAnalysisScreen(),
        ),

        GoRoute(
          path: RoutePaths.settings,
          name: RouteNames.settings,
          builder: (context, state) =>
              const SettingsScreen(),
        ),
      ],

      errorBuilder: (context, state) =>
          _PlaceholderScreen(
        label: 'Error: ${state.error}',
      ),
    );
  }
}

// ─────────────────────────────────
// PLACEHOLDER — error route only
// ─────────────────────────────────

class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.label});
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