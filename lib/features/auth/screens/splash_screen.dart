import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/storage/secure_storage.dart';
import 'package:algolens/core/local/user_settings_service.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/theme/app_colors.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnim = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: Curves.easeIn,
      ),
    );

    _ctrl.forward();
    _navigate();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _navigate() async {
    // Wait for animation
    await Future.delayed(
      const Duration(milliseconds: 2000),
    );

    if (!mounted) return;

    final svc = ref.read(
      userSettingsServiceProvider,
    );

    final token = await SecureStorage.getAccessToken();
    final cfHandle = await SecureStorage.getCfHandle();
    final onboardingDone = await svc.isOnboardingDone();

    if (!mounted) return;

    // Not logged in + no onboarding
    if (token == null && !onboardingDone) {
      context.goNamed(
        RouteNames.onboarding,
      );
      return;
    }

    // Not logged in + onboarding done
    if (token == null) {
      context.goNamed(
        RouteNames.login,
      );
      return;
    }

    // Logged in + no CF handle
    if (cfHandle == null || cfHandle.isEmpty) {
      context.goNamed(
        RouteNames.cfHandleSetup,
      );
      return;
    }

    // Fully set up → home
    context.goNamed(RouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FadeTransition(
          opacity: _fadeAnim,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo circle
                Container(
                  width: 100.r,
                  height: 100.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withValues(
                      alpha: 0.15,
                    ),
                    border: Border.all(
                      color: AppColors.primary.withValues(
                        alpha: 0.60,
                      ),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.code_rounded,
                    color: AppColors.primary,
                    size: 48.r,
                  ),
                ),

                SizedBox(height: 24.h),

                // App name
                Text(
                  'AlgoLens',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),

                SizedBox(height: 8.h),

                // Tagline
                Text(
                  'Track. Analyze. Improve.',
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(
                      alpha: 0.55,
                    ),
                    letterSpacing: 1,
                  ),
                ),

                SizedBox(height: 60.h),

                // Loading indicator
                SizedBox(
                  width: 24.r,
                  height: 24.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(
                      AppColors.primary.withValues(
                        alpha: 0.70,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
