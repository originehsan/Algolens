import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';

class CountdownTimer extends StatefulWidget {
  final int startTimeSeconds;
  final TextStyle? style;

  const CountdownTimer({
    super.key,
    required this.startTimeSeconds,
    this.style,
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late int _remainingSeconds;

  @override
  void initState() {
    super.initState();
    _calculateRemaining();
    _startTimer();
  }

  void _calculateRemaining() {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    _remainingSeconds = widget.startTimeSeconds - now;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    if (seconds <= 0) return 'LIVE';

    final days = seconds ~/ 86400;
    final hours = (seconds % 86400) ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    if (days > 0) {
      return '${days}d ${hours}h ${minutes}m';
    } else if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${secs.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:'
          '${secs.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLive = _remainingSeconds <= 0;
    final displayText = _formatTime(_remainingSeconds);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isLive) ...[
          Container(
            width: 6.r,
            height: 6.r,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.danger,
            ),
          ),
          SizedBox(width: 4.w),
        ],
        Text(
          displayText,
          style: widget.style ??
              AppTextStyles.metricSmall.copyWith(
                color: isLive ? AppColors.danger : AppColors.primary,
                fontSize: 13.sp,
              ),
        ),
      ],
    );
  }
}
