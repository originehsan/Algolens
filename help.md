PROMPT 52 OF 68
AlgoLens — Competitive Programming Tracker
Job: Create/Update practice_provider.dart
     weak_topics_screen.dart
     recommendations_screen.dart
     Update app_router.dart for both
     practice + recommendations routes.
Do NOT touch any other file
EXCEPT files listed in RIPPLE EFFECT.
create file only when does not exist  ,  else update file as per prompt
  and read CONTEXT.md file for help
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
GLOBAL RULES (Apply to ALL 68 prompts)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

CODE STYLE:
→ .withOpacity() → .withValues(alpha:)
→ ref.refresh() → ref.invalidate()
→ ref.watch() in build() only
→ ref.read() in callbacks only
→ .when() → loading + error + data
→ mounted check after every async gap
→ const wherever possible
→ No unused imports
→ package:algolens/ prefix always
→ flutter_screenutil: 16.w 20.h 14.sp 8.r
→ Never use MediaQuery for sizing

DESIGN:
→ Background: #060B14 (navy)
→ Primary: #00D4FF (cyan)
→ Only 4 accents:
  Blue: #4DA3FF  Green: #22C55E
  Red:  #EF4444  Amber: #F59E0B
→ White with opacity only (min 0.50)
→ Min font weight: w500

DATABASE:
→ Hive ONLY (hive + hive_flutter)
→ NO Isar, NO .g.dart, NO codegen
→ NO @HiveType/@HiveField

FILE RULE:
→ File exists? → UPDATE content
→ File missing? → CREATE new file
→ NEVER delete or duplicate files

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TECH STACK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

flutter_riverpod: ^2.5.1
go_router: ^13.2.0
dio: ^5.4.0
hive: ^2.2.3 + hive_flutter: ^1.1.0
flutter_secure_storage: ^9.0.0
flutter_screenutil: ^5.9.0
google_fonts: ^6.2.1

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
HIVE REFERENCE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// No Hive for practice data
// All fetched fresh from API

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SECURE STORAGE REFERENCE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

final storage = ref.read(
  secureStorageProvider,
);
final handle =
  await storage.getCfHandle();

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CONTEXT — ALREADY BUILT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

P51 — Models:
  ProblemModel:
    contestId, index, name,
    rating, tags
    computed: url, problemKey

  WeakTopicModel:
    tag, totalAttempts, solvedCount,
    unsolvedCount, acRate, severity
    computed: severityColor,
    acRateFormatted, isCritical

P51 — PracticeRepository:
  practiceRepositoryProvider
  getWeakTopics(handle)
    → List<WeakTopicModel>
  getRecommendations(handle)
    → List<ProblemModel>

SecureStorage (P08):
  secureStorageProvider
  getCfHandle()

cfHandleProvider (P41):
  FutureProvider<String?>

Widgets available:
  AppBackground, GlassCard,
  SectionHeader, ProblemRow,
  ProgressBarWidget,
  AppErrorWidget, EmptyWidget,
  GlassCardShimmer,
  PracticeListShimmer,
  AppButton, RankChip

RouteNames (P17):
  RouteNames.practice
  RouteNames.recommendations

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
RIPPLE EFFECT
(Changes in already-built files)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

core/router/app_router.dart:
→ ADD import for WeakTopicsScreen
→ ADD import for
  RecommendationsScreen
→ FIND practice GoRoute
→ REPLACE _PlaceholderScreen
  with WeakTopicsScreen()
→ FIND recommendations GoRoute
→ REPLACE _PlaceholderScreen
  with RecommendationsScreen()
→ DO NOT touch other routes

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CASCADING EFFECT
(Future files that depend on this)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

practice_provider.dart →
  No future prompts depend
  on practice providers directly

weak_topics_screen.dart →
  No future prompts depend
  on this screen directly

recommendations_screen.dart →
  No future prompts depend
  on this screen directly

