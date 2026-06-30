import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/utils/contest_utils.dart';
import 'package:algolens/core/utils/duration_utils.dart';

/// Thin urgency progress bar
/// Shows time pressure visually
/// Updates every 30 seconds
/// Used at bottom of contest cards
class UrgencyBar extends StatefulWidget {
  const UrgencyBar({
    super.key,
    required this.targetTime,
    required this.accentColor,
  });

  final DateTime targetTime;
  final Color accentColor;

  @override
  State<UrgencyBar> createState() => _UrgencyBarState();
}

class _UrgencyBarState extends State<UrgencyBar> {
  late Timer _timer;
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _remaining = DurationUtils.remaining(widget.targetTime);
    _timer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (!mounted) return;
      setState(() => _remaining = DurationUtils.remaining(widget.targetTime));
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = ContestUtils.urgencyColor(_remaining);
    final progress = ContestUtils.urgencyProgress(_remaining);
    return ClipRRect(
      borderRadius: BorderRadius.circular(2.r),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 2.h,
        backgroundColor: Colors.white.withValues(alpha: 0.08),
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}