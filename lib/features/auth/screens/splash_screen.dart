import 'package:algolens/features/auth/screens/widgets/magnus_logo.dart';
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

// ─────────────────────────────────
// CONSTANTS
// Only used by this file
// ─────────────────────────────────

const _tagline = 'Your competitive edge.';
const _letters = ['M', 'A', 'G', 'N', 'U', 'S'];

const _statusMessages = [
  'syncing profile...',
  'loading contests...',
  'ready.',
];

const _logoDuration = Duration(milliseconds: 600);
const _textDuration = Duration(milliseconds: 500);
const _lineDuration = Duration(milliseconds: 300);
const _taglineDuration = Duration(milliseconds: 400);
const _statusDuration = Duration(milliseconds: 300);

const _logoDelay = Duration(milliseconds: 200);
const _textDelay = Duration(milliseconds: 800);
const _lineDelay = Duration(milliseconds: 1200);
const _taglineDelay = Duration(milliseconds: 1400);
const _statusDelay = Duration(milliseconds: 1800);
const _statusCycleDelay = Duration(milliseconds: 600);
const _navigateDelay = Duration(milliseconds: 2800);

// ─────────────────────────────────
// SPLASH SCREEN
// Handles: animations + navigation
// ─────────────────────────────────

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  // ── Controllers ───────────────────────────────────
  late final AnimationController _logoCtrl;
  late final AnimationController _textCtrl;
  late final AnimationController _lineCtrl;
  late final AnimationController _taglineCtrl;
  late final AnimationController _statusCtrl;

  // ── Animations ────────────────────────────────────
  late final Animation<double> _logoOpacity;
  late final Animation<Offset> _logoSlide;
  late final List<Animation<double>> _letterOpacities;
  late final Animation<double> _lineOpacity;
  late final Animation<double> _lineWidth;
  late final Animation<double> _taglineOpacity;
  late final Animation<double> _statusOpacity;

  // ── State ─────────────────────────────────────────
  int _statusIndex = 0;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startSequence();
    _navigate();
  }

  @override
  void dispose() {
    _logoCtrl.dispose();
    _textCtrl.dispose();
    _lineCtrl.dispose();
    _taglineCtrl.dispose();
    _statusCtrl.dispose();
    super.dispose();
  }

  // ── Animation setup ───────────────────────────────

  void _setupAnimations() {
    _logoCtrl = AnimationController(
      vsync: this,
      duration: _logoDuration,
    );
    _logoOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _logoCtrl,
        curve: Curves.easeOut,
      ),
    );
    _logoSlide = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _logoCtrl,
        curve: Curves.easeOut,
      ),
    );

    _textCtrl = AnimationController(
      vsync: this,
      duration: _textDuration,
    );
    _letterOpacities = List.generate(
      _letters.length,
      (i) {
        final start = (i * 0.12).clamp(0.0, 1.0);
        final end = (start + 0.40).clamp(0.0, 1.0);
        return Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _textCtrl,
            curve: Interval(
              start,
              end,
              curve: Curves.easeOut,
            ),
          ),
        );
      },
    );

    _lineCtrl = AnimationController(
      vsync: this,
      duration: _lineDuration,
    );
    _lineOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _lineCtrl,
        curve: Curves.easeOut,
      ),
    );
    _lineWidth = Tween<double>(
      begin: 0.0,
      end: 60.0,
    ).animate(
      CurvedAnimation(
        parent: _lineCtrl,
        curve: Curves.easeOut,
      ),
    );

    _taglineCtrl = AnimationController(
      vsync: this,
      duration: _taglineDuration,
    );
    _taglineOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _taglineCtrl,
        curve: Curves.easeOut,
      ),
    );

    _statusCtrl = AnimationController(
      vsync: this,
      duration: _statusDuration,
    );
    _statusOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _statusCtrl,
        curve: Curves.easeOut,
      ),
    );
  }

  // ── Animation sequence ────────────────────────────

  Future<void> _startSequence() async {
    await Future.delayed(_logoDelay);
    if (!mounted) return;
    _logoCtrl.forward();

    await Future.delayed(_textDelay);
    if (!mounted) return;
    _textCtrl.forward();

    await Future.delayed(_lineDelay - _textDelay);
    if (!mounted) return;
    _lineCtrl.forward();

    await Future.delayed(_taglineDelay - _lineDelay);
    if (!mounted) return;
    _taglineCtrl.forward();

    await Future.delayed(_statusDelay - _taglineDelay);
    if (!mounted) return;
    _statusCtrl.forward();

    await _cycleStatus();
  }

  Future<void> _cycleStatus() async {
    for (int i = 1; i < _statusMessages.length; i++) {
      await Future.delayed(_statusCycleDelay);
      if (!mounted) return;
      setState(() => _statusIndex = i);
    }
  }

  // ── Navigation — unchanged from original ─────────

  Future<void> _navigate() async {
    await Future.delayed(_navigateDelay);
    if (!mounted) return;

    final svc = ref.read(userSettingsServiceProvider);
    final token = await SecureStorage.getAccessToken();
    final cfHandle = await SecureStorage.getCfHandle();
    final onboardingDone = await svc.isOnboardingDone();

    if (!mounted) return;

    if (token == null && !onboardingDone) {
      context.goNamed(RouteNames.onboarding);
      return;
    }
    if (token == null) {
      context.goNamed(RouteNames.login);
      return;
    }
    if (cfHandle == null || cfHandle.isEmpty) {
      context.goNamed(RouteNames.cfHandleSetup);
      return;
    }
    context.goNamed(RouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: _SplashContent(
            logoOpacity: _logoOpacity,
            logoSlide: _logoSlide,
            letterOpacities: _letterOpacities,
            lineOpacity: _lineOpacity,
            lineWidth: _lineWidth,
            taglineOpacity: _taglineOpacity,
            statusOpacity: _statusOpacity,
            statusIndex: _statusIndex,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────
// SPLASH CONTENT
// Pure layout — no logic
// ─────────────────────────────────

class _SplashContent extends StatelessWidget {
  const _SplashContent({
    required this.logoOpacity,
    required this.logoSlide,
    required this.letterOpacities,
    required this.lineOpacity,
    required this.lineWidth,
    required this.taglineOpacity,
    required this.statusOpacity,
    required this.statusIndex,
  });

  final Animation<double> logoOpacity;
  final Animation<Offset> logoSlide;
  final List<Animation<double>> letterOpacities;
  final Animation<double> lineOpacity;
  final Animation<double> lineWidth;
  final Animation<double> taglineOpacity;
  final Animation<double> statusOpacity;
  final int statusIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 2),

        // Logo
        _AnimatedLogo(
          opacity: logoOpacity,
          slide: logoSlide,
        ),

        SizedBox(height: 28.h),

        // MAGNUS letters
        _MagnusLetterStamp(
          letterOpacities: letterOpacities,
        ),

        SizedBox(height: 10.h),

        // Terminal line
        _TerminalLine(
          opacity: lineOpacity,
          width: lineWidth,
        ),

        SizedBox(height: 10.h),

        // Tagline
        _Tagline(
          opacity: taglineOpacity,
        ),

        const Spacer(flex: 2),

        // Status text
        _StatusText(
          opacity: statusOpacity,
          statusIndex: statusIndex,
        ),

        SizedBox(height: 40.h),
      ],
    );
  }
}

