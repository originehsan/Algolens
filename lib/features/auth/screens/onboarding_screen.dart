import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/local/user_settings_service.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/theme/app_colors.dart';

// ─────────────────────────────────
// ONBOARDING DATA
// 3 slides shown once only
// ─────────────────────────────────

class _OnboardingSlide {
  const _OnboardingSlide({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
}

const _slides = [
  _OnboardingSlide(
    icon: Icons.trending_up_rounded,
    title: 'Track CF Rating',
    subtitle: 'Monitor your Codeforces rating '
        'history with beautiful charts '
        'and detailed insights.',
    color: Color(0xFF4DA3FF),
  ),
  _OnboardingSlide(
    icon: Icons.people_rounded,
    title: 'Beat Your Friends',
    subtitle: 'Compare stats, race on '
        'leaderboards and challenge '
        'friends to solve problems.',
    color: Color(0xFF22C55E),
  ),
  _OnboardingSlide(
    icon: Icons.auto_awesome_rounded,
    title: 'AI Powered Insights',
    subtitle: 'Get personalized weak topic '
        'analysis and smart problem '
        'recommendations from AI.',
    color: Color(0xFF00D4FF),
  ),
];

// ─────────────────────────────────
// ONBOARDING SCREEN
// Shown once on first launch
// ─────────────────────────────────

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageCtrl = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    final svc = ref.read(
      userSettingsServiceProvider,
    );
    await svc.completeOnboarding();
    if (!mounted) return;
    context.goNamed(
      RouteNames.register,
    );
  }

  void _skip() {
    context.goNamed(
      RouteNames.register,
    );
  }

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageCtrl.nextPage(
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _currentPage == _slides.length - 1;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 16.h,
                    right: 20.w,
                  ),
                  child: TextButton(
                    onPressed: _skip,
                    child: Text(
                      'Skip',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(
                          alpha: 0.55,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Page view
              Expanded(
                child: PageView.builder(
                  controller: _pageCtrl,
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  itemCount: _slides.length,
                  itemBuilder: (context, index) => _SlideWidget(
                    slide: _slides[index],
                  ),
                ),
              ),

              // Dots + buttons
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 32.h,
                ),
                child: Column(
                  children: [
                    // Page dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _slides.length,
                        (i) => _Dot(
                          active: i == _currentPage,
                        ),
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // Next / Get Started
                    AppButton(
                      label: isLast ? 'Get Started' : 'Next',
                      onTap: _nextPage,
                    ),

                    SizedBox(height: 16.h),

                    // Login link
                    GestureDetector(
                      onTap: () => context.goNamed(
                        RouteNames.login,
                      ),
                      child: Text(
                        'Already have an account? Sign In',
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(
                            alpha: 0.55,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────
// SLIDE WIDGET
// ─────────────────────────────────

class _SlideWidget extends StatelessWidget {
  const _SlideWidget({
    required this.slide,
  });

  final _OnboardingSlide slide;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 32.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon circle
          Container(
            width: 120.r,
            height: 120.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: slide.color.withValues(alpha: 0.12),
              border: Border.all(
                color: slide.color.withValues(alpha: 0.35),
                width: 1.5,
              ),
            ),
            child: Icon(
              slide.icon,
              color: slide.color,
              size: 56.r,
            ),
          ),

          SizedBox(height: 40.h),

          // Title
          Text(
            slide.title,
            style: GoogleFonts.inter(
              fontSize: 26.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 16.h),

          // Subtitle
          Text(
            slide.subtitle,
            style: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.60),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────
// DOT INDICATOR
// ─────────────────────────────────

class _Dot extends StatelessWidget {
  const _Dot({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 300,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 4.w,
      ),
      width: active ? 24.w : 8.w,
      height: 8.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        color: active
            ? AppColors.primary
            : Colors.white.withValues(
                alpha: 0.30,
              ),
      ),
    );
  }
}
