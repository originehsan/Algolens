import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';

// ──────────────────────────────
// SEGMENTED TAB
// Custom animated tab bar
// ──────────────────────────────

/// Animated segmented tab bar
///
/// Features:
/// → Sliding active indicator
/// → AnimatedContainer transition
/// → Glass background
/// → Used in:
///   contests screen (3 tabs)
///   upsolve screen (2 tabs)
///   friends screen (3 tabs)
///
/// Usage:
/// SegmentedTab(
///   tabs: ['Upcoming', 'Live', 'All'],
///   currentIndex: _index,
///   onChanged: (i) => setState(
///     () => _index = i,
///   ),
/// )
class SegmentedTab extends StatelessWidget {
  const SegmentedTab({
    super.key,
    required this.tabs,
    required this.currentIndex,
    required this.onChanged,
  });

  final List<String> tabs;
  final int currentIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.10),
          width: 1.0,
        ),
      ),
      child: Row(
        children: List.generate(
          tabs.length,
          (index) => Expanded(
            child: _TabItem(
              label: tabs[index],
              isActive: index == currentIndex,
              onTap: () => onChanged(index),
            ),
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────
// TAB ITEM
// Individual tab button
// ──────────────────────────────

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 200,
        ),
        margin: EdgeInsets.all(3.r),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary.withValues(alpha: 0.20)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: isActive
              ? Border.all(
                  color: AppColors.primary.withValues(
                    alpha: 0.40,
                  ),
                  width: 1.0,
                )
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: isActive
                  ? AppColors.primary
                  : Colors.white.withValues(
                      alpha: 0.50,
                    ),
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
