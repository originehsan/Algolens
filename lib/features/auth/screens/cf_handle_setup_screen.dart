import 'dart:async';
import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/app_text_field.dart';
import 'package:algolens/core/widgets/auth_header.dart';
import 'package:algolens/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

// ═════════════════════════════════
// CONSTANTS
// File-level — only used here
// ═════════════════════════════════

// ── Strings ───────────────────────
const _overline = 'CODEFORCES SETUP';
const _subtext = 'Connect your handle.';
const _labelHandle = 'CF HANDLE';
const _hintHandle = 'e.g. tourist';
const _ctaLabel = "Let's Go";
const _skipLabel = 'Skip for now';
const _checkingLabel = 'QUERYING CODEFORCES...';
const _helperText = 'You can change this later in settings.';

// ── Auth field params ─────────────
const _authBorderRadius = 10.0;
const _authBorderWidth = 1.0;

// ── Debounce ──────────────────────
const _debounceMs = 800;

// ── CF Rank colors ────────────────
const _rankColors = {
  'newbie': Color(0xFF808080),
  'pupil': Color(0xFF008000),
  'specialist': Color(0xFF03A89E),
  'expert': Color(0xFF3B82F6),
  'candidate master': Color(0xFFAA00AA),
  'master': Color(0xFFFF8C00),
  'international master': Color(0xFFFF8C00),
  'grandmaster': Color(0xFFFF0000),
  'international grandmaster': Color(0xFFFF0000),
  'legendary grandmaster': Color(0xFFFF0000),
};

// ═════════════════════════════════
// CF HANDLE SETUP SCREEN
// Public — entry point
// Handles: debounce + verify + save
// PopScope: no back — authenticated
// ═════════════════════════════════

class CfHandleSetupScreen extends ConsumerStatefulWidget {
  const CfHandleSetupScreen({super.key});

  @override
  ConsumerState<CfHandleSetupScreen> createState() =>
      _CfHandleSetupScreenState();
}

class _CfHandleSetupScreenState extends ConsumerState<CfHandleSetupScreen> {
  final _handleCtrl = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _handleCtrl.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // ── Handle changed ────────────────

  void _onHandleChanged(String val) {
    _debounce?.cancel();
    if (val.trim().isEmpty) {
      ref.read(cfHandleSetupProvider.notifier).reset();
      return;
    }
    _debounce = Timer(
      const Duration(milliseconds: _debounceMs),
      () => ref.read(cfHandleSetupProvider.notifier).verifyHandle(val.trim()),
    );
  }

  // ── Confirm ───────────────────────

  Future<void> _confirm() async {
    final cfState = ref.read(cfHandleSetupProvider);
    if (cfState is! CfHandleVerified) return;
    await ref
        .read(cfHandleSetupProvider.notifier)
        .saveHandle(_handleCtrl.text.trim());
    if (!mounted) return;
    context.goNamed(RouteNames.home);
  }

  // ── Skip ──────────────────────────

  void _skip() => context.goNamed(RouteNames.home);

