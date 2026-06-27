import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:google_fonts/google_fonts.dart';

// ═════════════════════════════════
// APP TEXT FIELD STATE
// ═════════════════════════════════

enum AppTextFieldState {
  defaultState,
  focused,
  error,
  success,
}

// ═════════════════════════════════
// APP TEXT FIELD
// Primary text input widget
//
// Features:
// → Animated glow on focus
// → 4 visual states
// → Password toggle
// → Prefix/suffix icons
// → Error message below
// → Hint text support
// → textCapitalization
// → autofillHints for OS autofill
// → Optional auth styling:
//   labelUppercase, customBorderRadius,
//   customBorderWidth
//
// Usage (standard):
// AppTextField(
//   label: 'Email',
//   hint: 'you@example.com',
//   controller: _emailCtrl,
// )
//
// Usage (auth screens):
// AppTextField(
//   label: 'EMAIL',
//   labelUppercase: true,
//   customBorderRadius: 10,
//   customBorderWidth: 1.0,
//   hint: 'you@example.com',
//   controller: _emailCtrl,
//   autofillHints: [AutofillHints.email],
// )
// ═════════════════════════════════

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.fieldState = AppTextFieldState.defaultState,
    this.errorText,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.readOnly = false,
    this.maxLines = 1,
    this.autofocus = false,
    // ── Auth optional params ──
    this.labelUppercase = false,
    this.customBorderRadius,
    this.customBorderWidth,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final AppTextFieldState fieldState;
  final String? errorText;
  final bool isPassword;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool readOnly;
  final int maxLines;
  final bool autofocus;

  // ── Auth optional params ────

  /// If true: label is uppercase +
  /// JetBrainsMono + letterSpacing 1.2
  /// Default: false (standard label)
  final bool labelUppercase;

  /// Override border radius
  /// Default: 12.r
  final double? customBorderRadius;

  /// Override border width
  /// Default: 1.5
  final double? customBorderWidth;

  /// Text capitalization behavior
  /// Default: TextCapitalization.none
  final TextCapitalization textCapitalization;

  /// Autofill hints for OS autofill
  /// e.g. [AutofillHints.email]
  final Iterable<String>? autofillHints;

  @override
  State<AppTextField> createState() =>
      _AppTextFieldState();
}

class _AppTextFieldState
    extends State<AppTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    if (!mounted) return;
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  // ── Resolved values ──────────

  double get _borderRadius =>
      widget.customBorderRadius ?? 12.r;

  double get _borderWidth =>
      widget.customBorderWidth ?? 1.5;

  // ── Border color ─────────────

  Color get _borderColor {
    return switch (widget.fieldState) {
      AppTextFieldState.error => AppColors.danger,
      AppTextFieldState.success => AppColors.success,
      _ => _isFocused
          ? AppColors.primary
          : Colors.white.withValues(alpha: 0.15),
    };
  }

  // ── Glow color ───────────────

  Color get _glowColor {
    return switch (widget.fieldState) {
      AppTextFieldState.error => AppColors.danger,
      AppTextFieldState.success => AppColors.success,
      _ => _isFocused
          ? AppColors.primary
          : Colors.transparent,
    };
  }

  // ── Label style ──────────────

  TextStyle get _labelStyle {
    if (widget.labelUppercase) {
      return GoogleFonts.inter(
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white.withValues(alpha: 0.50),
        letterSpacing: 1.2,
      );
    }
    return AppTextStyles.label.copyWith(
      color: Colors.white.withValues(alpha: 0.70),
    );
  }

  // ── Suffix widget ────────────

  Widget? get _suffixWidget {
    if (widget.isPassword) {
      return GestureDetector(
        onTap: () => setState(
          () => _obscureText = !_obscureText,
        ),
        child: Icon(
          _obscureText
              ? Icons.visibility_off
              : Icons.visibility,
          color: Colors.white.withValues(alpha: 0.50),
          size: 20.r,
        ),
      );
    }

    if (widget.suffixIcon != null) {
      return GestureDetector(
        onTap: widget.onSuffixTap,
        child: Icon(
          widget.suffixIcon,
          color: Colors.white.withValues(alpha: 0.50),
          size: 20.r,
        ),
      );
    }

    if (widget.fieldState ==
        AppTextFieldState.success) {
      return Icon(
        Icons.check_circle_rounded,
        color: AppColors.success,
        size: 20.r,
      );
    }

    if (widget.fieldState ==
        AppTextFieldState.error) {
      return Icon(
        Icons.cancel_rounded,
        color: AppColors.danger,
        size: 20.r,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Label ──────────────
        Text(
          widget.labelUppercase
              ? widget.label.toUpperCase()
              : widget.label,
          style: _labelStyle,
        ),

        SizedBox(height: 8.h),

        // ── Input field ─────────
        AnimatedContainer(
          duration: const Duration(
            milliseconds: 200,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              _borderRadius,
            ),
            border: Border.all(
              color: _borderColor,
              width: _borderWidth,
            ),
            boxShadow: [
              BoxShadow(
                color: _glowColor.withValues(
                  alpha: _isFocused ||
                          widget.fieldState !=
                              AppTextFieldState
                                  .defaultState
                      ? 0.25
                      : 0.0,
                ),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            obscureText: widget.isPassword
                ? _obscureText
                : false,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            readOnly: widget.readOnly,
            maxLines: widget.isPassword
                ? 1
                : widget.maxLines,
            autofocus: widget.autofocus,
            textCapitalization:
                widget.textCapitalization,
            autofillHints: widget.autofillHints,
            style: AppTextStyles.body.copyWith(
              color: Colors.white.withValues(
                alpha: 0.90,
              ),
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTextStyles.body.copyWith(
                color: Colors.white.withValues(
                  alpha: 0.35,
                ),
              ),
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      color: Colors.white.withValues(
                        alpha: 0.50,
                      ),
                      size: 20.r,
                    )
                  : null,
              suffixIcon: _suffixWidget,
              filled: true,
              fillColor: Colors.white.withValues(
                alpha: 0.05,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  _borderRadius,
                ),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  _borderRadius,
                ),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  _borderRadius,
                ),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // ── Error text ──────────
        if (widget.errorText != null &&
            widget.errorText!.isNotEmpty) ...[
          SizedBox(height: 6.h),
          Row(
            children: [
              Icon(
                Icons.info_rounded,
                color: AppColors.danger,
                size: 14.r,
              ),
              SizedBox(width: 4.w),
              Text(
                widget.errorText!,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.danger,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}