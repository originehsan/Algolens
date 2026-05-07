import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';

// ──────────────────────────────
// COUNTDOWN TIMER
// Live ticking timer widget
// ──────────────────────────────

/// Live countdown timer
///
/// Features:
/// → Ticks every second
/// → Format: "02:14:33"
/// → JetBrains Mono font
/// → Primary cyan color
/// → Auto stops at 00:00:00
///
/// Usage:
/// CountdownTimer(
///   targetTime: contest.startDateTime,
/// )
class CountdownTimer extends StatefulWidget {
  const CountdownTimer({
    super.key,
    required this.targetTime,
    this.fontSize,
    this.color,
  });

  /// The time to count down to
  final DateTime targetTime;

  /// Font size — defaults to 13.sp
  final double? fontSize;

  /// Text color — defaults to AppColors.primary
  final Color? color;

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _remaining = _calculateRemaining();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // ────────────────────────────
  // CALCULATE REMAINING
  // ────────────────────────────

  Duration _calculateRemaining() {
    final now = DateTime.now();
    final diff = widget.targetTime.difference(now);
    return diff.isNegative ? Duration.zero : diff;
  }

  // ────────────────────────────
  // START TIMER
  // Ticks every second
  // ────────────────────────────

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!mounted) return;
        final remaining = _calculateRemaining();
        setState(() {
          _remaining = remaining;
        });
        if (_remaining == Duration.zero) {
          _timer.cancel();
        }
      },
    );
  }

  // ────────────────────────────
  // FORMAT DURATION
  // "02:14:33" or "1d 02:14:33"
  // ────────────────────────────

  String get _formatted {
    final days = _remaining.inDays;
    final hours = _remaining.inHours.remainder(24).toString().padLeft(2, '0');
    final minutes =
        _remaining.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds =
        _remaining.inSeconds.remainder(60).toString().padLeft(2, '0');

    if (days > 0) {
      return '${days}d $hours:$minutes:$seconds';
    }
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatted,
      style: TextStyle(
        fontFamily: 'JetBrainsMono',
        fontSize: widget.fontSize ?? 13.sp,
        fontWeight: FontWeight.w600,
        color: widget.color ?? AppColors.primary,
        letterSpacing: 0.5,
      ),
    );
  }
}