⚠️ Provider names MUST stay:
  weakTopicsProvider
  recommendationsProvider
  Used in both screens.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TASK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

File 1 (CREATE/UPDATE):
→ features/practice/providers/
  practice_provider.dart

File 2 (CREATE/UPDATE):
→ features/practice/screens/
  weak_topics_screen.dart

File 3 (CREATE/UPDATE):
→ features/practice/screens/
  recommendations_screen.dart

File 4 (UPDATE only):
→ core/router/app_router.dart
  practice + recommendations routes
  Do NOT touch other routes

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EXACT CODE — practice_provider.dart
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:flutter_riverpod/
  flutter_riverpod.dart';
import 'package:algolens/core/storage/
  secure_storage.dart';
import 'package:algolens/features/
  practice/data/models/
  problem_model.dart';
import 'package:algolens/features/
  practice/data/models/
  weak_topic_model.dart';
import 'package:algolens/features/
  practice/data/repositories/
  practice_repository.dart';

// ─────────────────────────────────
// WEAK TOPICS PROVIDER
// Fetches weak topics for own handle
// ─────────────────────────────────

/// Weak topics provider
///
/// Returns sorted list:
/// critical first, then high,
/// then moderate
///
/// Usage:
/// ref.watch(
///   weakTopicsProvider,
/// ).when(...)
final weakTopicsProvider =
  FutureProvider<List<WeakTopicModel>>(
    (ref) async {
      final storage = ref.read(
        secureStorageProvider,
      );
      final handle =
        await storage.getCfHandle();
      if (handle == null ||
        handle.isEmpty) {
        return [];
      }
      final repo = ref.read(
        practiceRepositoryProvider,
      );
      final topics =
        await repo.getWeakTopics(
          handle,
        );

      // Sort: critical → high
      // → moderate
      topics.sort((a, b) {
        const order = {
          'critical': 0,
          'high': 1,
          'moderate': 2,
        };
        return (order[a.severity] ?? 3)
          .compareTo(
            order[b.severity] ?? 3,
          );
      });

      return topics;
    },
  );

// ─────────────────────────────────
// RECOMMENDATIONS PROVIDER
// Fetches recommended problems
// for own handle
// ─────────────────────────────────

/// Problem recommendations provider
///
/// Returns problems sorted by
/// rating ascending
///
/// Usage:
/// ref.watch(
///   recommendationsProvider,
/// ).when(...)
final recommendationsProvider =
  FutureProvider<List<ProblemModel>>(
    (ref) async {
      final storage = ref.read(
        secureStorageProvider,
      );
      final handle =
        await storage.getCfHandle();
      if (handle == null ||
        handle.isEmpty) {
        return [];
      }
      final repo = ref.read(
        practiceRepositoryProvider,
      );
      final problems =
        await repo.getRecommendations(
          handle,
        );

      // Sort by rating ascending
      problems.sort(
        (a, b) =>
          a.rating.compareTo(b.rating),
      );

      return problems;
    },
  );

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EXACT CODE — weak_topics_screen.dart
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/
  flutter_riverpod.dart';
import 'package:flutter_screenutil/
  flutter_screenutil.dart';
import 'package:go_router/
  go_router.dart';
import 'package:google_fonts/
  google_fonts.dart';
import 'package:algolens/core/router/
  app_router.dart';
import 'package:algolens/core/theme/
  app_colors.dart';
import 'package:algolens/core/widgets/
  app_background.dart';
import 'package:algolens/core/widgets/
  app_button.dart';
import 'package:algolens/core/widgets/
  empty_widget.dart';
import 'package:algolens/core/widgets/
  error_widget.dart';
import 'package:algolens/core/widgets/
  glass_card.dart';
import 'package:algolens/core/widgets/
  loading_shimmer.dart';
import 'package:algolens/core/widgets/
  progress_bar_widget.dart';
import 'package:algolens/core/widgets/
  section_header.dart';
