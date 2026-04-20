import 'package:flutter/material.dart';
import 'package:algolens/core/theme/app_colors.dart';

class UserProfile {
  final String handle;
  final int rating;
  final int maxRating;
  final String rank;
  final int problemsSolved;
  final int contestsParticipated;
  final int streakDays;
  final String lastActiveDate;
  final String avatar;

  const UserProfile({
    required this.handle,
    required this.rating,
    required this.maxRating,
    required this.rank,
    required this.problemsSolved,
    required this.contestsParticipated,
    required this.streakDays,
    required this.lastActiveDate,
    required this.avatar,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      handle: json['handle'] as String,
      rating: json['rating'] as int,
      maxRating: json['maxRating'] as int,
      rank: json['rank'] as String,
      problemsSolved: json['problemsSolved'] as int,
      contestsParticipated: json['contestsParticipated'] as int,
      streakDays: json['streakDays'] as int,
      lastActiveDate: json['lastActiveDate'] as String,
      avatar: json['avatar'] as String? ?? '',
    );
  }

  Color get rankColor => AppColors.rankColor(rank);
}
