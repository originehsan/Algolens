import 'package:flutter/material.dart';
import 'package:algolens/core/theme/app_colors.dart';

class UpsolveItem {
  final int contestId;
  final String index;
  final String name;
  final int rating;
  final List<String> tags;
  final String bestVerdict;
  final String url;

  const UpsolveItem({
    required this.contestId,
    required this.index,
    required this.name,
    required this.rating,
    required this.tags,
    required this.bestVerdict,
    required this.url,
  });

  factory UpsolveItem.fromJson(Map<String, dynamic> json) {
    return UpsolveItem(
      contestId: json['contestId'] as int,
      index: json['index'] as String,
      name: json['name'] as String,
      rating: json['rating'] as int,
      tags: List<String>.from(
        json['tags'] as List,
      ),
      bestVerdict: json['bestVerdict'] as String,
      url: json['url'] as String,
    );
  }

  Color get verdictColor {
    switch (bestVerdict) {
      case 'WRONG_ANSWER':
        return AppColors.danger;
      case 'TIME_LIMIT_EXCEEDED':
        return AppColors.warning;
      case 'MEMORY_LIMIT_EXCEEDED':
        return AppColors.warning;
      default:
        return AppColors.textMuted;
    }
  }

  String get verdictShort {
    switch (bestVerdict) {
      case 'WRONG_ANSWER':
        return 'WA';
      case 'TIME_LIMIT_EXCEEDED':
        return 'TLE';
      case 'MEMORY_LIMIT_EXCEEDED':
        return 'MLE';
      case 'RUNTIME_ERROR':
        return 'RE';
      case 'COMPILATION_ERROR':
        return 'CE';
      default:
        return bestVerdict;
    }
  }
}

class UpsolveContest {
  final String contestId;
  final List<UpsolveItem> problems;

  const UpsolveContest({
    required this.contestId,
    required this.problems,
  });

  static List<UpsolveContest> fromApiResponse(Map<String, dynamic> json) {
    return json.entries.map((entry) {
      final problems = (entry.value as List)
          .map((p) => UpsolveItem.fromJson(p as Map<String, dynamic>))
          .toList();
      return UpsolveContest(
        contestId: entry.key,
        problems: problems,
      );
    }).toList();
  }
}
