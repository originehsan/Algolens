import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';

// ──────────────────────────────
// APP BUTTON TYPE
// ──────────────────────────────

enum AppButtonType {
  primary,
  outline,
  ghost,
  danger,
  glow, // ← new: glassmorphism + glow outline
}

// ──────────────────────────────
// APP BUTTON
// ──────────────────────────────

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
    this.glowIntensity = 1.0, // 0.0 subtle → 1.0 strong
  });

  final String label;
  final VoidCallback? onTap;
  final AppButtonType type;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;
  final double? width;
  final double? height;
  final double glowIntensity;

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
      duration: const Duration(milliseconds: 100),
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

  void _onTapDown(TapDownDetails _) {
    if (_isInteractable) _ctrl.forward();
  }

  void _onTapUp(TapUpDetails _) {
    if (_isInteractable) {
      _ctrl.reverse();
      HapticFeedback.lightImpact();
      widget.onTap?.call();
    }
  }

  void _onTapCancel() => _ctrl.reverse();

  bool get _isInteractable =>
      !widget.isLoading && !widget.isDisabled && widget.onTap != null;

  // ────────────────────────────
  // STYLE GETTERS
  // ────────────────────────────

  Color get _bgColor {
    if (!_isInteractable) {
      return switch (widget.type) {
        AppButtonType.primary => AppColors.primary.withValues(alpha: 0.40),
        AppButtonType.glow => AppColors.primary.withValues(alpha: 0.08),
        AppButtonType.outline => Colors.transparent,
        AppButtonType.ghost => Colors.transparent,
        AppButtonType.danger => AppColors.danger.withValues(alpha: 0.40),
      };
    }
    return switch (widget.type) {
      AppButtonType.primary => AppColors.primary,
      AppButtonType.glow => AppColors.primary.withValues(
          alpha: 0.08 + (0.07 * widget.glowIntensity),
        ),
      AppButtonType.outline => Colors.transparent,
      AppButtonType.ghost => Colors.transparent,
      AppButtonType.danger => AppColors.danger.withValues(alpha: 0.12),
    };
  }

  Color get _borderColor {
    if (!_isInteractable) {
      return switch (widget.type) {
        AppButtonType.glow => AppColors.primary.withValues(alpha: 0.20),
        _ => AppColors.primary.withValues(alpha: 0.30),
      };
    }
    return switch (widget.type) {
      AppButtonType.primary => Colors.transparent,
      AppButtonType.glow => AppColors.primary.withValues(
          alpha: 0.35 + (0.35 * widget.glowIntensity),
        ),
      AppButtonType.outline => AppColors.primary,
      AppButtonType.ghost => Colors.transparent,
      AppButtonType.danger => AppColors.danger,
    };
  }

  Color get _labelColor {
    if (!_isInteractable) {
      return Colors.white.withValues(alpha: 0.40);
    }
    return switch (widget.type) {
      AppButtonType.primary => Colors.white,
      AppButtonType.glow => Colors.white,
      AppButtonType.outline => AppColors.primary,
      AppButtonType.ghost => AppColors.primary,
      AppButtonType.danger => AppColors.danger,
    };
  }

  List<BoxShadow> get _shadows {
    if (!_isInteractable) return [];
    return switch (widget.type) {
      AppButtonType.primary => [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.35),
            blurRadius: 16,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      AppButtonType.glow => [
          // Inner ambient glow
          BoxShadow(
            color: AppColors.primary.withValues(
              alpha: 0.12 + (0.18 * widget.glowIntensity),
            ),
            blurRadius: 8 + (12 * widget.glowIntensity),
            spreadRadius: 0 + (3 * widget.glowIntensity),
          ),
          // Outer spread glow
          BoxShadow(
            color: AppColors.primary.withValues(
              alpha: 0.06 + (0.10 * widget.glowIntensity),
            ),
            blurRadius: 20 + (20 * widget.glowIntensity),
            spreadRadius: 0,
          ),
        ],
      AppButtonType.danger => [
          BoxShadow(
            color: AppColors.danger.withValues(alpha: 0.30),
            blurRadius: 16,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      AppButtonType.outline || AppButtonType.ghost => [],
    };
  }

  // ────────────────────────────
  // BORDER RADIUS
  // glow type = 14.r (rounded)
  // others = 12.r
  // ────────────────────────────

  double get _borderRadius => switch (widget.type) {
        AppButtonType.glow => 14.r,
        _ => 12.r,
      };

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
            borderRadius: BorderRadius.circular(_borderRadius),
            border: Border.all(
              color: _borderColor,
              width: 1.5,
            ),
            boxShadow: _shadows,
          ),
          child: Center(
            child: widget.isLoading
                ? _LoadingIndicator(color: _labelColor)
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
        style: AppTextStyles.button.copyWith(
          color: color,
        ),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 18.r),
        SizedBox(width: 8.w),
        Text(
          label,
          style: AppTextStyles.button.copyWith(
            color: color,
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────
// LOADING INDICATOR
// ──────────────────────────────

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20.r,
      height: 20.r,
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
