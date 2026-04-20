import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';

// ──────────────────────────────
// APP TEXT FIELD STATE
// Controls visual appearance
// ──────────────────────────────

/// Text field visual state
///
/// defaultState → no interaction
/// focused      → user typing
/// error        → validation fail
/// success      → validation pass
enum AppTextFieldState {
  defaultState,
  focused,
  error,
  success,
}

// ──────────────────────────────
// APP TEXT FIELD
// ──────────────────────────────

/// Primary text input widget
///
/// Features:
/// → Animated glow on focus
/// → 4 visual states
/// → Password toggle
/// → Prefix/suffix icons
/// → Error message below
/// → Hint text support
///
/// Usage:
/// AppTextField(
///   label: 'Email',
///   hint: 'you@example.com',
///   controller: _emailCtrl,
///   prefixIcon: CupertinoIcons.mail,
///   keyboardType:
///     TextInputType.emailAddress,
///   onChanged: (v) => ...,
/// )
///
/// AppTextField(
///   label: 'Password',
///   isPassword: true,
///   controller: _passCtrl,
///   fieldState:
///     AppTextFieldState.error,
///   errorText: 'Too short',
/// )
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

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(
      _onFocusChange,
    );
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

  // ────────────────────────────
  // BORDER COLOR
  // Based on state + focus
  // ────────────────────────────

  Color get _borderColor {
    return switch (widget.fieldState) {
      AppTextFieldState.error => AppColors.danger,
      AppTextFieldState.success => AppColors.success,
      _ => _isFocused
          ? AppColors.primary
          : Colors.white.withValues(
              alpha: 0.15,
            ),
    };
  }

  // ────────────────────────────
  // GLOW COLOR
  // Only on focused/error/success
  // ────────────────────────────

  Color get _glowColor {
    return switch (widget.fieldState) {
      AppTextFieldState.error => AppColors.danger,
      AppTextFieldState.success => AppColors.success,
      _ => _isFocused ? AppColors.primary : Colors.transparent,
    };
  }

  // ────────────────────────────
  // SUFFIX ICON
  // Password toggle or custom
  // ────────────────────────────

  Widget? get _suffixWidget {
    if (widget.isPassword) {
      return GestureDetector(
        onTap: () => setState(() {
          _obscureText = !_obscureText;
        }),
        child: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
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

    /// Success state checkmark
    if (widget.fieldState == AppTextFieldState.success) {
      return Icon(
        Icons.check_circle_rounded,
        color: AppColors.success,
        size: 20.r,
      );
    }

    /// Error state X icon
    if (widget.fieldState == AppTextFieldState.error) {
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
        // ──────────────────────
        // LABEL
        // ──────────────────────

        Text(
          widget.label,
          style: AppTextStyles.label.copyWith(
            color: Colors.white.withValues(alpha: 0.70),
          ),
        ),

        SizedBox(height: 8.h),

        // ──────────────────────
        // INPUT FIELD
        // Animated glow border
        // ──────────────────────

        AnimatedContainer(
          duration: const Duration(
            milliseconds: 200,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              12.r,
            ),
            border: Border.all(
              color: _borderColor,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _glowColor.withValues(
                  alpha: _isFocused ||
                          widget.fieldState != AppTextFieldState.defaultState
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
            obscureText: widget.isPassword ? _obscureText : false,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            readOnly: widget.readOnly,
            maxLines: widget.isPassword ? 1 : widget.maxLines,
            autofocus: widget.autofocus,
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
                  12.r,
                ),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // ──────────────────────
        // ERROR TEXT
        // Shows below field
        // ──────────────────────

        if (widget.errorText != null && widget.errorText!.isNotEmpty) ...[
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
