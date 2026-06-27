import 'dart:async';
import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/auth_back_button.dart';
import 'package:algolens/core/widgets/auth_header.dart';
import 'package:algolens/core/widgets/email_chip.dart';
import 'package:algolens/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

// ═════════════════════════════════
// CONSTANTS
// File-level — only used here
// ═════════════════════════════════

// ── Strings ───────────────────────
const _overline = 'VERIFY CODE';
const _subtext = 'Enter the 6-digit code\nsent to your email.';
const _otpLabel = 'CODE FROM EMAIL';
const _ctaLabel = 'Continue';
const _resendLabel = 'Resend code';
// ── Cooldown ──────────────────────
const _cooldownSeconds = 60;

// ── Durations ─────────────────────
const _resendTimerInterval = Duration(seconds: 1);
const _ctaGlowDuration = Duration(milliseconds: 400);

// ═════════════════════════════════
// OTP SCREEN
// Public — entry point
// Receives: email from forgot_password
// Handles: OTP input + resend
// Passes: email + otp to reset_password
// ═════════════════════════════════

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({
    super.key,
    required this.email,
  });

  final String email;

  @override
  ConsumerState<OtpScreen> createState() =>
      _OtpScreenState();
}

class _OtpScreenState
    extends ConsumerState<OtpScreen> {
  // ── State ─────────────────────────
  String _otp = '';
  int _cooldown = 0;
  bool _resent = false;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // ── Can continue ──────────────────

  bool get _canContinue => _otp.length == 6;

  // ── Continue ──────────────────────

  void _continue() {
    if (!_canContinue) return;
    context.pushNamed(
      RouteNames.resetPassword,
      extra: {
        'email': widget.email,
        'otp': _otp,
      },
    );
  }

  // ── Resend ────────────────────────

  Future<void> _resend() async {
    if (_cooldown > 0) return;
    await ref
        .read(forgotPasswordProvider.notifier)
        .forgotPassword(widget.email);
    if (!mounted) return;
    setState(() {
      _resent = true;
      _cooldown = _cooldownSeconds;
      _otp = '';
    });
    _timer = Timer.periodic(
      _resendTimerInterval,
      (t) {
        if (!mounted) {
          t.cancel();
          return;
        }
        setState(() => _cooldown--);
        if (_cooldown <= 0) t.cancel();
      },
    );
  }

  // ── Pin themes ────────────────────

  PinTheme get _defaultTheme => PinTheme(
        width: 44.r,
        height: 52.r,
        textStyle: GoogleFonts.jetBrainsMono(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withValues(
            alpha: 0.05,
          ),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: Colors.white.withValues(
              alpha: 0.12,
            ),
            width: 1,
          ),
        ),
      );

  PinTheme get _focusedTheme =>
      _defaultTheme.copyWith(
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(
            alpha: 0.08,
          ),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: AppColors.primary.withValues(
              alpha: 0.70,
            ),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(
                alpha: 0.12,
              ),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
      );

  PinTheme get _submittedTheme =>
      _defaultTheme.copyWith(
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(
            alpha: 0.10,
          ),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: AppColors.primary.withValues(
              alpha: 0.45,
            ),
            width: 1,
          ),
        ),
      );

  PinTheme get _completedTheme =>
      _defaultTheme.copyWith(
        decoration: BoxDecoration(
          color: AppColors.success.withValues(
            alpha: 0.06,
          ),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: AppColors.success.withValues(
              alpha: 0.45,
            ),
            width: 1,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final resendState =
        ref.watch(forgotPasswordProvider);
    final isResending = resendState is AuthLoading;
    final canResend = _cooldown <= 0 && !isResending;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: _OtpContent(
            email: widget.email,
            otp: _otp,
            cooldown: _cooldown,
            resent: _resent,
            canContinue: _canContinue,
            canResend: canResend,
            isResending: isResending,
            defaultTheme: _defaultTheme,
            focusedTheme: _focusedTheme,
            submittedTheme: _submittedTheme,
            completedTheme: _completedTheme,
            onOtpChanged: (val) =>
                setState(() => _otp = val),
            onOtpCompleted: (val) =>
                setState(() => _otp = val),
            onContinue: _continue,
            onResend: _resend,
            onBack: () => context.pop(),
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════
// OTP CONTENT
// Pure layout — no logic
// ═════════════════════════════════

class _OtpContent extends StatelessWidget {
  const _OtpContent({
    required this.email,
    required this.otp,
    required this.cooldown,
    required this.resent,
    required this.canContinue,
    required this.canResend,
    required this.isResending,
    required this.defaultTheme,
    required this.focusedTheme,
    required this.submittedTheme,
    required this.completedTheme,
    required this.onOtpChanged,
    required this.onOtpCompleted,
    required this.onContinue,
    required this.onResend,
    required this.onBack,
  });

  final String email;
  final String otp;
  final int cooldown;
  final bool resent;
  final bool canContinue;
  final bool canResend;
  final bool isResending;
  final PinTheme defaultTheme;
  final PinTheme focusedTheme;
  final PinTheme submittedTheme;
  final PinTheme completedTheme;
  final ValueChanged<String> onOtpChanged;
  final ValueChanged<String> onOtpCompleted;
  final VoidCallback onContinue;
  final VoidCallback onResend;
  final VoidCallback onBack;

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
      SizedBox(height: 8.h),

          // ── Back button ───────────
          AuthBackButton(onBack: onBack),

          SizedBox(height: 16.h),

          // ── Header ────────────────
        const   AuthHeader(
            overline: _overline,
            subtext: _subtext,
          ),

          SizedBox(height: 12.h),

          // ── Email chip ────────────
          EmailChip(email: email),

          SizedBox(height: 32.h),

          // ── OTP pin section ───────
          _OtpPinSection(
            cooldown: cooldown,
            resent: resent,
            canResend: canResend,
            isResending: isResending,
            defaultTheme: defaultTheme,
            focusedTheme: focusedTheme,
            submittedTheme: submittedTheme,
            completedTheme: completedTheme,
            onOtpChanged: onOtpChanged,
            onOtpCompleted: onOtpCompleted,
            onResend: onResend,
          ),

          SizedBox(height: 24.h),

          // ── CTA ───────────────────
          _OtpCTA(
            canContinue: canContinue,
            onContinue: onContinue,
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════
// OTP PIN SECTION
// Label + Pinput + resend
// ═════════════════════════════════

class _OtpPinSection extends StatelessWidget {
  const _OtpPinSection({
    required this.cooldown,
    required this.resent,
    required this.canResend,
    required this.isResending,
    required this.defaultTheme,
    required this.focusedTheme,
    required this.submittedTheme,
    required this.completedTheme,
    required this.onOtpChanged,
    required this.onOtpCompleted,
    required this.onResend,
  });

  final int cooldown;
  final bool resent;
  final bool canResend;
  final bool isResending;
  final PinTheme defaultTheme;
  final PinTheme focusedTheme;
  final PinTheme submittedTheme;
  final PinTheme completedTheme;
  final ValueChanged<String> onOtpChanged;
  final ValueChanged<String> onOtpCompleted;
  final VoidCallback onResend;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Text(
            _otpLabel,
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(
                alpha: 0.50,
              ),
              letterSpacing: 1.2,
            ),
          ),

          SizedBox(height: 16.h),

          // Pinput
          Center(
            child: Pinput(
              length: 6,
              autofocus: true,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              hapticFeedbackType:
                  HapticFeedbackType.lightImpact,
              closeKeyboardWhenCompleted: true,
              defaultPinTheme: defaultTheme,
              focusedPinTheme: focusedTheme,
              submittedPinTheme: submittedTheme,
              onChanged: onOtpChanged,
              onCompleted: onOtpCompleted,
            ),
          ),

          SizedBox(height: 16.h),

          // Resent confirmation
          if (resent) ...[
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: 12.r,
                ),
                SizedBox(width: 6.w),
                Text(
                  'Code resent successfully.',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
          ],

          // Resend button
          Center(
            child: GestureDetector(
              onTap: canResend ? onResend : null,
              child: Text(
                cooldown > 0
                    ? 'Resend in ${cooldown}s'
                    : isResending
                        ? 'Sending...'
                        : _resendLabel,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: canResend
                      ? AppColors.primary
                      : Colors.white.withValues(
                          alpha: 0.30,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════
// OTP CTA
// Glow button
// Disabled until 6 digits entered
// ═════════════════════════════════

class _OtpCTA extends StatelessWidget {
  const _OtpCTA({
    required this.canContinue,
    required this.onContinue,
  });

  final bool canContinue;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _ctaGlowDuration,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: canContinue
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(
                    alpha: 0.25,
                  ),
                  blurRadius: 16,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: AppButton(
        label: _ctaLabel,
        onTap: canContinue ? onContinue : null,
        isDisabled: !canContinue,
        type: AppButtonType.glow,
        glowIntensity: 1.0,
      ),
    );
  }
}