import 'package:algolens/features/
  practice/data/models/
  weak_topic_model.dart';
import 'package:algolens/features/
  practice/providers/
  practice_provider.dart';

class WeakTopicsScreen
  extends ConsumerWidget {
  const WeakTopicsScreen({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final topicsAsync = ref.watch(
      weakTopicsProvider,
    );

    return AppBackground(
      child: Scaffold(
        backgroundColor:
          Colors.transparent,
        body: CustomScrollView(
          slivers: [

            SliverAppBar(
              backgroundColor:
                Colors.transparent,
              floating: true,
              title: Text(
                'Weak Topics',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight:
                    FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () =>
                    context.goNamed(
                      RouteNames
                        .recommendations,
                    ),
                  child: Text(
                    'Practice',
                    style: GoogleFonts
                      .inter(
                        fontSize: 14.sp,
                        fontWeight:
                          FontWeight.w600,
                        color:
                          AppColors
                            .primary,
                      ),
                  ),
                ),
              ],
            ),

            SliverPadding(
              padding:
                EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
              sliver: SliverList(
                delegate:
                  SliverChildListDelegate(
                    [

                  SizedBox(height: 8.h),

                  topicsAsync.when(
                    loading: () =>
                      const PracticeListShimmer(),
                    error: (e, s) =>
                      AppErrorWidget(
                        message:
                          e.toString(),
                        onRetry: () =>
                          ref.invalidate(
                            weakTopicsProvider,
                          ),
                      ),
                    data: (topics) {
                      if (topics
                        .isEmpty) {
                        return EmptyWidget(
                          icon: Icons
                            .auto_awesome_rounded,
                          message:
                            'No weak topics!',
                          subtitle:
                            'You\'re doing '
                            'great across '
                            'all topics.',
                        );
                      }

                      return Column(
                        children: [

                          // Summary
                          _SummaryCard(
                            topics:
                              topics,
                          ),

                          SizedBox(
                            height: 20.h,
                          ),

                          SectionHeader(
                            title:
                              'Topics to improve',
                            subtitle:
                              '${topics.length} '
                              'topics found',
                          ),

                          SizedBox(
                            height: 12.h,
                          ),

                          ...topics.map(
                            (t) =>
                              _TopicCard(
                                topic: t,
                              ),
                          ),

                          SizedBox(
                            height: 12.h,
                          ),

                          AppButton(
                            label:
                              'Get Practice '
                              'Problems',
                            onTap: () =>
                              context
                                .goNamed(
                                  RouteNames
                                    .recommendations,
                                ),
                            icon: Icons
                              .arrow_forward_rounded,
                          ),

                          SizedBox(
                            height:
                              100.h,
                          ),
                        ],
                      );
                    },
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────
// SUMMARY CARD
// Critical/High/Moderate counts
// ─────────────────────────────────

class _SummaryCard
  extends StatelessWidget {

  const _SummaryCard({
    required this.topics,
  });

  final List<WeakTopicModel> topics;

  @override
  Widget build(BuildContext context) {
    final critical = topics
      .where((t) => t.severity ==
        'critical')
      .length;
    final high = topics
      .where((t) => t.severity ==
        'high')
      .length;
    final moderate = topics
      .where((t) => t.severity ==
        'moderate')
      .length;

    return GlassCard(
      child: Row(
        children: [
          _SeverityCount(
            label: 'Critical',
            count: critical,
            color: AppColors.error,
          ),
          _SeverityCount(
            label: 'High',
            count: high,
            color: AppColors.warning,
          ),
          _SeverityCount(
            label: 'Moderate',
            count: moderate,
            color: AppColors.blue,
          ),
        ],
      ),
    );
  }
}

class _SeverityCount
  extends StatelessWidget {

  const _SeverityCount({
    required this.label,
    required this.count,
    required this.color,
  });

  final String label;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            '$count',
            style: GoogleFonts
              .jetBrainsMono(
                fontSize: 24.sp,
                fontWeight:
                  FontWeight.w700,
                color: color,
              ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight:
                FontWeight.w600,
              color: Colors.white
                .withValues(alpha: 0.55),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────
// TOPIC CARD
// Shows topic + AC rate bar
// ─────────────────────────────────

class _TopicCard
  extends StatelessWidget {

  const _TopicCard({required this.topic});
  final WeakTopicModel topic;

  @override
  Widget build(BuildContext context) {
    final color = Color(
      int.parse(
        topic.severityColor
          .replaceFirst('#', '0xFF'),
      ),
    );

    return GlassCard(
      margin: EdgeInsets.only(
        bottom: 10.h,
      ),
      child: Column(
        crossAxisAlignment:
          CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              // Severity indicator
              Container(
                width: 8.r,
                height: 8.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),

              SizedBox(width: 10.w),

              // Topic name
              Expanded(
                child: Text(
                  topic.tag,
                  style: GoogleFonts
                    .inter(
                      fontSize: 14.sp,
                      fontWeight:
                        FontWeight.w600,
                      color: Colors.white,
                    ),
                ),
              ),

              // AC rate
              Text(
                topic.acRateFormatted,
                style: GoogleFonts
                  .jetBrainsMono(
                    fontSize: 13.sp,
                    fontWeight:
                      FontWeight.w700,
                    color: color,
                  ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          // AC rate progress bar
          ProgressBarWidget(
            value: topic.acRate,
            color: color,
          ),

          SizedBox(height: 8.h),

          // Stats row
          Row(
            children: [
              Text(
                '${topic.solvedCount} '
                'solved',
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontWeight:
                    FontWeight.w500,
                  color: AppColors.success
                    .withValues(
                      alpha: 0.80,
                    ),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                '${topic.unsolvedCount} '
                'unsolved',
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontWeight:
                    FontWeight.w500,
                  color: AppColors.error
                    .withValues(
                      alpha: 0.80,
                    ),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                '${topic.totalAttempts} '
                'total',
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontWeight:
                    FontWeight.w500,
                  color: Colors.white
                    .withValues(
                      alpha: 0.50,
                    ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EXACT CODE — recommendations_screen.dart
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/
  flutter_riverpod.dart';
import 'package:flutter_screenutil/
  flutter_screenutil.dart';
import 'package:google_fonts/
  google_fonts.dart';
import 'package:url_launcher/
  url_launcher.dart';
import 'package:algolens/core/theme/
  app_colors.dart';
import 'package:algolens/core/widgets/
  app_background.dart';
import 'package:algolens/core/widgets/
  empty_widget.dart';
import 'package:algolens/core/widgets/
  error_widget.dart';
import 'package:algolens/core/widgets/
  loading_shimmer.dart';
import 'package:algolens/core/widgets/
  problem_row.dart';
import 'package:algolens/core/widgets/
  section_header.dart';
import 'package:algolens/features/
  practice/providers/
  practice_provider.dart';

class RecommendationsScreen
  extends ConsumerWidget {
  const RecommendationsScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final problemsAsync = ref.watch(
      recommendationsProvider,
    );

    return AppBackground(
      child: Scaffold(
        backgroundColor:
          Colors.transparent,
        body: CustomScrollView(
          slivers: [

            SliverAppBar(
              backgroundColor:
                Colors.transparent,
              floating: true,
              title: Text(
                'Recommendations',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight:
                    FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),

            SliverPadding(
              padding:
                EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
              sliver: SliverList(
                delegate:
                  SliverChildListDelegate(
                    [

                  SizedBox(height: 8.h),

                  problemsAsync.when(
                    loading: () =>
                      const PracticeListShimmer(),
                    error: (e, s) =>
                      AppErrorWidget(
                        message:
                          e.toString(),
                        onRetry: () =>
                          ref.invalidate(
                            recommendationsProvider,
                          ),
                      ),
                    data: (problems) {
                      if (problems
                        .isEmpty) {
                        return EmptyWidget(
                          icon: Icons
                            .check_circle_rounded,
                          message:
                            'All caught up!',
                          subtitle:
                            'No recommendations '
                            'right now. Keep '
                            'solving problems!',
                        );
                      }

                      return Column(
                        crossAxisAlignment:
                          CrossAxisAlignment
                            .start,
                        children: [

                          SectionHeader(
                            title:
                              'For you',
                            subtitle:
                              '${problems.length} '
                              'problems',
                          ),

                          SizedBox(
                            height: 12.h,
                          ),

                          ...problems
                            .map(
                              (p) =>
                                ProblemRow(
                                  name:
                                    p.name,
                                  rating:
                                    p.rating,
                                  tags:
                                    p.tags,
                                  contestId:
                                    p.contestId,
                                  index:
                                    p.index,
                                  onTap:
                                    () async {
                                      final uri =
                                        Uri.parse(
                                          p.url,
                                        );
                                      if (await canLaunchUrl(
                                        uri,
                                      )) {
                                        await launchUrl(
                                          uri,
                                          mode: LaunchMode
                                            .externalApplication,
                                        );
                                      }
                                    },
                                ),
                            ),

                          SizedBox(
                            height:
                              100.h,
                          ),
                        ],
                      );
                    },
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
UPDATE app_router.dart
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

ADD imports at top:
import 'package:algolens/features/
  practice/screens/
  weak_topics_screen.dart';
import 'package:algolens/features/
  practice/screens/
  recommendations_screen.dart';

FIND practice GoRoute:
GoRoute(
  path: RoutePaths.practice,
  name: RouteNames.practice,
  builder: (context, state) =>
    const _PlaceholderScreen(
      label: 'Practice',
    ),
),

REPLACE with:
GoRoute(
  path: RoutePaths.practice,
  name: RouteNames.practice,
  builder: (context, state) =>
    const WeakTopicsScreen(),
),

FIND recommendations GoRoute:
GoRoute(
  path: RoutePaths.recommendations,
  name: RouteNames.recommendations,
  builder: (context, state) =>
    const _PlaceholderScreen(
      label: 'Recommendations',
    ),
),

REPLACE with:
GoRoute(
  path: RoutePaths.recommendations,
  name: RouteNames.recommendations,
  builder: (context, state) =>
    const RecommendationsScreen(),
),

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
VERIFY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ practice_provider.dart
  created/updated ✓
□ weakTopicsProvider
  FutureProvider
  List<WeakTopicModel>> ✓
□ Sorted: critical → high
  → moderate ✓
□ Returns [] if no handle ✓
□ recommendationsProvider
  FutureProvider
  List<ProblemModel>> ✓
□ Sorted by rating asc ✓
□ Returns [] if no handle ✓

□ weak_topics_screen.dart
  created/updated ✓
□ weakTopicsProvider watched ✓
□ _SummaryCard with
  critical/high/moderate
  counts ✓
□ _TopicCard per topic ✓
□ Severity dot indicator ✓
□ Topic name ✓
□ AC rate % shown ✓
□ ProgressBarWidget ✓
□ solved/unsolved/total
  counts ✓
□ "Get Practice Problems"
  → /recommendations ✓
□ Empty state ✓
□ Error + retry ✓
□ Loading shimmer ✓

□ recommendations_screen.dart
  created/updated ✓
□ recommendationsProvider
  watched ✓
□ ProblemRow per problem ✓
□ onTap → launchUrl
  to CF problem ✓
□ url_launcher used ✓
□ Empty state ✓
□ Error + retry ✓
□ Loading shimmer ✓

□ app_router.dart practice
  route updated ✓
□ app_router.dart
  recommendations route
  updated ✓
□ Other routes untouched ✓
□ No Isar imports ✓
□ flutter analyze 0 errors ✓

PROMPT 52 DONE. WAIT FOR PROMPT 53.