import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/app_text_field.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/features/auth/providers/auth_provider.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({
    super.key,
    required this.email,
  });

  final String email;

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState
    extends ConsumerState<ResetPasswordScreen> {
  final _newPassCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();

  String _otp = '';
  String? _passError;

  @override
  void dispose() {
    _newPassCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      _otp.length == 6 &&
      _newPassCtrl.text.trim().length >= 8 &&
      _newPassCtrl.text.trim() == _confirmPassCtrl.text.trim();

  Future<void> _submit() async {
    if (!_canSubmit) return;
    setState(() => _passError = null);
    await ref.read(resetPasswordProvider.notifier).resetPassword(
          otp: _otp,
          newPassword: _newPassCtrl.text.trim(),
        );
  }

  void _onConfirmChanged(String _) {
    setState(() {
      if (_confirmPassCtrl.text.trim().isNotEmpty &&
          _newPassCtrl.text.trim() != _confirmPassCtrl.text.trim()) {
        _passError = 'Passwords do not match';
      } else {
        _passError = null;
      }
    });
  }

  PinTheme get _defaultTheme => PinTheme(
        width: 48.r,
        height: 56.r,
        textStyle: GoogleFonts.jetBrainsMono(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.15),
            width: 1.5,
          ),
        ),
      );

  PinTheme get _focusedTheme => _defaultTheme.copyWith(
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.primary, width: 1.5),
        ),
      );

  PinTheme get _submittedTheme => _defaultTheme.copyWith(
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.60),
            width: 1.5,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(resetPasswordProvider);

    ref.listen(resetPasswordProvider, (_, next) {
      if (next is AuthSuccess) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Password reset successfully!',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: AppColors.success,
          ),
        );
        // Replace entire stack — can't go back to reset screen
        context.goNamed(RouteNames.login);
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
                // Back button — pops to forgot password
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
                  'Reset Password',
                  style: GoogleFonts.inter(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  'Enter the code sent to ${widget.email}',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.55),
                  ),
                ),

                SizedBox(height: 32.h),

                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reset Code',
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withValues(alpha: 0.70),
                        ),
                      ),

                      SizedBox(height: 12.h),

                      Center(
                        child: Pinput(
                          length: 6,
                          defaultPinTheme: _defaultTheme,
                          focusedPinTheme: _focusedTheme,
                          submittedPinTheme: _submittedTheme,
                          onChanged: (val) => setState(() => _otp = val),
                          onCompleted: (val) => setState(() => _otp = val),
                        ),
                      ),

                      SizedBox(height: 24.h),

                      AppTextField(
                        label: 'New Password',
                        hint: 'Min 8 characters',
                        controller: _newPassCtrl,
                        isPassword: true,
                        prefixIcon: Icons.lock_outline_rounded,
                        textInputAction: TextInputAction.next,
                        onChanged: (_) => setState(() {}),
                      ),

                      SizedBox(height: 16.h),

                      // Real-time mismatch error
                      AppTextField(
                        label: 'Confirm Password',
                        hint: 'Repeat password',
                        controller: _confirmPassCtrl,
                        isPassword: true,
                        prefixIcon: Icons.lock_outline_rounded,
                        textInputAction: TextInputAction.done,
                        fieldState: _passError != null
                            ? AppTextFieldState.error
                            : AppTextFieldState.defaultState,
                        errorText: _passError,
                        onChanged: _onConfirmChanged,
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
                        label: 'Reset Password',
                        onTap: _canSubmit ? _submit : null,
                        isLoading: isLoading,
                        isDisabled: !_canSubmit,
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