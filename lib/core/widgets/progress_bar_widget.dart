import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';

// ──────────────────────────────
// PROGRESS BAR WIDGET
// Animated progress bar
// ──────────────────────────────

/// Animated horizontal progress bar
///
/// Features:
/// → Smooth animation on mount
/// → Color variants
/// → Optional label
/// → Optional percentage text
///
/// Usage:
/// ProgressBarWidget(
///   value: 0.65,
///   color: AppColors.success,
///   label: 'AC Rate',
///   showPercentage: true,
/// )
class ProgressBarWidget extends StatefulWidget {
  const ProgressBarWidget({
    super.key,
    required this.value,
    this.color,
    this.label,
    this.showPercentage = false,
    this.height,
    this.backgroundColor,
  });

  /// Progress 0.0 to 1.0
  final double value;
  final Color? color;
  final String? label;
  final bool showPercentage;
  final double? height;
  final Color? backgroundColor;

  @override
  State<ProgressBarWidget> createState() => _ProgressBarWidgetState();
}

class _ProgressBarWidgetState extends State<ProgressBarWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late Animation<double> _anim; // FIXED: removed `final` — reassigned in didUpdateWidget

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 800,
      ),
    );
    _anim = Tween<double>(
      begin: 0.0,
      end: widget.value.clamp(
        0.0,
        1.0,
      ),
    ).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: Curves.easeOutCubic,
      ),
    );
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(
    ProgressBarWidget oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _anim = Tween<double>(
        begin: _anim.value,
        end: widget.value.clamp(
          0.0,
          1.0,
        ),
      ).animate(
        CurvedAnimation(
          parent: _ctrl,
          curve: Curves.easeOutCubic,
        ),
      );
      _ctrl
        ..reset()
        ..forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final barColor = widget.color ?? AppColors.primary;
    final bgColor = widget.backgroundColor ??
        Colors.white.withValues(
          alpha: 0.08,
        );
    final barHeight = widget.height ?? 6.h;
    final percentage = (widget.value * 100).toStringAsFixed(0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ──────────────────────
        // LABEL ROW
        // ──────────────────────

        if (widget.label != null || widget.showPercentage) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.label != null)
                Text(
                  widget.label!,
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.white.withValues(
                      alpha: 0.60,
                    ),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              if (widget.showPercentage)
                Text(
                  '$percentage%',
                  style: AppTextStyles.caption.copyWith(
                    color: barColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          SizedBox(height: 6.h),
        ],

        // ──────────────────────
        // PROGRESS BAR
        // ──────────────────────

        ClipRRect(
          borderRadius: BorderRadius.circular(
            barHeight,
          ),
          child: Container(
            height: barHeight,
            color: bgColor,
            child: AnimatedBuilder(
              animation: _anim,
              builder: (context, _) {
                return FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _anim.value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: BorderRadius.circular(
                        barHeight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: barColor.withValues(
                            alpha: 0.40,
                          ),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}