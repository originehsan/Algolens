import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/utils/validators.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/app_text_field.dart';
import 'package:algolens/core/widgets/auth_back_button.dart';
import 'package:algolens/core/widgets/auth_error.dart';
import 'package:algolens/core/widgets/auth_header.dart';
import 'package:algolens/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

// ═════════════════════════════════
// CONSTANTS
// File-level — only used here
// ═════════════════════════════════

// ── Strings ───────────────────────
const _overline = 'PASSWORD RESET';
const _subtext = 'No panic. Enter your email.';
const _ctaLabel = 'Send Reset Code';

// ── Field labels ──────────────────
const _labelEmail = 'EMAIL';
const _hintEmail = 'you@example.com';

// ── Durations ─────────────────────
const _ctaGlowDuration = Duration(milliseconds: 400);

// ── Auth field params ─────────────
const _authBorderRadius = 10.0;
const _authBorderWidth = 1.0;

// ═════════════════════════════════
// FORGOT PASSWORD SCREEN
// Public — entry point
// Handles: submit → navigate to OTP
// ═════════════════════════════════

class ForgotPasswordScreen
    extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends ConsumerState<ForgotPasswordScreen> {
  final _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  // ── Can submit ────────────────────

  bool get _canSubmit =>
      isValidEmail(_emailCtrl.text);

  // ── Submit ────────────────────────

  Future<void> _submit() async {
    if (!_canSubmit) return;
    await ref
        .read(forgotPasswordProvider.notifier)
        .forgotPassword(_emailCtrl.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final authState =
        ref.watch(forgotPasswordProvider);

    ref.listen(forgotPasswordProvider, (_, next) {
      if (next is AuthSuccess) {
        if (!mounted) return;
        context.pushNamed(
          RouteNames.otpVerification,
          extra: _emailCtrl.text.trim(),
        );
      }
    });

    final isLoading = authState is AuthLoading;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: _ForgotContent(
            emailCtrl: _emailCtrl,
            canSubmit: _canSubmit,
            isLoading: isLoading,
            authError: authState is AuthError
                ? authState.message
                : null,
            onSubmit: _submit,
            onBack: () => context.pop(),
            onFieldChanged: () => setState(() {}),
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════
// FORGOT CONTENT
// Pure layout — no logic
// ═════════════════════════════════

class _ForgotContent extends StatelessWidget {
  const _ForgotContent({
    required this.emailCtrl,
    required this.canSubmit,
    required this.isLoading,
    required this.authError,
    required this.onSubmit,
    required this.onBack,
    required this.onFieldChanged,
  });

  final TextEditingController emailCtrl;
  final bool canSubmit;
  final bool isLoading;
  final String? authError;
  final VoidCallback onSubmit;
  final VoidCallback onBack;
  final VoidCallback onFieldChanged;

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
          const AuthHeader(
            overline: _overline,
            subtext: _subtext,
          ),

          SizedBox(height: 32.h),

          // ── Form ──────────────────
          _ForgotForm(
            emailCtrl: emailCtrl,
            canSubmit: canSubmit,
            isLoading: isLoading,
            authError: authError,
            onSubmit: onSubmit,
            onFieldChanged: onFieldChanged,
          ),

          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}

// ═════════════════════════════════
// FORGOT FORM
// Glass container + email field + CTA
// ═════════════════════════════════

class _ForgotForm extends StatelessWidget {
  const _ForgotForm({
    required this.emailCtrl,
    required this.canSubmit,
    required this.isLoading,
    required this.authError,
    required this.onSubmit,
    required this.onFieldChanged,
  });

  final TextEditingController emailCtrl;
  final bool canSubmit;
  final bool isLoading;
  final String? authError;
  final VoidCallback onSubmit;
  final VoidCallback onFieldChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // ── Email field ──────────
          AppTextField(
            label: _labelEmail,
            hint: _hintEmail,
            controller: emailCtrl,
            prefixIcon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            autofillHints: const [
              AutofillHints.email,
            ],
            onChanged: (_) => onFieldChanged(),
            onSubmitted: (_) => onSubmit(),
            labelUppercase: true,
            customBorderRadius: _authBorderRadius,
            customBorderWidth: _authBorderWidth,
          ),

          // ── Auth error ───────────
          if (authError != null) ...[
            SizedBox(height: 12.h),
            AuthErrorWidget(message: authError!),
          ],

          SizedBox(height: 20.h),

          // ── CTA ──────────────────
          AnimatedContainer(
            duration: _ctaGlowDuration,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(14.r),
              boxShadow: canSubmit
                  ? [
                      BoxShadow(
                        color: AppColors.primary
                            .withValues(alpha: 0.25),
                        blurRadius: 16,
                        spreadRadius: 0,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: AppButton(
              label: _ctaLabel,
              onTap: canSubmit ? onSubmit : null,
              isLoading: isLoading,
              isDisabled: !canSubmit,
              type: AppButtonType.glow,
              glowIntensity: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}