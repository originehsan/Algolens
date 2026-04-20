import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';

// ──────────────────────────────
// APP BUTTON TYPE
// ──────────────────────────────

/// Button variant enum
///
/// primary → filled cyan button
/// outline → bordered button
/// ghost   → text only button
enum AppButtonType {
  primary,
  outline,
  ghost,
}

// ──────────────────────────────
// APP BUTTON
// ──────────────────────────────

/// Primary button widget
///
/// Features:
/// → Scale 0.97 on press
/// → HapticFeedback.lightImpact
/// → Loading spinner state
/// → Disabled state
/// → Leading icon support
/// → Full width by default
///
/// Usage:
/// AppButton(
///   label: 'Login',
///   onTap: () => ...,
/// )
///
/// AppButton(
///   label: 'Following',
///   type: AppButtonType.outline,
///   icon: Icons.check,
///   isLoading: state.isLoading,
///   onTap: () => ...,
/// )
class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.type = AppButtonType.primary,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.width,
    this.height,
  });

  final String label;
  final VoidCallback? onTap;
  final AppButtonType type;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;
  final double? width;
  final double? height;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
    );
    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  // ────────────────────────────
  // TAP HANDLERS
  // Scale + haptic
  // ────────────────────────────

  void _onTapDown(
    TapDownDetails details,
  ) {
    if (_isInteractable) {
      _ctrl.forward();
    }
  }

  void _onTapUp(
    TapUpDetails details,
  ) {
    if (_isInteractable) {
      _ctrl.reverse();
      HapticFeedback.lightImpact();
      widget.onTap?.call();
    }
  }

  void _onTapCancel() {
    _ctrl.reverse();
  }

  bool get _isInteractable =>
      !widget.isLoading && !widget.isDisabled && widget.onTap != null;

  // ────────────────────────────
  // STYLE GETTERS
  // Based on type + state
  // ────────────────────────────

  Color get _bgColor {
    if (!_isInteractable) {
      return switch (widget.type) {
        AppButtonType.primary => AppColors.primary.withValues(alpha: 0.40),
        AppButtonType.outline => Colors.transparent,
        AppButtonType.ghost => Colors.transparent,
      };
    }
    return switch (widget.type) {
      AppButtonType.primary => AppColors.primary,
      AppButtonType.outline => Colors.transparent,
      AppButtonType.ghost => Colors.transparent,
    };
  }

  Color get _borderColor {
    if (!_isInteractable) {
      return AppColors.primary.withValues(alpha: 0.30);
    }
    return switch (widget.type) {
      AppButtonType.primary => Colors.transparent,
      AppButtonType.outline => AppColors.primary,
      AppButtonType.ghost => Colors.transparent,
    };
  }

  Color get _labelColor {
    if (!_isInteractable) {
      return Colors.white.withValues(alpha: 0.40);
    }
    return switch (widget.type) {
      AppButtonType.primary => Colors.white,
      AppButtonType.outline => AppColors.primary,
      AppButtonType.ghost => AppColors.primary,
    };
  }

  List<BoxShadow> get _shadows {
    if (!_isInteractable || widget.type != AppButtonType.primary) {
      return [];
    }
    return [
      BoxShadow(
        color: AppColors.primary.withValues(alpha: 0.35),
        blurRadius: 16,
        spreadRadius: 0,
        offset: const Offset(0, 4),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Container(
          width: widget.width ?? double.infinity,
          height: widget.height ?? 52.h,
          decoration: BoxDecoration(
            color: _bgColor,
            borderRadius: BorderRadius.circular(
              12.r,
            ),
            border: Border.all(
              color: _borderColor,
              width: 1.5,
            ),
            boxShadow: _shadows,
          ),
          child: Center(
            child: widget.isLoading
                ? _LoadingIndicator(
                    color: _labelColor,
                  )
                : _ButtonContent(
                    label: widget.label,
                    icon: widget.icon,
                    color: _labelColor,
                  ),
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────
// BUTTON CONTENT
// Label + optional icon
// ──────────────────────────────

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.label,
    required this.color,
    this.icon,
  });

  final String label;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    if (icon == null) {
      return Text(
        label,
        style: AppTextStyles.button.copyWith(color: color),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color,
          size: 18.r,
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: AppTextStyles.button.copyWith(color: color),
        ),
      ],
    );
  }
}

// ──────────────────────────────
// LOADING INDICATOR
// Small spinner for loading state
// ──────────────────────────────

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20.r,
      height: 20.r,
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(
          color,
        ),
      ),
    );
  }
}
