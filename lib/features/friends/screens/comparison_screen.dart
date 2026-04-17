import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/page_wrapper.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/app_text_field.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/rank_chip.dart';
import 'package:algolens/core/widgets/user_avatar.dart';
import 'package:algolens/core/widgets/loading_shimmer.dart';
import 'package:algolens/features/friends/data/repositories/friends_repository.dart';

class ComparisonScreen extends ConsumerStatefulWidget {
  const ComparisonScreen({super.key});

  @override
  ConsumerState<ComparisonScreen> createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends ConsumerState<ComparisonScreen> {
  final _handle1Controller = TextEditingController();
  final _handle2Controller = TextEditingController();
  Map<String, dynamic>? _comparisonData;
  bool _isLoading = false;

  @override
  void dispose() {
    _handle1Controller.dispose();
    _handle2Controller.dispose();
    super.dispose();
  }

  Future<void> _compare() async {
    if (_handle1Controller.text.isEmpty || _handle2Controller.text.isEmpty) {
      return;
    }
    setState(() {
      _isLoading = true;
      _comparisonData = null;
    });
    try {
      final data = await FriendsRepository().compareRating(
        handle1: _handle1Controller.text.trim(),
        handle2: _handle2Controller.text.trim(),
      );
      setState(() {
        _comparisonData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: 'Compare',
      showBackButton: true,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),

            // Input card
            GlassCard(
              child: Column(
                children: [
                  AppTextField(
                    hint: 'First CF handle',
                    controller: _handle1Controller,
                    prefixIcon: const Icon(
                      Icons.person_outlined,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.compare_arrows_rounded,
                        color: AppColors.primary,
                        size: 24.r,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  AppTextField(
                    hint: 'Second CF handle',
                    controller: _handle2Controller,
                    prefixIcon: const Icon(
                      Icons.person_outlined,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  AppButton(
                    label: 'Compare',
                    onPressed: _compare,
                    isLoading: _isLoading,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Results
            if (_isLoading)
              ShimmerCard(height: 300.h)
            else if (_comparisonData != null)
              _buildComparisonResult(_comparisonData!),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonResult(Map<String, dynamic> data) {
    final handle1 = data['handle1'] as String;
    final handle2 = data['handle2'] as String;
    final rating1 = data['rating1'] as int;
    final rating2 = data['rating2'] as int;
    final maxRating1 = data['maxRating1'] as int;
    final maxRating2 = data['maxRating2'] as int;
    final rank1 = data['rank1'] as String;
    final rank2 = data['rank2'] as String;
    final contests1 = data['contestsParticipated1'] as int;
    final contests2 = data['contestsParticipated2'] as int;
    final higher = data['higherRatedHandle'] as String;

    return Column(
      children: [
        // Header comparison
        GlassCard(
          borderColor: AppColors.primary.withValues(alpha: 0.40),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    UserAvatar(
                      handle: handle1,
                      rank: rank1,
                      size: 48.r,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      handle1,
                      style: AppTextStyles.bodyBold,
                      textAlign: TextAlign.center,
                    ),
                    RankChip(
                      rank: rank1,
                      small: true,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'VS',
                  style: AppTextStyles.h2.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    UserAvatar(
                      handle: handle2,
                      rank: rank2,
                      size: 48.r,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      handle2,
                      style: AppTextStyles.bodyBold,
                      textAlign: TextAlign.center,
                    ),
                    RankChip(
                      rank: rank2,
                      small: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),

        // Stats comparison
        _buildCompareRow(
          'Current Rating',
          rating1.toString(),
          rating2.toString(),
          rating1 > rating2,
          rating1 < rating2,
          isMonospace: true,
        ),
        SizedBox(height: 8.h),
        _buildCompareRow(
          'Max Rating',
          maxRating1.toString(),
          maxRating2.toString(),
          maxRating1 > maxRating2,
          maxRating1 < maxRating2,
          isMonospace: true,
        ),
        SizedBox(height: 8.h),
        _buildCompareRow(
          'Contests',
          contests1.toString(),
          contests2.toString(),
          contests1 > contests2,
          contests1 < contests2,
          isMonospace: true,
        ),
        SizedBox(height: 16.h),

        // Winner card
        GlassCard(
          borderColor: AppColors.success.withValues(alpha: 0.40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '🏆',
                style: TextStyle(fontSize: 24.sp),
              ),
              SizedBox(width: 10.w),
              Column(
                children: [
                  Text(
                    'Higher Rated',
                    style: AppTextStyles.caption,
                  ),
                  Text(
                    higher,
                    style: AppTextStyles.h2.copyWith(
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 100.h),
      ],
    );
  }

  Widget _buildCompareRow(
    String label,
    String value1,
    String value2,
    bool first1Higher,
    bool first2Higher, {
    bool isMonospace = false,
  }) {
    return GlassCard(
      padding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 12.h,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value1,
              style: isMonospace
                  ? AppTextStyles.metricSmall.copyWith(
                      color: first1Higher
                          ? AppColors.success
                          : AppColors.textSecondary,
                      fontSize: 16.sp,
                    )
                  : AppTextStyles.bodyBold.copyWith(
                      color: first1Higher
                          ? AppColors.success
                          : AppColors.textSecondary,
                    ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              value2,
              style: isMonospace
                  ? AppTextStyles.metricSmall.copyWith(
                      color: first2Higher
                          ? AppColors.success
                          : AppColors.textSecondary,
                      fontSize: 16.sp,
                    )
                  : AppTextStyles.bodyBold.copyWith(
                      color: first2Higher
                          ? AppColors.success
                          : AppColors.textSecondary,
                    ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
