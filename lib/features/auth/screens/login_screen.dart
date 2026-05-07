import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/app_text_field.dart';
import 'package:algolens/core/widgets/auth_bottom_layout.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/features/auth/data/models/auth_request_model.dart';
import 'package:algolens/features/auth/providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  // Shows resend banner when
  // 403 email not verified
  bool _showResendBanner = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      _emailCtrl.text.trim().isNotEmpty && _passCtrl.text.trim().isNotEmpty;

  Future<void> _submit() async {
    if (!_canSubmit) return;
    setState(() {
      _showResendBanner = false;
    });
    await ref
        .read(
          loginProvider.notifier,
        )
        .login(
          LoginRequest(
            email: _emailCtrl.text.trim(),
            password: _passCtrl.text.trim(),
          ),
        );
  }

  Future<void> _resend() async {
    await ref
        .read(
          resendVerificationProvider.notifier,
        )
        .resendVerification(
          _emailCtrl.text.trim(),
        );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Verification email sent!',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(
      loginProvider,
    );

    // Navigate on success
    ref.listen(
      loginProvider,
      (_, next) {
        if (next is AuthSuccess) {
          final notifier = ref.read(
            loginProvider.notifier,
          );
          if (notifier.needsCfSetup) {
            context.goNamed(
              RouteNames.cfHandleSetup,
            );
          } else {
            context.goNamed(
              RouteNames.home,
            );
          }
        }

        // 403 email not verified
        if (next is AuthError && next.message.toLowerCase().contains('verif')) {
          setState(() {
            _showResendBanner = true;
          });
        }
      },
    );

    final isLoading = authState is AuthLoading;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 24.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),

                // Header
                Text(
                  'Welcome Back',
                  style: GoogleFonts.inter(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  'Sign in to continue your CP journey',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.55),
                  ),
                ),

                SizedBox(height: 32.h),

                // Email not verified banner
                if (_showResendBanner)
                  _ResendBanner(
                    onResend: _resend,
                  ),

                if (_showResendBanner) SizedBox(height: 16.h),

                GlassCard(
                  child: Column(
                    children: [
                      // Email
                      AppTextField(
                        label: 'Email Address',
                        hint: 'you@example.com',
                        controller: _emailCtrl,
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onChanged: (_) => setState(() {}),
                      ),

                      SizedBox(height: 16.h),

                      // Password
                      AppTextField(
                        label: 'Password',
                        hint: 'Your password',
                        controller: _passCtrl,
                        isPassword: true,
                        prefixIcon: Icons.lock_outline_rounded,
                        textInputAction: TextInputAction.done,
                        onChanged: (_) => setState(() {}),
                        onSubmitted: (_) => _submit(),
                      ),

                      SizedBox(height: 8.h),

                      // Forgot password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => context.goNamed(
                            RouteNames.forgotPassword,
                          ),
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 8.h),

                      // Error message
                      if (authState is AuthError && !_showResendBanner)
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: Text(
                            authState.message,
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: AppColors.danger,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      // Login button
                      AppButton(
                        label: 'Sign In',
                        onTap: _canSubmit ? _submit : null,
                        isLoading: isLoading,
                        isDisabled: !_canSubmit,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                Center(
                  child: AuthBottomLayout(
                    prompt: "Don't have an account?",
                    actionLabel: 'Register',
                    onAction: () => context.goNamed(
                      RouteNames.register,
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

// ─────────────────────────────────
// RESEND BANNER
// Shows when 403 email not verified
// ─────────────────────────────────

class _ResendBanner extends StatelessWidget {
  const _ResendBanner({
    required this.onResend,
  });

  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.35),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: AppColors.warning,
                size: 18.r,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Email not verified',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.warning,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            'Please verify your email before signing in.',
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.70),
            ),
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: onResend,
            child: Text(
              'Resend verification email',
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
