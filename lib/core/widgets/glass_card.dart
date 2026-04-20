import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';

// ──────────────────────────────
// GLASS CARD TYPE
// Controls border glow color
// ──────────────────────────────

/// Card variant enum
///
/// default  → primary blue glow
/// primary  → primary blue glow
/// success  → green glow
/// danger   → red glow
/// warning  → amber glow
/// premium  → gold glow
enum GlassCardType {
  defaultCard,
  primary,
  success,
  danger,
  warning,
  premium,
}

// ──────────────────────────────
// GLASS CARD
// ──────────────────────────────

/// Glassmorphism card widget
///
/// Features:
/// → Frosted glass background
/// → Colored border glow
/// → Backdrop blur
/// → Configurable padding
/// → Configurable radius
/// → Optional tap handler
/// → Optional animate support
///
/// Usage:
/// GlassCard(
///   child: YourContent(),
/// )
///
/// GlassCard(
///   type: GlassCardType.success,
///   padding: EdgeInsets.all(20.r),
///   child: YourContent(),
/// )
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.type = GlassCardType.defaultCard,
    this.padding,
    this.borderRadius,
    this.onTap,
    this.width,
    this.height,
    this.margin,
  });

  final Widget child;
  final GlassCardType type;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;

  // ────────────────────────────
  // GLOW COLOR
  // Based on type
  // ────────────────────────────

  Color get _glowColor {
    return switch (type) {
      GlassCardType.defaultCard => AppColors.primary,
      GlassCardType.primary => AppColors.primary,
      GlassCardType.success => AppColors.success,
      GlassCardType.danger => AppColors.danger,
      GlassCardType.warning => AppColors.warning,
      GlassCardType.premium => const Color(0xFFFFD700),
    };
  }

  // ────────────────────────────
  // BORDER COLOR
  // Subtle version of glow
  // ────────────────────────────

  Color get _borderColor => _glowColor.withValues(alpha: 0.35);

  // ────────────────────────────
  // BACKGROUND COLOR
  // Frosted glass base
  // ────────────────────────────

  Color get _bgColor => AppColors.bgBase.withValues(
        alpha: 0.60,
      );

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? 16.r;
    final defaultPadding = EdgeInsets.all(16.r);

    Widget card = ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 12,
          sigmaY: 12,
        ),
        child: Container(
          width: width,
          height: height,
          padding: padding ?? defaultPadding,
          decoration: BoxDecoration(
            color: _bgColor,
            borderRadius: BorderRadius.circular(
              radius,
            ),
            border: Border.all(
              color: _borderColor,
              width: 1.0,
            ),
            boxShadow: [
              // ────────────────
              // OUTER GLOW
              // Colored ambient
              // ────────────────

              BoxShadow(
                color: _glowColor.withValues(
                  alpha: 0.15,
                ),
                blurRadius: 20,
                spreadRadius: 0,
                offset: Offset.zero,
              ),

              // ────────────────
              // INNER DEPTH
              // Dark base shadow
              // ────────────────

              BoxShadow(
                color: Colors.black.withValues(
                  alpha: 0.25,
                ),
                blurRadius: 8,
                spreadRadius: -2,
                offset: const Offset(
                  0,
                  4,
                ),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );

    // ──────────────────────────
    // TAP HANDLER
    // Wrap with GestureDetector if
    // onTap provided
    // ──────────────────────────

    if (onTap != null) {
      card = GestureDetector(
        onTap: onTap,
        child: card,
      );
    }

    // ──────────────────────────
    // MARGIN WRAPPER
    // ──────────────────────────

    if (margin != null) {
      return Padding(
        padding: margin!,
        child: card,
      );
    }

    return card;
  }
}

// ──────────────────────────────
// GLASS CARD SHIMMER
// Loading placeholder version
// Same shape as GlassCard
// ──────────────────────────────

/// Shimmer placeholder that
/// matches GlassCard dimensions
///
/// Usage:
/// GlassCardShimmer(
///   height: 120.h,
/// )
class GlassCardShimmer extends StatefulWidget {
  const GlassCardShimmer({
    super.key,
    required this.height,
    this.width,
    this.borderRadius,
    this.margin,
  });

  final double height;
  final double? width;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;

  @override
  State<GlassCardShimmer> createState() => _GlassCardShimmerState();
}

class _GlassCardShimmerState extends State<GlassCardShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1200,
      ),
    )..repeat(reverse: true);

    _anim = Tween<double>(
      begin: 0.3,
      end: 0.7,
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

  @override
  Widget build(BuildContext context) {
    final radius = widget.borderRadius ?? 16.r;

    Widget shimmer = AnimatedBuilder(
      animation: _anim,
      builder: (context, _) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              radius,
            ),
            color: AppColors.primary.withValues(
              alpha: _anim.value * 0.08,
            ),
            border: Border.all(
              color: AppColors.primary.withValues(
                alpha: _anim.value * 0.15,
              ),
              width: 1.0,
            ),
          ),
        );
      },
    );

    if (widget.margin != null) {
      return Padding(
        padding: widget.margin!,
        child: shimmer,
      );
    }

    return shimmer;
  }
}
