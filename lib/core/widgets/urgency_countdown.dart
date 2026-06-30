import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:algolens/core/utils/contest_utils.dart';
import 'package:algolens/core/utils/duration_utils.dart';

/// Self-contained urgency countdown
/// Color shifts: blue→amber→red
/// based on remaining time
/// Isolates its own Timer so
/// parent never rebuilds
class UrgencyCountdown extends StatefulWidget {
  const UrgencyCountdown({
    super.key,
    required this.targetTime,
    this.fontSize,
  });

  final DateTime targetTime;
  final double? fontSize;

  @override
  State<UrgencyCountdown> createState() => _UrgencyCountdownState();
}

class _UrgencyCountdownState extends State<UrgencyCountdown> {
  late Timer _timer;
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _remaining = DurationUtils.remaining(widget.targetTime);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      final r = DurationUtils.remaining(widget.targetTime);
      setState(() => _remaining = r);
      if (r == Duration.zero) _timer.cancel();
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
    return Text(
      DurationUtils.formatCountdown(_remaining),
      style: GoogleFonts.jetBrainsMono(
        fontSize: widget.fontSize ?? 14.sp,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: 0.8,
      ),
    );
  }
}