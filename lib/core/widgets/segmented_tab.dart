import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';

class SegmentedTab extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabSelected;
  final List<Color>? activeColors;

  const SegmentedTab({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    this.activeColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.10),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          tabs.length,
          (index) {
            final isSelected = index == selectedIndex;
            final activeColor =
                activeColors != null && index < activeColors!.length
                    ? activeColors![index]
                    : AppColors.primary;

            return GestureDetector(
              onTap: () => onTabSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? activeColor.withOpacity(0.20)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                  border: isSelected
                      ? Border.all(
                          color: activeColor.withOpacity(0.40),
                          width: 1.0,
                        )
                      : null,
                ),
                child: Text(
                  tabs[index],
                  style: isSelected
                      ? AppTextStyles.captionBold.copyWith(
                          color: activeColor,
                        )
                      : AppTextStyles.caption,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