  @override
  Widget build(BuildContext context) {
    final cfState = ref.watch(cfHandleSetupProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        // No back allowed
        // User is authenticated
        // Must confirm or skip
      },
      child: AppBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: _CfContent(
              handleCtrl: _handleCtrl,
              cfState: cfState,
              onHandleChanged: _onHandleChanged,
              onConfirm: _confirm,
              onSkip: _skip,
            ),
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════
// CF CONTENT
// Pure layout — no logic
// ═════════════════════════════════

class _CfContent extends StatelessWidget {
  const _CfContent({
    required this.handleCtrl,
    required this.cfState,
    required this.onHandleChanged,
    required this.onConfirm,
    required this.onSkip,
  });

  final TextEditingController handleCtrl;
  final CfHandleState cfState;
  final ValueChanged<String> onHandleChanged;
  final VoidCallback onConfirm;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 24.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16.h),

          // ── Header ────────────────
          const AuthHeader(
            overline: _overline,
            subtext: _subtext,
          ),

          SizedBox(height: 32.h),

          // ── Form ──────────────────
          _CfForm(
            handleCtrl: handleCtrl,
            cfState: cfState,
            onHandleChanged: onHandleChanged,
            onConfirm: onConfirm,
          ),

          SizedBox(height: 20.h),

          // ── CTA ───────────────────
          _CfCTA(
            cfState: cfState,
            onConfirm: onConfirm,
            onSkip: onSkip,
          ),

          SizedBox(height: 16.h),

          // ── Helper text ───────────
          Text(
            _helperText,
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(
                alpha: 0.35,
              ),
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}

// ═════════════════════════════════
// CF FORM
// Handle input + checking + rank card
// ═════════════════════════════════

class _CfForm extends StatelessWidget {
  const _CfForm({
    required this.handleCtrl,
    required this.cfState,
    required this.onHandleChanged,
    required this.onConfirm,
  });

  final TextEditingController handleCtrl;
  final CfHandleState cfState;
  final ValueChanged<String> onHandleChanged;
  final VoidCallback onConfirm;

  // ── Field state ───────────────────

  AppTextFieldState get _fieldState {
    return switch (cfState) {
      CfHandleVerified() => AppTextFieldState.success,
      CfHandleError() => AppTextFieldState.error,
      _ => AppTextFieldState.defaultState,
    };
  }

  // ── Error text ────────────────────

  String? get _cfError {
    if (cfState is CfHandleError) {
      return (cfState as CfHandleError).message;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(
          alpha: 0.04,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: cfState is CfHandleVerified
              ? AppColors.success.withValues(
                  alpha: 0.30,
                )
              : Colors.white.withValues(
                  alpha: 0.08,
                ),
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Handle field ──────────
          AppTextField(
            label: _labelHandle,
            hint: _hintHandle,
            controller: handleCtrl,
            prefixIcon: Icons.code_rounded,
            textInputAction: TextInputAction.done,
            onChanged: onHandleChanged,
            onSubmitted: (_) => onConfirm(),
            fieldState: _fieldState,
            errorText: _cfError,
            labelUppercase: true,
            customBorderRadius: _authBorderRadius,
            customBorderWidth: _authBorderWidth,
          ),

          // ── Checking state ────────
          if (cfState is CfHandleLoading) ...[
            SizedBox(height: 10.h),
            Row(
              children: [
                SizedBox(
                  width: 12.r,
                  height: 12.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    color: AppColors.primary.withValues(alpha: 0.60),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  _checkingLabel,
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(
                      alpha: 0.40,
                    ),
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ],

          // ── Rank card ─────────────
          if (cfState is CfHandleVerified) ...[
            SizedBox(height: 14.h),
            _RankCard(
              handle: handleCtrl.text.trim(),
              rank: (cfState as CfHandleVerified).rank,
              rating: (cfState as CfHandleVerified).rating,
            ),
          ],
        ],
      ),
    );
  }
}

// ═════════════════════════════════
// RANK CARD
// Handle + rank + rating
// Left border in CF rank color
// ═════════════════════════════════

class _RankCard extends StatelessWidget {
  const _RankCard({
    required this.handle,
    required this.rank,
    required this.rating,
  });

  final String handle;
  final String rank;
  final int rating;

  Color get _rankColor =>
      _rankColors[rank.toLowerCase()] ?? const Color(0xFF808080);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _rankColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: _rankColor.withValues(
            alpha: 0.25,
          ),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Left rank color border
          Container(
            width: 4.w,
            height: 56.h,
            decoration: BoxDecoration(
              color: _rankColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                bottomLeft: Radius.circular(10.r),
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Handle + rank text
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    handle,
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    rank,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: _rankColor,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Rating number
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Text(
              '$rating',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════
// CF CTA
// "Let's Go" glow + "Skip" ghost
// ═════════════════════════════════

class _CfCTA extends StatelessWidget {
  const _CfCTA({
    required this.cfState,
    required this.onConfirm,
    required this.onSkip,
  });

  final CfHandleState cfState;
  final VoidCallback onConfirm;
  final VoidCallback onSkip;

  bool get _canConfirm => cfState is CfHandleVerified;

  bool get _isSaving => cfState is CfHandleLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Primary CTA
        AppButton(
          label: _ctaLabel,
          onTap: _canConfirm ? onConfirm : null,
          isLoading: _isSaving,
          isDisabled: !_canConfirm,
          type: AppButtonType.glow,
          glowIntensity: _canConfirm ? 1.0 : 0.0,
        ),

        SizedBox(height: 12.h),

        // Skip
        AppButton(
          label: _skipLabel,
          onTap: onSkip,
          type: AppButtonType.ghost,
        ),
      ],
    );
  }
}
