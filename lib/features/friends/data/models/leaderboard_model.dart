import 'package:flutter/material.dart';
import 'package:algolens/core/theme/app_colors.dart';

class LeaderboardEntry {
  final int rank;
  final String handle;
  final int rating;
  final String tier;
  final int maxRating;

  const LeaderboardEntry({
    required this.rank,
    required this.handle,
    required this.rating,
    required this.tier,
    required this.maxRating,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      rank: json['rank'] as int,
      handle: json['handle'] as String,
      rating: json['rating'] as int,
      tier: json['tier'] as String,
      maxRating: json['maxRating'] as int,
    );
  }

  Color get rankColor => AppColors.rankColor(tier);

  bool get isCurrentUser => handle == 'ehsan_cf';
}
