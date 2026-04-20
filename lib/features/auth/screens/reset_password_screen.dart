import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/page_wrapper.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/app_text_field.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/features/auth/providers/auth_provider.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _otpController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _handleReset() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.resetPassword(
        otp: _otpController.text.trim(),
        newPassword: _passwordController.text,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Password reset successfully',
            ),
            backgroundColor: AppColors.success,
          ),
        );
        context.go('/login');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: 'Reset Password',
      showBackButton: true,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 32.h),
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Password',
                      style: AppTextStyles.h2,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Enter the OTP from your email',
                      style: AppTextStyles.body,
                    ),
                    SizedBox(height: 24.h),
                    AppTextField(
                      label: 'Enter OTP',
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.pin_outlined,
                    ),
                    SizedBox(height: 14.h),
                    AppTextField(
                      label: 'New Password',
                      controller: _passwordController,
                      isPassword: true,
                      prefixIcon: Icons.lock_outlined,
                    ),
                    SizedBox(height: 14.h),
                    AppTextField(
                      label: 'Confirm Password',
                      controller: _confirmController,
                      isPassword: true,
                      prefixIcon: Icons.lock_outlined,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              AppButton(
                label: 'Reset Password',
                onTap: _handleReset,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
