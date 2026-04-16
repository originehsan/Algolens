import 'package:flutter/material.dart';
import 'package:algolens/core/widgets/rank_chip.dart';

class Friend {
  final String handle;
  final int rating;
  final int maxRating;
  final String rank;
  final String avatar;
  final int contestsParticipated;

  const Friend({
    required this.handle,
    required this.rating,
    required this.maxRating,
    required this.rank,
    required this.avatar,
    required this.contestsParticipated,
  });

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      handle: json['handle'] as String,
      rating: json['rating'] as int,
      maxRating: json['maxRating'] as int,
      rank: json['rank'] as String,
      avatar: json['avatar'] as String? ?? '',
      contestsParticipated: json['contestsParticipated'] as int,
    );
  }

  Color get rankColor => RankChip.getRankColor(rank);
}
