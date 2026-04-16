import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/storage/secure_storage.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(
      const Duration(milliseconds: 2500),
    );
    if (!mounted) return;
    final isLoggedIn = await SecureStorage.isLoggedIn();
    if (!mounted) return;
    if (isLoggedIn) {
      context.go('/home');
    } else {
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'AlgoLens',
                style: AppTextStyles.display.copyWith(
                  color: AppColors.primary,
                ),
              ).animate().fadeIn(duration: 800.ms).slideY(
                    begin: 0.3,
                    end: 0,
                    duration: 800.ms,
                    curve: Curves.easeOut,
                  ),
              SizedBox(height: 8.h),
              Text(
                'Competitive Programming Analytics',
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
              ).animate().fadeIn(
                    delay: 400.ms,
                    duration: 600.ms,
                  ),
              SizedBox(height: 48.h),
              SizedBox(
                width: 6.r,
                height: 6.r,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                ),
              )
                  .animate(
                    onPlay: (controller) => controller.repeat(),
                  )
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1.2, 1.2),
                    duration: 800.ms,
                    curve: Curves.easeInOut,
                  )
                  .then()
                  .scale(
                    begin: const Offset(1.2, 1.2),
                    end: const Offset(0.8, 0.8),
                    duration: 800.ms,
                    curve: Curves.easeInOut,
                  )
            ],
          ),
        ),
      ),
    );
  }
}
