import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/utils/navigation_utils.dart';
import 'package:algolens/core/utils/validators.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/app_text_field.dart';
import 'package:algolens/core/widgets/auth_divider.dart';
import 'package:algolens/core/widgets/auth_error.dart';
import 'package:algolens/core/widgets/auth_header.dart';
import 'package:algolens/features/auth/data/models/auth_request_model.dart';
import 'package:algolens/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

// ═════════════════════════════════
// CONSTANTS
// File-level — only used here
// ═════════════════════════════════

// ── Strings ───────────────────────
const _overline = 'ACCESS YOUR MAGNUS ACCOUNT';
const _headline = 'Continue your climb.';
const _ctaLabel = 'Sign In';
const _forgotLabel = 'Forgot password?';
const _dividerLabel = 'NEW TO MAGNUS?';
const _bottomAction = 'Create account';

// ── Field labels ──────────────────
const _labelEmail = 'EMAIL';
const _labelPassword = 'PASSWORD';

// ── Field hints ───────────────────
const _hintEmail = 'you@example.com';
const _hintPassword = 'Your password';

// ── Banner strings ────────────────
const _bannerTitle = 'Email not verified.';
const _bannerBody =
    'Verify your inbox before signing in.';
const _bannerAction = 'Resend verification →';
const _bannerSending = 'Sending...';

// ── Durations ─────────────────────
const _ctaGlowDuration = Duration(milliseconds: 400);

// ── Auth field params ─────────────
const _authBorderRadius = 10.0;
const _authBorderWidth = 1.0;

