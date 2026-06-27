import 'package:algolens/core/widgets/auth_bottom_link.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:algolens/core/local/user_settings_service.dart';
import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/features/auth/screens/widgets/magnus_logo.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ═════════════════════════════════
// CONSTANTS
// File-level — only used here
// ═════════════════════════════════

// ── Screen 1 strings ──────────────
const _s1Headline =
    'You\'re better than\nyour last contest.';
const _s1Subtext = 'Magnus helps you prove it.';

// ── Screen 2 strings ──────────────
const _s2Headline =
    'Four things that\nactually matter.';
const _s2Subtext = 'Everything else is noise.';

// ── Screen 3 strings ──────────────
const _s3Line1 = 'Your rating.';
const _s3Line2 = 'Your contests.';
const _s3Line3 = 'Your weak spots.';
const _s3Line4 = 'Your next move.';
const _s3Subtext = 'One place. No guessing.';
const _s3EasterEgg = 'virtual rating: calculating...';

// ── Button labels ─────────────────
const _ctaLabel = 'Start Competing';
const _continueLabel = 'Continue';

// ── Bottom link ───────────────────
const _bottomPrompt = 'Already on Magnus?';
const _bottomAction = 'Sign In';

// ── CF rank colors ────────────────
const _rankColors = [
  Color(0xFF808080), // newbie
  Color(0xFF008000), // pupil
  Color(0xFF03A89E), // specialist
  Color(0xFF3B82F6), // expert
  Color(0xFFAA00AA), // candidate master
  Color(0xFFFF8C00), // master
  Color(0xFFFF0000), // grandmaster
];

// ── Feature data model ────────────
class _FeatureData {
  const _FeatureData({
    required this.icon,
    required this.title,
    required this.description,
  });
  final IconData icon;
  final String title;
  final String description;
}

// ── Feature rows data ─────────────
const _features = [
  _FeatureData(
    icon: CupertinoIcons.bell,
    title: 'Contest reminders',
    description: 'Know before the round starts.',
  ),
  _FeatureData(
    icon: CupertinoIcons.graph_circle,
    title: 'Rating tracker',
    description: 'Every contest. Every shift.',
  ),
  _FeatureData(
    icon: CupertinoIcons.scope,
    title: 'Weak topic finder',
    description: 'Know what\'s costing you rating.',
  ),
  _FeatureData(
    icon: CupertinoIcons.arrow_up_circle,
    title: 'Upsolve queue',
    description: 'Finish what the contest didn\'t.',
  ),
];

// ── Sizes ─────────────────────────
const _logoLarge = 80.0;
const _logoSmall = 56.0;
const _rankDotSize = 8.0;
const _rankDotSpacing = 6.0;

// ═════════════════════════════════
// ONBOARDING SCREEN
// Public — entry point
// Handles: navigation + completion
// PopScope: exit app on back press
// ═════════════════════════════════

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  // ── Complete onboarding → register
  Future<void> _finish(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final svc = ref.read(
      userSettingsServiceProvider,
    );
    await svc.completeOnboarding();
    if (!context.mounted) return;
    context.goNamed(RouteNames.register);
  }

  // ── Skip → login
  Future<void> _signIn(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final svc = ref.read(
      userSettingsServiceProvider,
    );
    await svc.completeOnboarding();
    if (!context.mounted) return;
    context.goNamed(RouteNames.login);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        SystemNavigator.pop();
      },
      child: AppBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: _OnboardingPageView(
              onFinish: () =>
                  _finish(context, ref),
              onSignIn: () =>
                  _signIn(context, ref),
            ),
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════
// ONBOARDING PAGE VIEW
// Owns: PageController + page state
// Renders: 3 pages + pill indicator
// ═════════════════════════════════

class _OnboardingPageView extends StatefulWidget {
  const _OnboardingPageView({
    required this.onFinish,
    required this.onSignIn,
  });

  final VoidCallback onFinish;
  final VoidCallback onSignIn;

  @override
  State<_OnboardingPageView> createState() =>
      _OnboardingPageViewState();
}

