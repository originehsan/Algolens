import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/utils/validators.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/app_text_field.dart';
import 'package:algolens/core/widgets/auth_back_button.dart';
import 'package:algolens/core/widgets/auth_error.dart';
import 'package:algolens/core/widgets/auth_header.dart';
import 'package:algolens/core/widgets/email_chip.dart';
import 'package:algolens/core/widgets/password_strength.dart';
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
const _overline = 'CONFIRM RESET';
const _headline = 'Set a new password.';
const _labelNewPass = 'NEW PASSWORD';
const _labelConfirm = 'CONFIRM PASSWORD';
const _hintNewPass = 'Min. 8 characters';
const _hintConfirm = 'Re-enter password';
const _ctaLabel = 'Reset Password';
const _successMsg = 'Password reset successfully!';

// ── Error messages ────────────────
const _errMismatch = "Passwords don't match.";

// ── Durations ─────────────────────
const _ctaGlowDuration = Duration(milliseconds: 400);

// ── Auth field params ─────────────
const _authBorderRadius = 10.0;
const _authBorderWidth = 1.0;

// ═════════════════════════════════
// RESET PASSWORD SCREEN
// Public — entry point
// Receives email + otp from otp_screen
// Handles: new password + submit
// ═════════════════════════════════

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  final String email;
  final String otp;

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  // ── Controllers ───────────────────
  final _newPassCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  // ── Focus nodes ───────────────────
  final _newPassFocus = FocusNode();
  final _confirmFocus = FocusNode();

  // ── Touched state ─────────────────
  bool _newPassTouched = false;
  bool _confirmTouched = false;

  @override
  void initState() {
    super.initState();
    _newPassFocus.addListener(_onNewPassFocusChange);
    _confirmFocus.addListener(_onConfirmFocusChange);
  }

  void _onNewPassFocusChange() {
    if (!_newPassFocus.hasFocus) {
      setState(() => _newPassTouched = true);
    }
  }

  void _onConfirmFocusChange() {
    if (!_confirmFocus.hasFocus) {
      setState(() => _confirmTouched = true);
    }
  }

  @override
  void dispose() {
    _newPassCtrl.dispose();
    _confirmCtrl.dispose();
    _newPassFocus.removeListener(_onNewPassFocusChange);
    _confirmFocus.removeListener(_onConfirmFocusChange);
    _newPassFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  // ── Validation ────────────────────

  String? get _newPassError {
    if (!_newPassTouched) return null;
    if (!isValidPassword(_newPassCtrl.text)) {
      return 'At least 8 characters.';
    }
    return null;
  }

  String? get _confirmError {
    if (!_confirmTouched) return null;
    if (_confirmCtrl.text != _newPassCtrl.text) {
      return _errMismatch;
    }
    return null;
  }

  // ── Password strength ─────────────

  int get _strength => passwordStrength(_newPassCtrl.text);

  // ── Confirm field state ───────────

  AppTextFieldState get _confirmFieldState {
    if (_confirmCtrl.text.isEmpty) {
      return AppTextFieldState.defaultState;
    }
    return _confirmCtrl.text == _newPassCtrl.text
        ? AppTextFieldState.success
        : AppTextFieldState.error;
  }

  // ── Can submit ────────────────────

  bool get _canSubmit =>
      isValidPassword(_newPassCtrl.text) &&
      _confirmCtrl.text == _newPassCtrl.text;

  // ── Submit ────────────────────────

  Future<void> _submit() async {
    if (!_canSubmit) return;
    await ref.read(resetPasswordProvider.notifier).resetPassword(
          otp: widget.otp,
          newPassword: _newPassCtrl.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(resetPasswordProvider);

    ref.listen(resetPasswordProvider, (_, next) {
      if (next is AuthSuccess) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _successMsg,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: AppColors.success,
          ),
        );
        context.goNamed(RouteNames.login);
      }
    });

    final isLoading = authState is AuthLoading;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: _ResetContent(
            email: widget.email,
            newPassCtrl: _newPassCtrl,
            confirmCtrl: _confirmCtrl,
            newPassFocus: _newPassFocus,
            confirmFocus: _confirmFocus,
            newPassError: _newPassError,
            confirmError: _confirmError,
            confirmFieldState: _confirmFieldState,
            strength: _strength,
            canSubmit: _canSubmit,
            isLoading: isLoading,
            authError: authState is AuthError ? authState.message : null,
            onSubmit: _submit,
            onBack: () => context.pop(),
            onRequestNewCode: () => context.goNamed(RouteNames.forgotPassword),
            onFieldChanged: () => setState(() {}),
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════
// RESET CONTENT
// Pure layout — no logic
// ═════════════════════════════════

class _ResetContent extends StatelessWidget {
  const _ResetContent({
    required this.email,
    required this.newPassCtrl,
    required this.confirmCtrl,
    required this.newPassFocus,
    required this.confirmFocus,
    required this.newPassError,
    required this.confirmError,
    required this.confirmFieldState,
    required this.strength,
    required this.canSubmit,
    required this.isLoading,
    required this.authError,
    required this.onSubmit,
    required this.onBack,
    required this.onFieldChanged,
    required this.onRequestNewCode,
  });

  final String email;
  final TextEditingController newPassCtrl;
  final TextEditingController confirmCtrl;
  final FocusNode newPassFocus;
  final FocusNode confirmFocus;
  final String? newPassError;
  final String? confirmError;
  final AppTextFieldState confirmFieldState;
  final int strength;
  final bool canSubmit;
  final bool isLoading;
  final String? authError;
  final VoidCallback onSubmit;
  final VoidCallback onBack;
  final VoidCallback onFieldChanged;
  final VoidCallback onRequestNewCode;

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
            subtext: _headline,
          ),

          SizedBox(height: 12.h),

          // ── Email chip ────────────
          EmailChip(email: email),

          SizedBox(height: 32.h),

          // ── Password section ──────
          _PasswordSection(
            newPassCtrl: newPassCtrl,
            confirmCtrl: confirmCtrl,
            newPassFocus: newPassFocus,
            confirmFocus: confirmFocus,
            newPassError: newPassError,
            confirmError: confirmError,
            confirmFieldState: confirmFieldState,
            strength: strength,
            onFieldChanged: onFieldChanged,
            onSubmit: onSubmit,
          ),

          SizedBox(height: 20.h),

          // ── CTA ───────────────────
          _ResetCTA(
            canSubmit: canSubmit,
            isLoading: isLoading,
            authError: authError,
            onSubmit: onSubmit,
            onRequestNewCode: onRequestNewCode,
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}

// ═════════════════════════════════
// PASSWORD SECTION
// New password + strength
// + confirm + match indicator
// ═════════════════════════════════

class _PasswordSection extends StatelessWidget {
  const _PasswordSection({
    required this.newPassCtrl,
    required this.confirmCtrl,
    required this.newPassFocus,
    required this.confirmFocus,
    required this.newPassError,
    required this.confirmError,
    required this.confirmFieldState,
    required this.strength,
    required this.onFieldChanged,
    required this.onSubmit,
  });

  final TextEditingController newPassCtrl;
  final TextEditingController confirmCtrl;
  final FocusNode newPassFocus;
  final FocusNode confirmFocus;
  final String? newPassError;
  final String? confirmError;
  final AppTextFieldState confirmFieldState;
  final int strength;
  final VoidCallback onFieldChanged;
  final VoidCallback onSubmit;

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
          // New password
          AppTextField(
            label: _labelNewPass,
            hint: _hintNewPass,
            controller: newPassCtrl,
            focusNode: newPassFocus,
            prefixIcon: Icons.lock_outline_rounded,
            isPassword: true,
            textInputAction: TextInputAction.next,
            onChanged: (_) => onFieldChanged(),
            onSubmitted: (_) => confirmFocus.requestFocus(),
            errorText: newPassError,
            labelUppercase: true,
            customBorderRadius: _authBorderRadius,
            customBorderWidth: _authBorderWidth,
            fieldState: newPassError != null
                ? AppTextFieldState.error
                : AppTextFieldState.defaultState,
          ),

          // Strength bar
          if (newPassCtrl.text.isNotEmpty) ...[
            SizedBox(height: 8.h),
            PasswordStrength(strength: strength),
          ],

          SizedBox(height: 16.h),

          // Confirm password
          AppTextField(
            label: _labelConfirm,
            hint: _hintConfirm,
            controller: confirmCtrl,
            focusNode: confirmFocus,
            prefixIcon: Icons.lock_outline_rounded,
            isPassword: true,
            textInputAction: TextInputAction.done,
            onChanged: (_) => onFieldChanged(),
            onSubmitted: (_) => onSubmit(),
            errorText: confirmError,
            labelUppercase: true,
            customBorderRadius: _authBorderRadius,
            customBorderWidth: _authBorderWidth,
            fieldState: confirmFieldState,
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════
// RESET CTA
// Glow button + auth error
// ═════════════════════════════════

class _ResetCTA extends StatelessWidget {
  const _ResetCTA({
    required this.canSubmit,
    required this.isLoading,
    required this.authError,
    required this.onSubmit,
    required this.onRequestNewCode,
  });

  final bool canSubmit;
  final bool isLoading;
  final String? authError;
  final VoidCallback onSubmit;
  final VoidCallback onRequestNewCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (authError != null) ...[
          AuthErrorWidget(message: authError!),
          if (authError!.toLowerCase().contains('expired') ||
              authError!.toLowerCase().contains('invalid')) ...[
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: onRequestNewCode,
              child: Text(
                'Request new code',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          SizedBox(height: 12.h),
        ],
        AnimatedContainer(
          duration: _ctaGlowDuration,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: canSubmit
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.25),
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
    );
  }
}