// ═════════════════════════════════
// LOGIN SCREEN
// Public — entry point
// Handles: form state + submission
// + resend verification logic
// PopScope: double back to exit app
// ═════════════════════════════════

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends ConsumerState<LoginScreen> {
  // ── Controllers ───────────────────
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  // ── Focus nodes ───────────────────
  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();

  // ── State ─────────────────────────
  bool _showResendBanner = false;
  bool _isResending = false;
  bool _emailTouched = false;
  DateTime? _lastBackPress;

  @override
  void initState() {
    super.initState();
    _emailFocus.addListener(_onEmailFocusChange);
  }

  void _onEmailFocusChange() {
    if (!_emailFocus.hasFocus) {
      setState(() => _emailTouched = true);
    }
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _emailFocus.removeListener(_onEmailFocusChange);
    _emailFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  // ── Can submit ────────────────────

  bool get _canSubmit =>
      _emailCtrl.text.trim().isNotEmpty &&
      _passCtrl.text.trim().isNotEmpty;

  // ── Email field state ─────────────

  AppTextFieldState get _emailFieldState {
    if (!_emailTouched) {
      return AppTextFieldState.defaultState;
    }
    if (!isValidEmail(_emailCtrl.text)) {
      return AppTextFieldState.error;
    }
    return AppTextFieldState.defaultState;
  }

  // ── Submit ────────────────────────

  Future<void> _submit() async {
    if (!_canSubmit) return;
    setState(() => _showResendBanner = false);
    await ref.read(loginProvider.notifier).login(
          LoginRequest(
            email: _emailCtrl.text.trim(),
            password: _passCtrl.text.trim(),
          ),
        );
  }

  // ── Resend ────────────────────────

  Future<void> _resend() async {
    if (_isResending) return;
    setState(() => _isResending = true);
    await ref
        .read(resendVerificationProvider.notifier)
        .resendVerification(
          _emailCtrl.text.trim(),
        );
    if (!mounted) return;
    setState(() => _isResending = false);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(loginProvider);

    ref.listen(loginProvider, (_, next) {
      if (next is AuthSuccess) {
        if (!mounted) return;
        final notifier =
            ref.read(loginProvider.notifier);
        if (notifier.needsCfSetup) {
          context.goNamed(RouteNames.cfHandleSetup);
        } else {
          context.goNamed(RouteNames.home);
        }
      }
      if (next is AuthError &&
          next.message
              .toLowerCase()
              .contains('verif')) {
        if (!mounted) return;
        setState(() => _showResendBanner = true);
      }
    });

    final isLoading = authState is AuthLoading;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        handleDoubleBackExit(
          context: context,
          lastBackPress: _lastBackPress,
          onUpdate: (t) =>
              setState(() => _lastBackPress = t),
        );
      },
      child: AppBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: _LoginContent(
              emailCtrl: _emailCtrl,
              passCtrl: _passCtrl,
              emailFocus: _emailFocus,
              passFocus: _passFocus,
              emailFieldState: _emailFieldState,
              canSubmit: _canSubmit,
              isLoading: isLoading,
              showResendBanner: _showResendBanner,
              isResending: _isResending,
              authError: authState is AuthError &&
                      !_showResendBanner
                  ? authState.message
                  : null,
              onSubmit: _submit,
              onResend: _resend,
              onForgotPassword: () =>
                  context.pushNamed(
                RouteNames.forgotPassword,
              ),
              onRegister: () =>
                  context.goNamed(RouteNames.register),
              onFieldChanged: () => setState(() {}),
            ),
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════
// LOGIN CONTENT
// Pure layout — no logic
// ═════════════════════════════════

class _LoginContent extends StatelessWidget {
  const _LoginContent({
    required this.emailCtrl,
    required this.passCtrl,
    required this.emailFocus,
    required this.passFocus,
    required this.emailFieldState,
    required this.canSubmit,
    required this.isLoading,
    required this.showResendBanner,
    required this.isResending,
    required this.authError,
    required this.onSubmit,
    required this.onResend,
    required this.onForgotPassword,
    required this.onRegister,
    required this.onFieldChanged,
  });

  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;
  final FocusNode emailFocus;
  final FocusNode passFocus;
  final AppTextFieldState emailFieldState;
  final bool canSubmit;
  final bool isLoading;
  final bool showResendBanner;
  final bool isResending;
  final String? authError;
  final VoidCallback onSubmit;
  final VoidCallback onResend;
  final VoidCallback onForgotPassword;
  final VoidCallback onRegister;
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
          SizedBox(height: 16.h),

          // ── Header ────────────────
          const AuthHeader(
            overline: _overline,
            subtext: _headline,
          ),

          SizedBox(height: 28.h),

          // ── Resend banner ─────────
          if (showResendBanner) ...[
            _ResendBanner(
              onResend: onResend,
              isResending: isResending,
            ),
            SizedBox(height: 16.h),
          ],

          // ── Form ──────────────────
          _LoginForm(
            emailCtrl: emailCtrl,
            passCtrl: passCtrl,
            emailFocus: emailFocus,
            passFocus: passFocus,
            emailFieldState: emailFieldState,
            authError: authError,
            onFieldChanged: onFieldChanged,
            onSubmit: onSubmit,
            onForgotPassword: onForgotPassword,
            passHasContent: passCtrl.text.isNotEmpty,
          ),

          SizedBox(height: 20.h),

          // ── CTA ───────────────────
          _LoginCTA(
            canSubmit: canSubmit,
            isLoading: isLoading,
            onSubmit: onSubmit,
          ),

          SizedBox(height: 24.h),

          // ── Bottom ────────────────
          _LoginBottom(onRegister: onRegister),

          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}

// ═════════════════════════════════
// LOGIN FORM
// Glass container + fields
// + forgot password + auth error
// AutofillGroup for OS autofill
// ═════════════════════════════════

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    required this.emailCtrl,
    required this.passCtrl,
    required this.emailFocus,
    required this.passFocus,
    required this.emailFieldState,
    required this.authError,
    required this.onFieldChanged,
    required this.onSubmit,
    required this.onForgotPassword,
    required this.passHasContent,
  });

  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;
  final FocusNode emailFocus;
  final FocusNode passFocus;
  final AppTextFieldState emailFieldState;
  final String? authError;
  final VoidCallback onFieldChanged;
  final VoidCallback onSubmit;
  final VoidCallback onForgotPassword;
  final bool passHasContent;

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
      child: AutofillGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Email ──────────────
            AppTextField(
              label: _labelEmail,
              hint: _hintEmail,
              controller: emailCtrl,
              focusNode: emailFocus,
              prefixIcon: Icons.mail_outline_rounded,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [
                AutofillHints.email,
              ],
              onChanged: (_) => onFieldChanged(),
              onSubmitted: (_) =>
                  passFocus.requestFocus(),
              labelUppercase: true,
              customBorderRadius: _authBorderRadius,
              customBorderWidth: _authBorderWidth,
              fieldState: emailFieldState,
            ),

            SizedBox(height: 16.h),

            // ── Password ───────────
            AppTextField(
              label: _labelPassword,
              hint: _hintPassword,
              controller: passCtrl,
              focusNode: passFocus,
              prefixIcon: Icons.lock_outline_rounded,
              isPassword: true,
              textInputAction: TextInputAction.done,
              autofillHints: const [
                AutofillHints.password,
              ],
              onChanged: (_) => onFieldChanged(),
              onSubmitted: (_) => onSubmit(),
              labelUppercase: true,
              customBorderRadius: _authBorderRadius,
              customBorderWidth: _authBorderWidth,
            ),

            SizedBox(height: 8.h),

            // ── Forgot password ────
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: onForgotPassword,
                child: Text(
                  _forgotLabel,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: passHasContent
                        ? AppColors.primary
                        : Colors.white.withValues(
                            alpha: 0.30,
                          ),
                  ),
                ),
              ),
            ),

            // ── Auth error ─────────
            if (authError != null) ...[
              SizedBox(height: 12.h),
              AuthErrorWidget(message: authError!),
            ],
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════
// LOGIN CTA
// Glow button
// ═════════════════════════════════