// ─────────────────────────────────
// ANIMATED LOGO
// Fade + slide up
// ─────────────────────────────────

class _AnimatedLogo extends StatelessWidget {
  const _AnimatedLogo({
    required this.opacity,
    required this.slide,
  });

  final Animation<double> opacity;
  final Animation<Offset> slide;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: SlideTransition(
        position: slide,
        child: const MagnusLogo(size: 100),
      ),
    );
  }
}

// ─────────────────────────────────
// MAGNUS LETTER STAMP
// Each letter fades in with stagger
// ─────────────────────────────────

class _MagnusLetterStamp extends StatelessWidget {
  const _MagnusLetterStamp({
    required this.letterOpacities,
  });

  final List<Animation<double>> letterOpacities;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _letters.length,
        (i) => FadeTransition(
          opacity: letterOpacities[i],
          child: Text(
            _letters[i],
            style: GoogleFonts.jetBrainsMono(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
              letterSpacing: 8,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────
// TERMINAL LINE
// 1px electric blue line
// Fades in + expands width
// ─────────────────────────────────

class _TerminalLine extends StatelessWidget {
  const _TerminalLine({
    required this.opacity,
    required this.width,
  });

  final Animation<double> opacity;
  final Animation<double> width;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: AnimatedBuilder(
        animation: width,
        builder: (_, __) => Container(
          width: width.value.w,
          height: 1,
          color: AppColors.primary.withValues(alpha: 0.40),
        ),
      ),
    );
  }
}

// ─────────────────────────────────
// TAGLINE
// Fades in after terminal line
// ─────────────────────────────────

class _Tagline extends StatelessWidget {
  const _Tagline({
    required this.opacity,
  });

  final Animation<double> opacity;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: Text(
        _tagline,
        style: GoogleFonts.inter(
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
          color: Colors.white.withValues(alpha: 0.45),
        ),
      ),
    );
  }
}

// ─────────────────────────────────
// STATUS TEXT
// Cycles through status messages
// AnimatedSwitcher for smooth swap
// ─────────────────────────────────

class _StatusText extends StatelessWidget {
  const _StatusText({
    required this.opacity,
    required this.statusIndex,
  });

  final Animation<double> opacity;
  final int statusIndex;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Text(
          _statusMessages[statusIndex],
          key: ValueKey(statusIndex),
          style: GoogleFonts.jetBrainsMono(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF8A9BB0),
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}
