import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Animated pulsing circle dot
/// Used in LIVE status badges
/// across contest cards
class PulsingDot extends StatefulWidget {
  const PulsingDot({
    super.key,
    required this.color,
    this.size,
  });

  final Color color;
  final double? size;

  @override
  State<PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dotSize = widget.size ?? 6.r;
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Container(
        width: dotSize,
        height: dotSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color.withValues(
            alpha: 0.50 + (_ctrl.value * 0.50),
          ),
        ),
      ),
    );
  }
}