class _LoginCTA extends StatelessWidget {
  const _LoginCTA({
    required this.canSubmit,
    required this.isLoading,
    required this.onSubmit,
  });

  final bool canSubmit;
  final bool isLoading;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _ctaGlowDuration,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: canSubmit
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
        onTap: canSubmit ? onSubmit : null,
        isLoading: isLoading,
        isDisabled: !canSubmit,
        type: AppButtonType.glow,
        glowIntensity: 1.0,
      ),
    );
  }
}

// ═════════════════════════════════
// LOGIN BOTTOM
// Divider + register link
// ═════════════════════════════════

class _LoginBottom extends StatelessWidget {
  const _LoginBottom({required this.onRegister});

  final VoidCallback onRegister;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AuthDivider(label: _dividerLabel),
        SizedBox(height: 16.h),
        GestureDetector(
          onTap: onRegister,
          child: Text(
            _bottomAction,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}

// ═════════════════════════════════
// RESEND BANNER
// Email not verified warning
// Slides in on verification error
// ═════════════════════════════════

class _ResendBanner extends StatelessWidget {
  const _ResendBanner({
    required this.onResend,
    required this.isResending,
  });

  final VoidCallback onResend;
  final bool isResending;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(
          alpha: 0.12,
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.warning.withValues(
            alpha: 0.35,
          ),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: AppColors.warning,
                size: 16.r,
              ),
              SizedBox(width: 8.w),
              Text(
                _bannerTitle,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.warning,
                ),
              ),
            ],
          ),

          SizedBox(height: 6.h),

          // Body
          Text(
            _bannerBody,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(
                alpha: 0.65,
              ),
            ),
          ),

          SizedBox(height: 10.h),

          // Resend action
          GestureDetector(
            onTap: isResending ? null : onResend,
            child: Text(
              isResending
                  ? _bannerSending
                  : _bannerAction,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: isResending
                    ? Colors.white.withValues(
                        alpha: 0.40,
                      )
                    : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}