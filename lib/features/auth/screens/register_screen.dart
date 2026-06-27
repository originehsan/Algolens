import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/utils/validators.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/app_text_field.dart';
import 'package:algolens/core/widgets/auth_divider.dart';
import 'package:algolens/core/widgets/auth_error.dart';
import 'package:algolens/core/widgets/auth_header.dart';
import 'package:algolens/core/widgets/password_strength.dart';
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
const _overline = 'CREATE MAGNUS ID';
const _ctaLabel = 'Create Account';
const _bottomPrompt = 'Already have an account?';
const _bottomAction = 'Sign In';
const _dividerLabel = 'ALREADY REGISTERED?';
const _discardTitle = 'Discard changes?';
const _discardBody =
    'You have unsaved information. '
    'Are you sure you want to leave?';
const _discardCancel = 'Stay';
const _discardConfirm = 'Discard';

// ── Field labels ──────────────────
const _labelName = 'NAME';
const _labelEmail = 'EMAIL';
const _labelPassword = 'PASSWORD';
const _labelConfirm = 'CONFIRM';

// ── Field hints ───────────────────
const _hintName = 'Your name';
const _hintEmail = 'you@example.com';
const _hintPassword = 'Min. 8 characters';
const _hintConfirm = 'Re-enter your password';

// ── Error messages ────────────────
const _errName = "Name can't be empty.";
const _errEmail = "That doesn't look like an email.";
const _errPassword = 'At least 8 characters.';
const _errMismatch = "These passwords don't match.";

// ── Durations ─────────────────────
const _cardGlowDuration = Duration(milliseconds: 200);
const _ctaGlowDuration = Duration(milliseconds: 400);

// ── Auth field params ─────────────
const _authBorderRadius = 10.0;
const _authBorderWidth = 1.0;

