import 'package:flutter/material.dart';
import 'package:algolens/core/theme/app_colors.dart';

class WeakTopic {
  final String tag;
  final int totalAttempts;
  final int solvedCount;
  final int unsolvedCount;
  final double acRate;

  const WeakTopic({
    required this.tag,
    required this.totalAttempts,
    required this.solvedCount,
    required this.unsolvedCount,
    required this.acRate,
  });

  factory WeakTopic.fromJson(Map<String, dynamic> json) {
    return WeakTopic(
      tag: json['tag'] as String,
      totalAttempts: json['totalAttempts'] as int,
      solvedCount: json['solvedCount'] as int,
      unsolvedCount: json['unsolvedCount'] as int,
      acRate: (json['acRate'] as num).toDouble(),
    );
  }

  String get severity {
    if (acRate < 30) return 'CRITICAL';
    if (acRate < 50) return 'HIGH';
    if (acRate < 70) return 'MEDIUM';
    return 'LOW';
  }

  Color get severityColor {
    switch (severity) {
      case 'CRITICAL':
        return AppColors.danger;
      case 'HIGH':
        return AppColors.warning;
      case 'MEDIUM':
        return AppColors.primary;
      default:
        return AppColors.success;
    }
  }
}
