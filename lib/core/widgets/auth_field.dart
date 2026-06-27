import 'package:algolens/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthField extends StatefulWidget {
  const AuthField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.focusNode,
    required this.prefixIcon,
    required this.textInputAction,
    required this.onChanged,
    required this.onSubmitted,
    this.keyboardType,
    this.isPassword = false,
    this.errorText,
    this.suffixIcon,
    this.suffixColor,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final FocusNode focusNode;
  final IconData prefixIcon;
  final TextInputAction textInputAction;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? errorText;
  final IconData? suffixIcon;
  final Color? suffixColor;

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool _obscure = true;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (mounted) {
      setState(() => _focused = widget.focusNode.hasFocus);
    }
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Terminal label ──────────
        Text(
          widget.label,
          style: GoogleFonts.inter(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white.withValues(alpha: 0.50),
            letterSpacing: 1.2,
          ),
        ),

        SizedBox(height: 6.h),

        // ── Input field ─────────────
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.white.withValues(
              alpha: _focused ? 0.08 : 0.05,
            ),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: hasError
                  ? AppColors.danger.withValues(alpha: 0.70)
                  : _focused
                      ? AppColors.primary.withValues(alpha: 0.60)
                      : Colors.white.withValues(alpha: 0.10),
              width: 1,
            ),
            boxShadow: hasError
                ? [
                    BoxShadow(
                      color: AppColors.danger.withValues(alpha: 0.10),
                      blurRadius: 8,
                    ),
                  ]
                : _focused
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          blurRadius: 8,
                        ),
                      ]
                    : [],
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            obscureText: widget.isPassword ? _obscure : false,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            style: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            cursorColor: AppColors.primary,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.25),
              ),
              prefixIcon: Icon(
                widget.prefixIcon,
                size: 18.r,
                color: _focused
                    ? AppColors.primary
                    : Colors.white.withValues(alpha: 0.40),
              ),
              suffixIcon: widget.isPassword
                  ? GestureDetector(
                      onTap: () => setState(() => _obscure = !_obscure),
                      child: Icon(
                        _obscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 18.r,
                        color: Colors.white.withValues(alpha: 0.40),
                      ),
                    )
                  : widget.suffixIcon != null
                      ? Icon(
                          widget.suffixIcon,
                          size: 18.r,
                          color: widget.suffixColor,
                        )
                      : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
            ),
          ),
        ),

        // ── Error text ──────────────
        if (hasError) ...[
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 12.r,
                color: AppColors.danger,
              ),
              SizedBox(width: 4.w),
              Text(
                widget.errorText!,
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
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
