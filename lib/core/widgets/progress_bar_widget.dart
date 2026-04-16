import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:algolens/core/theme/app_text_styles.dart';

class ProgressBarWidget extends StatelessWidget {
  final double percentage;
  final Color color;
  final double? height;
  final String? label;
  final bool showPercentageText;

  const ProgressBarWidget({
    super.key,
    required this.percentage,
    required this.color,
    this.height,
    this.label,
    this.showPercentageText = false,
  });

  @override
  Widget build(BuildContext context) {
    final clampedPercentage = percentage.clamp(0.0, 100.0);
    final percentDecimal = clampedPercentage / 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label!,
                style: AppTextStyles.caption,
              ),
              if (showPercentageText)
                Text(
                  '${clampedPercentage.toStringAsFixed(1)}%',
                  style: AppTextStyles.caption.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          SizedBox(height: 4.h),
        ],
        LinearPercentIndicator(
          lineHeight: height ?? 6.h,
          percent: percentDecimal,
          progressColor: color,
          backgroundColor: Colors.white.withOpacity(0.10),
          barRadius: Radius.circular(4.r),
          padding: EdgeInsets.zero,
          animation: true,
          animationDuration: 800,
          curve: Curves.easeOut,
        ),
      ],
    );
  }
}

class ProgressBarRow extends StatelessWidget {
  final double percentage;
  final Color color;
  final String leftLabel;
  final String rightLabel;

  const ProgressBarRow({
    super.key,
    required this.percentage,
    required this.color,
    required this.leftLabel,
    required this.rightLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leftLabel,
              style: AppTextStyles.caption,
            ),
            Text(
              rightLabel,
              style: AppTextStyles.caption.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        ProgressBarWidget(
          percentage: percentage,
          color: color,
        ),
      ],
    );
  }
}
