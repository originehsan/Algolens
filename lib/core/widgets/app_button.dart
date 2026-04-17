import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';

class AppButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutline;
  final bool isGhost;
  final double? width;
  final Color? color;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isOutline = false,
    this.isGhost = false,
    this.width,
    this.color,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isLoading ? null : widget.onPressed,
      onTapDown: (_) {
        if (!widget.isLoading) {
          setState(() => _isPressed = true);
        }
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: SizedBox(
          width: widget.width ?? double.infinity,
          height: 52.h,
          child: _buildButtonWithGlow(),
        ),
      ),
    );
  }

  Widget _buildButtonWithGlow() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: _isPressed
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.30),
                  blurRadius: 12,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: _buildButton(),
    );
  }

  Widget _buildButton() {
    if (widget.isGhost) {
      return Center(
        child: Text(
          widget.label,
          style: AppTextStyles.body.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    if (widget.isOutline) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 20,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.08),
                  Colors.white.withValues(alpha: 0.04),
                ],
              ),
              border: Border.all(
                color:
                    (widget.color ?? AppColors.primary).withValues(alpha: 0.70),
                width: 1.5,
              ),
            ),
            child: Center(
              child: widget.isLoading
                  ? SizedBox(
                      width: 20.r,
                      height: 20.r,
                      child: CircularProgressIndicator(
                        color: widget.color ?? AppColors.primary,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      widget.label,
                      style: AppTextStyles.bodyBold.copyWith(
                        color: widget.color ?? AppColors.primary,
                      ),
                    ),
            ),
          ),
        ),
      );
    }

    // Default primary button
    return ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 20,
          sigmaY: 20,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                (widget.color ?? AppColors.primary).withValues(alpha: 0.85),
                (widget.color ?? AppColors.primaryDark).withValues(alpha: 0.90),
              ],
            ),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.60),
              width: 1.5,
            ),
          ),
          child: Center(
            child: widget.isLoading
                ? SizedBox(
                    width: 20.r,
                    height: 20.r,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    widget.label,
                    style: AppTextStyles.bodyBold,
                  ),
          ),
        ),
      ),
    );
  }
}
