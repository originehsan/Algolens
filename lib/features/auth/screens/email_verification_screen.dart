import 'dart:async';
import 'package:algolens/core/widgets/auth_divider.dart';
import 'package:algolens/core/widgets/auth_header.dart';
import 'package:algolens/core/widgets/email_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/features/auth/providers/auth_provider.dart';

// ═════════════════════════════════
// CONSTANTS
// File-level — only used here
// ═════════════════════════════════

const _overline = 'VERIFY EMAIL';
const _subtext = 'Check your inbox.';
const _infoText = 'Click the link in the email to verify '
    'your account. Check spam if not received.';
const _resentText = 'Verification email sent!';
const _resendLabel = 'Resend Email';
const _signInLabel = 'Already verified? Sign In';
const _backLabel = 'Back to Register';
const _dividerLabel = 'OR';

// ── Status strip labels ───────────
const _statusLabels = ['SENT', 'OPENED', 'VERIFIED'];

// ── Cooldown ──────────────────────
const _cooldownSeconds = 60;

// ── Durations ─────────────────────
const _resendTimerInterval = Duration(seconds: 1);

// ═════════════════════════════════
// EMAIL VERIFICATION SCREEN
// Public — entry point
// Handles: resend + cooldown timer
// ═════════════════════════════════

class EmailVerificationScreen extends ConsumerStatefulWidget {
  const EmailVerificationScreen({
    super.key,
    required this.email,
  });

  final String email;

  @override
  ConsumerState<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends ConsumerState<EmailVerificationScreen> {
  int _cooldown = 0;
  Timer? _timer;
  bool _resent = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // ── Resend ────────────────────────

  Future<void> _resend() async {
    if (_cooldown > 0) return;
    await ref
        .read(resendVerificationProvider.notifier)
        .resendVerification(widget.email);
    if (!mounted) return;
    setState(() {
      _resent = true;
      _cooldown = _cooldownSeconds;
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

  @override
  Widget build(BuildContext context) {
    final resendState = ref.watch(resendVerificationProvider);
    final isLoading = resendState is AuthLoading;
    final canResend = _cooldown <= 0 && !isLoading;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: _VerificationContent(
            email: widget.email,
            cooldown: _cooldown,
            resent: _resent,
            isLoading: isLoading,
            canResend: canResend,
            onResend: _resend,
            onSignIn: () => context.goNamed(RouteNames.login),
            onBack: () => context.pop(),
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════
// VERIFICATION CONTENT
// Pure layout — no logic
// ═════════════════════════════════

class _VerificationContent extends StatelessWidget {
  const _VerificationContent({
    required this.email,
    required this.cooldown,
    required this.resent,
    required this.isLoading,
    required this.canResend,
    required this.onResend,
    required this.onSignIn,
    required this.onBack,
  });

  final String email;
  final int cooldown;
  final bool resent;
  final bool isLoading;
  final bool canResend;
  final VoidCallback onResend;
  final VoidCallback onSignIn;
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
          SizedBox(height: 16.h),

          // ── Hero ──────────────────
          const AuthHeader(
            overline: _overline,
            subtext: _subtext,
          ),
          SizedBox(height: 12.h),
          EmailChip(email: email),

          // ── Status strip ──────────
          const _StatusStrip(),

          SizedBox(height: 24.h),

          // ── Info card ─────────────
          _InfoCard(resent: resent),

          SizedBox(height: 32.h),

          // ── Resend button ─────────
          _ResendButton(
            cooldown: cooldown,
            isLoading: isLoading,
            canResend: canResend,
            onResend: onResend,
          ),

          SizedBox(height: 24.h),

          // ── Divider ───────────────
          const AuthDivider(label: _dividerLabel),

          SizedBox(height: 24.h),

          // ── Bottom actions ────────
          _BottomActions(
            onSignIn: onSignIn,
            onBack: onBack,
          ),

          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}

// ═════════════════════════════════
// STATUS STRIP
// SENT → OPENED → VERIFIED
// Static — SENT always active
// No endpoint to check status
// ═════════════════════════════════

class _StatusStrip extends StatelessWidget {
  const _StatusStrip();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _statusLabels.length,
        (i) {
          final isActive = i == 0;
          return Row(
            children: [
              Text(
                _statusLabels[i],
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: isActive
                      ? AppColors.primary
                      : Colors.white.withValues(
                          alpha: 0.20,
                        ),
                  letterSpacing: 1.5,
                ),
              ),
              if (i < _statusLabels.length - 1) ...[
                SizedBox(width: 8.w),
                Text(
                  '→',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 10.sp,
                    color: Colors.white.withValues(
                      alpha: 0.15,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
              ],
            ],
          );
        },
      ),
    );
  }
}

// ═════════════════════════════════
// INFO CARD
// GlassCard with info text
// Shows resent confirmation
// ═════════════════════════════════

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.resent});

  final bool resent;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: AppColors.primary,
                size: 16.r,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  _infoText,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(
                      alpha: 0.65,
                    ),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),

          // Resent confirmation
          if (resent) ...[
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: 14.r,
                ),
                SizedBox(width: 8.w),
                Text(
                  _resentText,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ═════════════════════════════════
// RESEND BUTTON
// Countdown label
// Disabled during cooldown
// ═════════════════════════════════

class _ResendButton extends StatelessWidget {
  const _ResendButton({
    required this.cooldown,
    required this.isLoading,
    required this.canResend,
    required this.onResend,
  });

  final int cooldown;
  final bool isLoading;
  final bool canResend;
  final VoidCallback onResend;

  String get _label => cooldown > 0 ? 'Resend in ${cooldown}s' : _resendLabel;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      label: _label,
      onTap: canResend ? onResend : null,
      isLoading: isLoading,
      isDisabled: !canResend,
      type: AppButtonType.glow,
      glowIntensity: 0.3,
    );
  }
}

// ═════════════════════════════════
// BOTTOM ACTIONS
// Sign in link + back link
// ═════════════════════════════════

class _BottomActions extends StatelessWidget {
  const _BottomActions({
    required this.onSignIn,
    required this.onBack,
  });

  final VoidCallback onSignIn;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Sign in link
        GestureDetector(
          onTap: onSignIn,
          child: Text(
            _signInLabel,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        SizedBox(height: 16.h),

        // Back to register
        GestureDetector(
          onTap: onBack,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back_rounded,
                size: 14.r,
                color: Colors.white.withValues(
                  alpha: 0.40,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                _backLabel,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withValues(
                    alpha: 0.40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
