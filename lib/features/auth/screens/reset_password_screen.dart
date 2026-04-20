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
                      hint: 'Enter OTP',
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(
                        Icons.pin_outlined,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'OTP is required';
                        }
                        if (value.length != 6) {
                          return 'OTP must be 6 digits';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 14.h),
                    AppTextField(
                      hint: 'New Password',
                      controller: _passwordController,
                      isPassword: true,
                      prefixIcon: const Icon(
                        Icons.lock_outlined,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 8) {
                          return 'Minimum 8 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 14.h),
                    AppTextField(
                      hint: 'Confirm Password',
                      controller: _confirmController,
                      isPassword: true,
                      prefixIcon: const Icon(
                        Icons.lock_outlined,
                      ),
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              AppButton(
                label: 'Reset Password',
                onPressed: _handleReset,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
