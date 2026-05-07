import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/app_text_field.dart';
import 'package:algolens/core/widgets/auth_bottom_layout.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/features/auth/data/models/auth_request_model.dart';
import 'package:algolens/features/auth/providers/auth_provider.dart';

// ─────────────────────────────────
// CF HANDLE VERIFY STATE
// ─────────────────────────────────

enum _CfState {
  idle,
  verifying,
  verified,
  error,
}

// ─────────────────────────────────
// REGISTER SCREEN
// ─────────────────────────────────

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _handleCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  _CfState _cfState = _CfState.idle;
  String? _cfError;
  Timer? _debounce;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _handleCtrl.dispose();
    _passCtrl.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // ───────────────────────────────
  // CF HANDLE VERIFICATION
  // 800ms debounce
  // GET /users/{handle}/profile
  // ───────────────────────────────

  void _onHandleChanged(String val) {
    _debounce?.cancel();
    if (val.trim().isEmpty) {
      setState(() {
        _cfState = _CfState.idle;
        _cfError = null;
      });
      return;
    }
    _debounce = Timer(
      const Duration(milliseconds: 800),
      () => _verifyCfHandle(val.trim()),
    );
  }

  Future<void> _verifyCfHandle(String handle) async {
    setState(() {
      _cfState = _CfState.verifying;
      _cfError = null;
    });
    try {
      final client = ref.read(
        dioClientProvider,
      );
      await client.get(
        ApiEndpoints.profile(handle),
      );
      if (!mounted) return;
      setState(() {
        _cfState = _CfState.verified;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '$handle verified ✓',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 2),
        ),
      );
    } on ApiException {
      if (!mounted) return;
      setState(() {
        _cfState = _CfState.error;
        _cfError = 'Handle not found';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'CF handle not found',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: AppColors.danger,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  // ───────────────────────────────
  // SUBMIT
  // ───────────────────────────────

  bool get _canSubmit =>
      _nameCtrl.text.trim().isNotEmpty &&
      _emailCtrl.text.trim().isNotEmpty &&
      _handleCtrl.text.trim().isNotEmpty &&
      _passCtrl.text.trim().isNotEmpty &&
      _cfState == _CfState.verified;

  Future<void> _submit() async {
    if (!_canSubmit) return;
    await ref
        .read(
          registerProvider.notifier,
        )
        .register(
          RegisterRequest(
            name: _nameCtrl.text.trim(),
            email: _emailCtrl.text.trim(),
            password: _passCtrl.text.trim(),
            cfHandle: _handleCtrl.text.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(
      registerProvider,
    );

    // Navigate on success
    ref.listen(
      registerProvider,
      (_, next) {
        if (next is AuthSuccess) {
          context.goNamed(
            RouteNames.emailVerification,
          );
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
                SizedBox(height: 20.h),

                // Header
                Text(
                  'Create Account',
                  style: GoogleFonts.inter(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  'Join AlgoLens and level up your CP game',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(
                      alpha: 0.55,
                    ),
                  ),
                ),

                SizedBox(height: 32.h),

                GlassCard(
                  child: Column(
                    children: [
                      // Full Name
                      AppTextField(
                        label: 'Full Name',
                        hint: 'John Doe',
                        controller: _nameCtrl,
                        prefixIcon: Icons.person_outline_rounded,
                        textInputAction: TextInputAction.next,
                      ),

                      SizedBox(height: 16.h),

                      // Email
                      AppTextField(
                        label: 'Email Address',
                        hint: 'you@example.com',
                        controller: _emailCtrl,
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),

                      SizedBox(height: 16.h),

                      // CF Handle
                      AppTextField(
                        label: 'Codeforces Handle',
                        hint: 'tourist',
                        controller: _handleCtrl,
                        prefixIcon: Icons.code_rounded,
                        textInputAction: TextInputAction.next,
                        onChanged: _onHandleChanged,
                        fieldState: _cfState == _CfState.verified
                            ? AppTextFieldState.success
                            : _cfState == _CfState.error
                                ? AppTextFieldState.error
                                : AppTextFieldState.defaultState,
                        errorText: _cfError,
                        suffixIcon: _cfState == _CfState.verifying
                            ? Icons.hourglass_empty_rounded
                            : null,
                      ),

                      SizedBox(height: 16.h),

                      // Password
                      AppTextField(
                        label: 'Password',
                        hint: 'Min 8 characters',
                        controller: _passCtrl,
                        isPassword: true,
                        prefixIcon: Icons.lock_outline_rounded,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _submit(),
                      ),

                      SizedBox(height: 24.h),

                      // Error message
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

                      // Submit button
                      AppButton(
                        label: 'Create Account',
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
                    prompt: 'Already have an account?',
                    actionLabel: 'Sign In',
                    onAction: () => context.goNamed(
                      RouteNames.login,
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
