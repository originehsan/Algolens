import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';

class RankChip extends StatelessWidget {
  final String rank;
  final bool small;

  const RankChip({
    super.key,
    required this.rank,
    this.small = false,
  });

  static Color getRankColor(String rank) {
    final lower = rank.toLowerCase();
    if (lower.contains('legendary grandmaster') ||
        lower.contains('international grandmaster') ||
        lower.contains('grandmaster')) {
      return AppColors.cfGM;
    }
    if (lower.contains('international master')) {
      return AppColors.cfMaster;
    }
    if (lower.contains('master')) {
      return AppColors.cfMaster;
    }
    if (lower.contains('candidate master')) {
      return AppColors.cfCM;
    }
    if (lower.contains('expert')) {
      return AppColors.cfExpert;
    }
    if (lower.contains('specialist')) {
      return AppColors.cfSpecialist;
    }
    if (lower.contains('pupil')) {
      return AppColors.cfPupil;
    }
    if (lower.contains('newbie')) {
      return AppColors.cfNewbie;
    }
    return AppColors.textMuted;
  }

  @override
  Widget build(BuildContext context) {
    final rankColor = getRankColor(rank);
    final fontSize = small ? 10.sp : 12.sp;
    final paddingH = small ? 8.w : 10.w;
    final paddingV = small ? 2.h : 4.h;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: paddingH,
        vertical: paddingV,
      ),
      decoration: BoxDecoration(
        color: rankColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: rankColor.withOpacity(0.40),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: rankColor.withOpacity(0.20),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        _capitalizeRank(rank),
        style: AppTextStyles.caption.copyWith(
          fontSize: fontSize,
          color: rankColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _capitalizeRank(String rank) {
    if (rank.isEmpty) return rank;
    return rank
        .split(' ')
        .map((word) => word.isEmpty
            ? word
            : word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}
