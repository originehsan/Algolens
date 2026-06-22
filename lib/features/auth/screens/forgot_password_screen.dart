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
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/features/auth/providers/auth_provider.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends ConsumerState<ForgotPasswordScreen> {
  final _emailCtrl = TextEditingController();
  bool _emailSent = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  bool get _canSubmit => _emailCtrl.text.trim().isNotEmpty;

  Future<void> _submit() async {
    if (!_canSubmit) return;
    await ref
        .read(forgotPasswordProvider.notifier)
        .forgotPassword(_emailCtrl.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(forgotPasswordProvider);

    ref.listen(forgotPasswordProvider, (_, next) {
      if (next is AuthSuccess) {
        if (!mounted) return;
        setState(() => _emailSent = true);
      }
    });

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
                // Back button — pops back to login
                IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white.withValues(alpha: 0.70),
                    size: 24.r,
                  ),
                  padding: EdgeInsets.zero,
                ),

                SizedBox(height: 16.h),

                Text(
                  'Forgot Password?',
                  style: GoogleFonts.inter(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  _emailSent
                      ? 'We sent a reset code to your email'
                      : 'Enter your email and we\'ll send you a reset code',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.55),
                  ),
                ),

                SizedBox(height: 32.h),

                if (!_emailSent)
                  GlassCard(
                    child: Column(
                      children: [
                        AppTextField(
                          label: 'Email Address',
                          hint: 'you@example.com',
                          controller: _emailCtrl,
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          onChanged: (_) => setState(() {}),
                          onSubmitted: (_) => _submit(),
                        ),
                        SizedBox(height: 24.h),
                        if (authState is AuthError)
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
                        AppButton(
                          label: 'Send Reset Code',
                          onTap: _canSubmit ? _submit : null,
                          isLoading: isLoading,
                          isDisabled: !_canSubmit,
                        ),
                      ],
                    ),
                  ),

                if (_emailSent)
                  GlassCard(
                    type: GlassCardType.success,
                    child: Column(
                      children: [
                        Icon(
                          Icons.mark_email_read_rounded,
                          color: AppColors.success,
                          size: 48.r,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Reset code sent!',
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.success,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Check your email at\n${_emailCtrl.text.trim()}',
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withValues(alpha: 0.65),
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 24.h),
                        // Push so user can go back if needed
                        AppButton(
                          label: 'Enter Reset Code',
                          onTap: () => context.pushNamed(
                            RouteNames.resetPassword,
                            extra: _emailCtrl.text.trim(),
                          ),
                        ),
                      ],
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