class _OnboardingPageViewState
    extends State<_OnboardingPageView> {
  late final PageController _ctrl;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _ctrl = PageController();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _next() {
    if (_page < 2) {
      _ctrl.nextPage(
        duration: const Duration(
          milliseconds: 350,
        ),
        curve: Curves.easeOutCubic,
      );
    } else {
      widget.onFinish();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Pill indicator ─────────
        Padding(
          padding: EdgeInsets.only(top: 16.h),
          child: SmoothPageIndicator(
            controller: _ctrl,
            count: 3,
            effect: ExpandingDotsEffect(
              dotHeight: 6.h,
              dotWidth: 6.w,
              expansionFactor: 4,
              spacing: 6.w,
              activeDotColor: AppColors.primary,
              dotColor: Colors.white.withValues(
                alpha: 0.18,
              ),
            ),
          ),
        ),

        // ── Pages ──────────────────
        Expanded(
          child: PageView(
            controller: _ctrl,
            onPageChanged: (i) =>
                setState(() => _page = i),
            children: [
              _Screen1(
                onSignIn: widget.onSignIn,
              ),
              _Screen2(
                onContinue: _next,
                onSignIn: widget.onSignIn,
              ),
              _Screen3(
                onGetStarted: widget.onFinish,
                onSignIn: widget.onSignIn,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ═════════════════════════════════
// SCREEN 1 — IDENTITY
// Emotional job: "I feel something"
// Pure layout — no logic
// ═════════════════════════════════

class _Screen1 extends StatelessWidget {
  const _Screen1({required this.onSignIn});

  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      child: Column(
        children: [
          const Spacer(flex: 2),

          const MagnusLogo(size: _logoLarge),

          SizedBox(height: 24.h),

          const _CfRankLadder(),

          SizedBox(height: 28.h),

          Text(
            _s1Headline,
            style: GoogleFonts.inter(
              fontSize: 28.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.15,
              letterSpacing: -0.8,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 12.h),

          Text(
            _s1Subtext,
            style: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(
                alpha: 0.55,
              ),
            ),
            textAlign: TextAlign.center,
          ),

          const Spacer(flex: 3),

          // ── Bottom link ───────────
          AuthBottomLink(
            prompt: _bottomPrompt,
            action: _bottomAction,
            onTap: onSignIn,
          ),

          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}

// ═════════════════════════════════
// SCREEN 2 — EVIDENCE
// Emotional job: "Built for me"
// Pure layout — no logic
// ═════════════════════════════════

class _Screen2 extends StatelessWidget {
  const _Screen2({
    required this.onContinue,
    required this.onSignIn,
  });

  final VoidCallback onContinue;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Scrollable content ────────
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 28.w,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40.h),

                Text(
                  _s2Headline,
                  style: GoogleFonts.inter(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.2,
                    letterSpacing: -0.5,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 10.h),

                SizedBox(
                  width: 260.w,
                  child: Text(
                    _s2Subtext,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white
                          .withValues(alpha: 0.55),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 40.h),

                ..._features.map(
                  (f) => _FeatureRow(feature: f),
                ),

                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),

        // ── Fixed bottom ──────────────
        Padding(
          padding: EdgeInsets.fromLTRB(
            28.w,
            0,
            28.w,
            32.h,
          ),
          child: Column(
            children: [
              AppButton(
                label: _continueLabel,
                onTap: onContinue,
                type: AppButtonType.glow,
                glowIntensity: 0.3,
              ),

              SizedBox(height: 16.h),

              // ── Bottom link ───────────
              AuthBottomLink(
                prompt: _bottomPrompt,
                action: _bottomAction,
                onTap: onSignIn,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ═════════════════════════════════
// SCREEN 3 — ACTION
// Emotional job: "I am ready"
// Has stagger animation
// ═════════════════════════════════

class _Screen3 extends StatefulWidget {
  const _Screen3({
    required this.onGetStarted,
    required this.onSignIn,
  });

  final VoidCallback onGetStarted;
  final VoidCallback onSignIn;

  @override
  State<_Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<_Screen3>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final List<Animation<double>> _anims;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _anims = List.generate(4, (i) {
      final start = (i * 0.167).clamp(0.0, 1.0);
      final end =
          (start + 0.333).clamp(0.0, 1.0);
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: _ctrl,
          curve: Interval(
            start,
            end,
            curve: Curves.easeOut,
          ),
        ),
      );
    });
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lines = [
      _s3Line1,
      _s3Line2,
      _s3Line3,
      _s3Line4,
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      child: Column(
        children: [
          const Spacer(flex: 2),

          const MagnusLogo(size: _logoSmall),

          SizedBox(height: 28.h),

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.center,
            children: List.generate(
              lines.length,
              (i) => FadeTransition(
                opacity: _anims[i],
                child: Text(
                  lines[i],
                  style: GoogleFonts.inter(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          SizedBox(height: 16.h),

          Text(
            _s3Subtext,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(
                alpha: 0.50,
              ),
            ),
            textAlign: TextAlign.center,
          ),

          const Spacer(flex: 3),

          AppButton(
            label: _ctaLabel,
            onTap: widget.onGetStarted,
            type: AppButtonType.glow,
            glowIntensity: 1.0,
          ),

          SizedBox(height: 16.h),

          // ── Bottom link ───────────
          AuthBottomLink(
            prompt: _bottomPrompt,
            action: _bottomAction,
            onTap: widget.onSignIn,
          ),

          SizedBox(height: 8.h),

          Text(
            _s3EasterEgg,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 9.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(
                alpha: 0.18,
              ),
            ),
          ),

          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}

// ═════════════════════════════════
// CF RANK LADDER
// 7 colored dots — CF rank colors
// Pure stateless — no logic
// ═════════════════════════════════

class _CfRankLadder extends StatelessWidget {
  const _CfRankLadder();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _rankColors.length,
        (i) {
          final isLast =
              i == _rankColors.length - 1;
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal:
                  (_rankDotSpacing / 2).w,
            ),
            width: _rankDotSize.r,
            height: _rankDotSize.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _rankColors[i],
              boxShadow: isLast
                  ? [
                      BoxShadow(
                        color: _rankColors[i]
                            .withValues(alpha: 0.50),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
          );
        },
      ),
    );
  }
}

// ═════════════════════════════════
// FEATURE ROW
// Single feature with icon + text
// Used by _Screen2 only → private
// ═════════════════════════════════

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.feature});

  final _FeatureData feature;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.center,
        children: [
          // Icon container
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: AppColors.primary
                  .withValues(alpha: 0.10),
              borderRadius:
                  BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColors.primary
                    .withValues(alpha: 0.20),
                width: 1,
              ),
            ),
            child: Icon(
              feature.icon,
              size: 20.r,
              color: AppColors.primary,
            ),
          ),

          SizedBox(width: 16.w),

          // Text
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Text(
                  feature.title,
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: -0.2,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  feature.description,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white
                        .withValues(alpha: 0.55),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}