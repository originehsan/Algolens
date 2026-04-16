import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/rank_chip.dart';

class UserAvatar extends StatelessWidget {
  final String handle;
  final String rank;
  final double? size;

  const UserAvatar({
    super.key,
    required this.handle,
    required this.rank,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final avatarSize = size ?? 44.r;
    final rankColor = RankChip.getRankColor(rank);
    final initials = handle.length >= 2
        ? handle.substring(0, 2).toUpperCase()
        : handle.toUpperCase();

    return Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: rankColor.withOpacity(0.20),
        border: Border.all(
          color: rankColor.withOpacity(0.60),
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          initials,
          style: AppTextStyles.bodyBold.copyWith(
            color: rankColor,
            fontSize: avatarSize * 0.32,
          ),
        ),
      ),
    );
  }
}
