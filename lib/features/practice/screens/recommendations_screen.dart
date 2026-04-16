import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/page_wrapper.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/segmented_tab.dart';
import 'package:algolens/core/widgets/problem_row.dart';
import 'package:algolens/core/widgets/loading_shimmer.dart';
import 'package:algolens/core/widgets/error_widget.dart';
import 'package:algolens/core/widgets/empty_widget.dart';
import 'package:algolens/features/auth/providers/auth_provider.dart';
import 'package:algolens/features/practice/providers/practice_provider.dart';

class RecommendationsScreen extends ConsumerStatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  ConsumerState<RecommendationsScreen> createState() =>
      _RecommendationsScreenState();
}

class _RecommendationsScreenState extends ConsumerState<RecommendationsScreen> {
  int _selectedTopicIndex = 0;

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final handle = authState.handle ?? 'ehsan_cf';
    final blindMode = ref.watch(blindModeProvider);
    final recommendationsAsync = ref.watch(recommendationsProvider(handle));

    return PageWrapper(
      title: 'Recommendations',
      showBackButton: true,
      child: Column(
        children: [
          // Blind mode toggle
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 8.h,
            ),
            child: GlassCard(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 10.h,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.visibility_off_outlined,
                    color: AppColors.textMuted,
                    size: 18.r,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Blind Mode',
                    style: AppTextStyles.bodyBold,
                  ),
                  Text(
                    ' — Hide problem names',
                    style: AppTextStyles.caption,
                  ),
                  const Spacer(),
                  Switch(
                    value: blindMode,
                    onChanged: (value) {
                      ref.read(blindModeProvider.notifier).state = value;
                    },
                    activeColor: AppColors.primary,
                    activeTrackColor: AppColors.primary.withValues(alpha: 0.30),
                    inactiveThumbColor: AppColors.textMuted,
                    inactiveTrackColor: Colors.white.withValues(alpha: 0.10),
                  ),
                ],
              ),
            ),
          ),

          // Content
          Expanded(
            child: recommendationsAsync.when(
              loading: () => const ShimmerList(
                count: 5,
              ),
              error: (error, _) => AppErrorWidget(
                message: error.toString(),
                onRetry: () => ref.refresh(
                  recommendationsProvider(handle),
                ),
              ),
              data: (problems) {
                if (problems.isEmpty) {
                  return const AppEmptyWidget(
                    title: 'No Recommendations',
                    subtitle: 'Solve more problems to get recommendations',
                    icon: Icons.lightbulb_outline_rounded,
                  );
                }

                // Get unique tags for filter
                final allTags = problems.expand((p) => p.tags).toSet().toList();
                final tabs = ['All', ...allTags];

                // Filter problems
                final filteredProblems = _selectedTopicIndex == 0
                    ? problems
                    : problems
                        .where(
                            (p) => p.tags.contains(tabs[_selectedTopicIndex]))
                        .toList();

                return Column(
                  children: [
                    // Topic filter tabs
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 8.h,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SegmentedTab(
                          tabs: tabs.length > 5 ? tabs.take(5).toList() : tabs,
                          selectedIndex: _selectedTopicIndex,
                          onTabSelected: (index) {
                            setState(() {
                              _selectedTopicIndex = index;
                            });
                          },
                        ),
                      ),
                    ),

                    // Problems list
                    Expanded(
                      child: filteredProblems.isEmpty
                          ? const AppEmptyWidget(
                              title: 'No Problems Found',
                              subtitle: 'No problems for this topic filter',
                            )
                          : ListView.builder(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                              ),
                              itemCount: filteredProblems.length,
                              itemBuilder: (context, index) {
                                final problem = filteredProblems[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10.h,
                                  ),
                                  child: ProblemRow(
                                    problem: problem,
                                    blindMode: blindMode,
                                    onTap: () => _launchUrl(
                                      problem.cfUrl,
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