// ═════════════════════════════════
// REGISTER SCREEN
// Public — entry point
// Handles: form state + submission
// PopScope: discard dialog if dirty
// ═════════════════════════════════

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends ConsumerState<RegisterScreen> {
  // ── Controllers ───────────────────
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  // ── Focus nodes ───────────────────
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();
  final _confirmFocus = FocusNode();

  // ── Touched state ─────────────────
  bool _nameTouched = false;
  bool _emailTouched = false;
  bool _passTouched = false;
  bool _confirmTouched = false;

  @override
  void initState() {
    super.initState();
    _nameFocus.addListener(_onNameFocusChange);
    _emailFocus.addListener(_onEmailFocusChange);
    _passFocus.addListener(_onPassFocusChange);
    _confirmFocus.addListener(_onConfirmFocusChange);
  }

  void _onNameFocusChange() {
    if (!_nameFocus.hasFocus) {
      setState(() => _nameTouched = true);
    }
  }

  void _onEmailFocusChange() {
    if (!_emailFocus.hasFocus) {
      setState(() => _emailTouched = true);
    }
  }

  void _onPassFocusChange() {
    if (!_passFocus.hasFocus) {
      setState(() => _passTouched = true);
    }
  }

  void _onConfirmFocusChange() {
    if (!_confirmFocus.hasFocus) {
      setState(() => _confirmTouched = true);
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    _nameFocus.removeListener(_onNameFocusChange);
    _emailFocus.removeListener(_onEmailFocusChange);
    _passFocus.removeListener(_onPassFocusChange);
    _confirmFocus
        .removeListener(_onConfirmFocusChange);
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  // ── Form dirty check ──────────────

  bool get _isDirty =>
      _nameCtrl.text.isNotEmpty ||
      _emailCtrl.text.isNotEmpty ||
      _passCtrl.text.isNotEmpty ||
      _confirmCtrl.text.isNotEmpty;

  // ── Validation ────────────────────

  String? get _nameError {
    if (!_nameTouched) return null;
    if (_nameCtrl.text.trim().isEmpty) {
      return _errName;
    }
    return null;
  }

  String? get _emailError {
    if (!_emailTouched) return null;
    if (!isValidEmail(_emailCtrl.text)) {
      return _errEmail;
    }
    return null;
  }

  String? get _passError {
    if (!_passTouched) return null;
    if (_passCtrl.text.trim().length < 8) {
      return _errPassword;
    }
    return null;
  }

  String? get _confirmError {
    if (!_confirmTouched) return null;
    if (_confirmCtrl.text != _passCtrl.text) {
      return _errMismatch;
    }
    return null;
  }

  // ── Password strength ─────────────

  int get _strength =>
      passwordStrength(_passCtrl.text);

  // ── Email field state ─────────────

  AppTextFieldState get _emailFieldState {
    if (_emailError != null) {
      return AppTextFieldState.error;
    }
    if (_emailCtrl.text.trim().isNotEmpty &&
        _emailTouched) {
      return AppTextFieldState.success;
    }
    return AppTextFieldState.defaultState;
  }

  // ── Confirm field state ───────────

  AppTextFieldState get _confirmFieldState {
    if (_confirmCtrl.text.isEmpty) {
      return AppTextFieldState.defaultState;
    }
    return _confirmCtrl.text == _passCtrl.text
        ? AppTextFieldState.success
        : AppTextFieldState.error;
  }

  // ── Can submit ────────────────────

  bool get _canSubmit =>
      isValidName(_nameCtrl.text) &&
      isValidEmail(_emailCtrl.text) &&
      isValidPassword(_passCtrl.text) &&
      _confirmCtrl.text == _passCtrl.text;

  // ── Submit ────────────────────────

  Future<void> _submit() async {
    setState(() {
      _nameTouched = true;
      _emailTouched = true;
      _passTouched = true;
      _confirmTouched = true;
    });
    if (!_canSubmit) return;
    await ref
        .read(registerProvider.notifier)
        .register(
          RegisterRequest(
            name: _nameCtrl.text.trim(),
            email: _emailCtrl.text.trim(),
            password: _passCtrl.text.trim(),
          ),
        );
  }

  // ── Handle back ───────────────────

  Future<void> _onBack() async {
    if (!_isDirty) {
      context.pop();
      return;
    }
    final discard = await showDialog<bool>(
      context: context,
      builder: (_) => const _DiscardDialog(),
    );
    if (discard == true && mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(registerProvider);

    ref.listen(registerProvider, (_, next) {
      if (next is AuthSuccess) {
        if (!mounted) return;
        // pushNamed — user can go back
        // to fix email if needed
        context.pushNamed(
          RouteNames.emailVerification,
          extra: _emailCtrl.text.trim(),
        );
      }
    });

    final isLoading = authState is AuthLoading;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _onBack();
      },
      child: AppBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: _RegisterContent(
              nameCtrl: _nameCtrl,
              emailCtrl: _emailCtrl,
              passCtrl: _passCtrl,
              confirmCtrl: _confirmCtrl,
              nameFocus: _nameFocus,
              emailFocus: _emailFocus,
              passFocus: _passFocus,
              confirmFocus: _confirmFocus,
              nameError: _nameError,
              emailError: _emailError,
              passError: _passError,
              confirmError: _confirmError,
              emailFieldState: _emailFieldState,
              confirmFieldState: _confirmFieldState,
              strength: _strength,
              allValid: _canSubmit,
              canSubmit: _canSubmit,
              isLoading: isLoading,
              authError: authState is AuthError
                  ? authState.message
                  : null,
              onSubmit: _submit,
              onSignIn: () =>
                  context.goNamed(RouteNames.login),
              onFieldChanged: () => setState(() {}),
            ),
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════
// REGISTER CONTENT
// Pure layout — no logic
// ═════════════════════════════════

class _RegisterContent extends StatelessWidget {
  const _RegisterContent({
    required this.nameCtrl,
    required this.emailCtrl,
    required this.passCtrl,
    required this.confirmCtrl,
    required this.nameFocus,
    required this.emailFocus,
    required this.passFocus,
    required this.confirmFocus,
    required this.nameError,
    required this.emailError,
    required this.passError,
    required this.confirmError,
    required this.emailFieldState,
    required this.confirmFieldState,
    required this.strength,
    required this.allValid,
    required this.canSubmit,
    required this.isLoading,
    required this.authError,
    required this.onSubmit,
    required this.onSignIn,
    required this.onFieldChanged,
  });

  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;
  final TextEditingController confirmCtrl;
  final FocusNode nameFocus;
  final FocusNode emailFocus;
  final FocusNode passFocus;
  final FocusNode confirmFocus;
  final String? nameError;
  final String? emailError;
  final String? passError;
  final String? confirmError;
  final AppTextFieldState emailFieldState;
  final AppTextFieldState confirmFieldState;
  final int strength;
  final bool allValid;
  final bool canSubmit;
  final bool isLoading;
  final String? authError;
  final VoidCallback onSubmit;
  final VoidCallback onSignIn;
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
            logoSize: 64,
          ),

          SizedBox(height: 28.h),

          // ── Form ──────────────────
          _RegisterForm(
            nameCtrl: nameCtrl,
            emailCtrl: emailCtrl,
            passCtrl: passCtrl,
            confirmCtrl: confirmCtrl,
            nameFocus: nameFocus,
            emailFocus: emailFocus,
            passFocus: passFocus,
            confirmFocus: confirmFocus,
            nameError: nameError,
            emailError: emailError,
            passError: passError,
            confirmError: confirmError,
            emailFieldState: emailFieldState,
            confirmFieldState: confirmFieldState,
            strength: strength,
            allValid: allValid,
            authError: authError,
            onFieldChanged: onFieldChanged,
            onSubmit: onSubmit,
          ),

          SizedBox(height: 20.h),

          // ── CTA ───────────────────
          _RegisterCTA(
            canSubmit: canSubmit,
            isLoading: isLoading,
            onSubmit: onSubmit,
          ),

          SizedBox(height: 24.h),

          // ── Bottom ────────────────
          _RegisterBottom(onSignIn: onSignIn),

          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}

// ═════════════════════════════════
// REGISTER FORM
// Glass card + all fields
// Border glows when all valid
// AutofillGroup for OS autofill
// ═════════════════════════════════

class _RegisterForm extends StatelessWidget {
  const _RegisterForm({
    required this.nameCtrl,
    required this.emailCtrl,
    required this.passCtrl,
    required this.confirmCtrl,
    required this.nameFocus,
    required this.emailFocus,
    required this.passFocus,
    required this.confirmFocus,
    required this.nameError,
    required this.emailError,
    required this.passError,
    required this.confirmError,
    required this.emailFieldState,
    required this.confirmFieldState,
    required this.strength,
    required this.allValid,
    required this.authError,
    required this.onFieldChanged,
    required this.onSubmit,
  });

  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;
  final TextEditingController confirmCtrl;
  final FocusNode nameFocus;
  final FocusNode emailFocus;
  final FocusNode passFocus;
  final FocusNode confirmFocus;
  final String? nameError;
  final String? emailError;
  final String? passError;
  final String? confirmError;
  final AppTextFieldState emailFieldState;
  final AppTextFieldState confirmFieldState;
  final int strength;
  final bool allValid;
  final String? authError;
  final VoidCallback onFieldChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _cardGlowDuration,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: allValid
            ? [
                BoxShadow(
                  color: AppColors.primary
                      .withValues(alpha: 0.12),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ]
            : [],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(
            alpha: 0.04,
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: allValid
                ? AppColors.primary.withValues(
                    alpha: 0.30,
                  )
                : Colors.white.withValues(
                    alpha: 0.08,
                  ),
            width: 1,
          ),
        ),
        padding: EdgeInsets.all(20.r),
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              // ── Name ──────────────
              AppTextField(
                label: _labelName,
                hint: _hintName,
                controller: nameCtrl,
                focusNode: nameFocus,
                prefixIcon:
                    Icons.person_outline_rounded,
                textInputAction: TextInputAction.next,
                textCapitalization:
                    TextCapitalization.words,
                autofillHints: const [
                  AutofillHints.name,
                ],
                onChanged: (_) => onFieldChanged(),
                onSubmitted: (_) =>
                    emailFocus.requestFocus(),
                errorText: nameError,
                labelUppercase: true,
                customBorderRadius: _authBorderRadius,
                customBorderWidth: _authBorderWidth,
                fieldState: nameError != null
                    ? AppTextFieldState.error
                    : AppTextFieldState.defaultState,
              ),

              SizedBox(height: 16.h),

              // ── Email ──────────────
              AppTextField(
                label: _labelEmail,
                hint: _hintEmail,
                controller: emailCtrl,
                focusNode: emailFocus,
                prefixIcon: Icons.mail_outline_rounded,
                keyboardType:
                    TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [
                  AutofillHints.email,
                ],
                onChanged: (_) => onFieldChanged(),
                onSubmitted: (_) =>
                    passFocus.requestFocus(),
                errorText: emailError,
                labelUppercase: true,
                customBorderRadius: _authBorderRadius,
                customBorderWidth: _authBorderWidth,
                fieldState: emailFieldState,
              ),

              SizedBox(height: 16.h),

              // ── Password ──────────
              AppTextField(
                label: _labelPassword,
                hint: _hintPassword,
                controller: passCtrl,
                focusNode: passFocus,
                prefixIcon: Icons.lock_outline_rounded,
                isPassword: true,
                textInputAction: TextInputAction.next,
                autofillHints: const [
                  AutofillHints.newPassword,
                ],
                onChanged: (_) => onFieldChanged(),
                onSubmitted: (_) =>
                    confirmFocus.requestFocus(),
                errorText: passError,
                labelUppercase: true,
                customBorderRadius: _authBorderRadius,
                customBorderWidth: _authBorderWidth,
                fieldState: passError != null
                    ? AppTextFieldState.error
                    : AppTextFieldState.defaultState,
              ),

              // ── Strength bar ───────
              if (passCtrl.text.isNotEmpty) ...[
                SizedBox(height: 8.h),
                PasswordStrength(strength: strength),
              ],

              SizedBox(height: 16.h),

              // ── Confirm ────────────
              AppTextField(
                label: _labelConfirm,
                hint: _hintConfirm,
                controller: confirmCtrl,
                focusNode: confirmFocus,
                prefixIcon: Icons.lock_outline_rounded,
                isPassword: true,
                textInputAction: TextInputAction.done,
                autofillHints: const [
                  AutofillHints.newPassword,
                ],
                onChanged: (_) => onFieldChanged(),
                onSubmitted: (_) => onSubmit(),
                errorText: confirmError,
                labelUppercase: true,
                customBorderRadius: _authBorderRadius,
                customBorderWidth: _authBorderWidth,
                fieldState: confirmFieldState,
              ),

              // ── Auth error ─────────
              if (authError != null) ...[
                SizedBox(height: 12.h),
                AuthErrorWidget(message: authError!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════
// REGISTER CTA
// Glow button — disabled until valid
// ═════════════════════════════════

class _RegisterCTA extends StatelessWidget {
  const _RegisterCTA({
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
    );
  }
}

// ═════════════════════════════════
// REGISTER BOTTOM
// Divider + sign in link
// ═════════════════════════════════

class _RegisterBottom extends StatelessWidget {
  const _RegisterBottom({required this.onSignIn});

  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AuthDivider(label: _dividerLabel),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$_bottomPrompt ',
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(
                  alpha: 0.55,
                ),
              ),
            ),
            GestureDetector(
              onTap: onSignIn,
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
        ),
      ],
    );
  }
}

// ═════════════════════════════════
// DISCARD DIALOG
// Shown when back pressed with dirty form
// Private — only used by register screen
// ═════════════════════════════════

class _DiscardDialog extends StatelessWidget {
  const _DiscardDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF0F1E33),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(
          color: Colors.white.withValues(
            alpha: 0.10,
          ),
          width: 1,
        ),
      ),
      title: Text(
        _discardTitle,
        style: GoogleFonts.inter(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      content: Text(
        _discardBody,
        style: GoogleFonts.inter(
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
          color: Colors.white.withValues(
            alpha: 0.60,
          ),
        ),
      ),
      actions: [
        // Stay
        TextButton(
          onPressed: () =>
              Navigator.pop(context, false),
          child: Text(
            _discardCancel,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(
                alpha: 0.60,
              ),
            ),
          ),
        ),

        // Discard
        TextButton(
          onPressed: () =>
              Navigator.pop(context, true),
          child: Text(
            _discardConfirm,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.danger,
            ),
          ),
        ),
      ],
    );
  }
}