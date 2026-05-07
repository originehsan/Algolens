import 'dart:async';
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

// ─────────────────────────────────
// EMAIL VERIFICATION SCREEN
// ─────────────────────────────────

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

  // ───────────────────────────────
  // RESEND
  // 60s cooldown timer
  // ───────────────────────────────

  Future<void> _resend() async {
    if (_cooldown > 0) return;

    await ref
        .read(
          resendVerificationProvider.notifier,
        )
        .resendVerification(
          widget.email,
        );

    if (!mounted) return;

    setState(() {
      _resent = true;
      _cooldown = 60;
    });

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (t) {
        if (!mounted) {
          t.cancel();
          return;
        }
        setState(() {
          _cooldown--;
        });
        if (_cooldown <= 0) {
          t.cancel();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final resendState = ref.watch(
      resendVerificationProvider,
    );
    final isLoading = resendState is AuthLoading;
    final canResend = _cooldown <= 0 && !isLoading;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Column(
              children: [
                SizedBox(height: 60.h),

                // Email icon
                Container(
                  width: 100.r,
                  height: 100.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withValues(
                      alpha: 0.12,
                    ),
                    border: Border.all(
                      color: AppColors.primary.withValues(
                        alpha: 0.35,
                      ),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    Icons.mark_email_unread_rounded,
                    color: AppColors.primary,
                    size: 48.r,
                  ),
                ),

                SizedBox(height: 32.h),

                // Title
                Text(
                  'Check your email',
                  style: GoogleFonts.inter(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 12.h),

                // Subtitle
                Text(
                  'We sent a verification '
                  'link to\n${widget.email}',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(
                      alpha: 0.60,
                    ),
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 40.h),

                // Info card
                GlassCard(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: AppColors.primary,
                            size: 18.r,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Text(
                              'Click the link in '
                              'the email to verify '
                              'your account. '
                              'Check spam if '
                              'not received.',
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withValues(
                                  alpha: 0.70,
                                ),
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (_resent) ...[
                        SizedBox(
                          height: 12.h,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              color: AppColors.success,
                              size: 16.r,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              'Verification '
                              'email sent!',
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // Resend button
                AppButton(
                  label: _cooldown > 0
                      ? 'Resend in '
                          '${_cooldown}s'
                      : 'Resend Email',
                  onTap: canResend ? _resend : null,
                  isLoading: isLoading,
                  isDisabled: !canResend,
                  type: AppButtonType.outline,
                ),

                SizedBox(height: 16.h),

                // Already verified link
                GestureDetector(
                  onTap: () => context.goNamed(
                    RouteNames.login,
                  ),
                  child: Text(
                    'Already verified? '
                    'Sign In',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primary,
                    ),
                  ),
                ),

                const Spacer(),

                // Back button
                TextButton.icon(
                  onPressed: () => context.goNamed(
                    RouteNames.register,
                  ),
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    size: 16.r,
                    color: Colors.white.withValues(
                      alpha: 0.50,
                    ),
                  ),
                  label: Text(
                    'Back to Register',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(
                        alpha: 0.50,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
