import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';

/// Animated reminder bell button
/// Active state = primary blue fill
/// Inactive state = ghost
/// Used on contest cards everywhere
class BellButton extends StatelessWidget {
  const BellButton({
    super.key,
    required this.hasReminder,
    required this.onTap,
    this.size,
  });

  final bool hasReminder;
  final VoidCallback onTap;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final s = size ?? 34.r;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        width: s,
        height: s,
        decoration: BoxDecoration(
          color: hasReminder
              ? AppColors.primary.withValues(alpha: 0.18)
              : Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: hasReminder
                ? AppColors.primary.withValues(alpha: 0.45)
                : Colors.white.withValues(alpha: 0.12),
            width: 1.0,
          ),
        ),
        child: Icon(
          hasReminder
              ? Icons.notifications_active_rounded
              : Icons.notifications_none_rounded,
          color: hasReminder ? AppColors.primary : AppColors.textMuted,
          size: s * 0.47,
        ),
      ),
    );
  }
}