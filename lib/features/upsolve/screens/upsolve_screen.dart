import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/empty_widget.dart';
import 'package:algolens/core/widgets/error_widget.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/loading_shimmer.dart';
import 'package:algolens/core/widgets/segmented_tab.dart';
import 'package:algolens/features/upsolve/data/models/upsolve_model.dart';
import 'package:algolens/features/upsolve/providers/upsolve_provider.dart';

class UpsolveScreen extends ConsumerStatefulWidget {
  const UpsolveScreen({super.key});

  @override
  ConsumerState<UpsolveScreen> createState() => _UpsolveScreenState();
}

class _UpsolveScreenState extends ConsumerState<UpsolveScreen> {
  // 0 = Pending tab, 1 = Solved tab
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final upsolveAsync = ref.watch(upsolveProvider);

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              floating: true,
              title: Text('Upsolve', style: AppTextStyles.h2),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: 8.h),

                  // Tab switcher — filters list by isCompleted flag
                  SegmentedTab(
                    tabs: const ['Pending', 'Solved'],
                    currentIndex: _tabIndex,
                    onChanged: (i) => setState(() => _tabIndex = i),
                  ),

                  SizedBox(height: 16.h),

                  upsolveAsync.when(
                    loading: () => const PracticeListShimmer(),
                    error: (e, s) => AppErrorWidget(
                      message: e.toString(),
                      onRetry: () => ref.invalidate(upsolveProvider),
                    ),
                    data: (all) {
                      // Filter by tab — Pending = not done, Solved = done
                      final filtered = _tabIndex == 0
                          ? all.where((p) => !p.isCompleted).toList()
                          : all.where((p) => p.isCompleted).toList();

                      if (filtered.isEmpty) {
                        return _tabIndex == 0
                            ? const EmptyWidget(
                                icon: Icons.check_circle_rounded,
                                message: 'All done!',
                                subtitle: 'No pending upsolves.',
                              )
                            : const EmptyWidget(
                                icon: Icons.hourglass_empty_rounded,
                                message: 'Nothing solved yet',
                                subtitle:
                                    'Mark problems as done to see them here.',
                              );
                      }

                      return Column(
                        children: filtered
                            .map((p) => _UpsolveCard(item: p))
                            .toList(),
                      );
                    },
                  ),

                  SizedBox(height: 100.h),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UpsolveCard extends ConsumerWidget {
  const _UpsolveCard({required this.item});
  final UpsolveModel item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch only this problem's toggle state to avoid full rebuild
    final isToggling = ref.watch(
      toggleUpsolveProvider.select((s) => s.contains(item.problemKey)),
    );

    return GlassCard(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circle checkmark — tap to toggle done state in Hive
          GestureDetector(
            onTap: isToggling
                ? null
                : () => ref
                    .read(toggleUpsolveProvider.notifier)
                    .toggle(item.problemKey),
            child: Container(
              width: 28.r,
              height: 28.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: item.isCompleted
                    ? AppColors.success.withValues(alpha: 0.20)
                    : Colors.white.withValues(alpha: 0.06),
                border: Border.all(
                  color: item.isCompleted
                      ? AppColors.success
                      : Colors.white.withValues(alpha: 0.20),
                  width: 1.5,
                ),
              ),
              child: isToggling
                  ? Padding(
                      padding: EdgeInsets.all(6.r),
                      child: const CircularProgressIndicator(
                        strokeWidth: 1.5,
                        color: AppColors.success,
                      ),
                    )
                  : item.isCompleted
                      ? Icon(
                          Icons.check_rounded,
                          color: AppColors.success,
                          size: 16.r,
                        )
                      : null,
            ),
          ),

          SizedBox(width: 12.w),

          // Problem details — tap opens CF problem in browser
          Expanded(
            child: GestureDetector(
              onTap: () async {
                final uri = Uri.parse(item.url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Strike-through text when problem is marked done
                  Text(
                    item.name,
                    style: AppTextStyles.bodyBold.copyWith(
                      color: item.isCompleted
                          ? Colors.white.withValues(alpha: 0.50)
                          : Colors.white,
                      decoration: item.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),

                  SizedBox(height: 6.h),

                  // Rating + verdict + weak topic badges
                  Wrap(
                    spacing: 6.w,
                    runSpacing: 4.h,
                    children: [
                      _Badge(
                        label: '${item.rating}',
                        color: AppColors.primary,
                      ),
                      // Only show verdict if available
                      if (item.bestVerdict.isNotEmpty)
                        _Badge(
                          label: item.verdictLabel,
                          color: AppColors.danger,
                        ),
                      // Highlight if this is a known weak topic
                      if (item.isWeakTopic)
                      const  _Badge(
                          label: 'Weak Topic',
                          color: AppColors.warning,
                        ),
                    ],
                  ),

                  // Show max 3 tags to avoid overflow
                  if (item.tags.isNotEmpty) ...[
                    SizedBox(height: 6.h),
                    Wrap(
                      spacing: 4.w,
                      runSpacing: 4.h,
                      children: item.tags
                          .take(3)
                          .map((t) => _Badge(
                                label: t,
                                color: Colors.white.withValues(alpha: 0.30),
                                small: true,
                              ))
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.label,
    required this.color,
    this.small = false,
  });

  final String label;
  final Color color;
  final bool small;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 6.w : 8.w,
        vertical: small ? 2.h : 3.h,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: color.withValues(alpha: 0.30),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          fontSize: small ? 10.sp : 11.sp,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}