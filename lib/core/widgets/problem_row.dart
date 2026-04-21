import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/features/practice/data/models/problem_model.dart';

class ProblemRow extends StatelessWidget {
  final Problem problem;
  final bool showDifficulty;
  final bool blindMode;
  final VoidCallback? onTap;

  const ProblemRow({
    super.key,
    required this.problem,
    this.showDifficulty = true,
    this.blindMode = false,
    this.onTap,
  });

  Color _getDifficultyColor(int rating) {
    if (rating < 1400) return AppColors.success;
    if (rating < 1800) return AppColors.warning;
    return AppColors.danger;
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      padding: EdgeInsets.all(14.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blindMode
                      ? '${problem.index}. ••••••••••'
                      : '${problem.index}. ${problem.name}',
                  style: AppTextStyles.bodyBold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                Wrap(
                  spacing: 6.w,
                  runSpacing: 4.h,
                  children: blindMode
                      ? [
                          _buildChip('?', AppColors.textMuted),
                          _buildChip('?', AppColors.textMuted),
                        ]
                      : problem.tags
                            .take(3)
                            .map((tag) => _buildChip(tag, AppColors.textMuted))
                            .toList(),
                ),
              ],
            ),
          ),
          if (showDifficulty) ...[
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: blindMode
                        ? AppColors.textMuted.withValues(alpha: 0.10)
                        : _getDifficultyColor(
                            problem.rating,
                          ).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: blindMode
                          ? AppColors.textMuted.withValues(alpha: 0.20)
                          : _getDifficultyColor(
                              problem.rating,
                            ).withValues(alpha: 0.40),
                      width: 1.0,
                    ),
                  ),
                  child: Text(
                    blindMode ? '???' : problem.rating.toString(),
                    style: AppTextStyles.metricSmall.copyWith(
                      fontSize: 12.sp,
                      color: blindMode
                          ? AppColors.textMuted
                          : _getDifficultyColor(problem.rating),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: color.withValues(alpha: 0.20), width: 1.0),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          fontSize: 10.sp,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
