PROMPT 44 OF 68
AlgoLens — Competitive Programming Tracker
Job: Create/Update home_screen.dart
     Update app_router.dart home
     route to use real screen.
Do NOT touch any other file
EXCEPT files listed in RIPPLE EFFECT.
create file only when does not exist  ,  else update file as per prompt
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
flutter_card_swiper: ^7.0.1

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
HIVE REFERENCE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// Dismissed contests managed by
// dismissContestProvider (P43)
// No direct Hive access here

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SECURE STORAGE REFERENCE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// Handle read via cfHandleProvider
// No direct SecureStorage here

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CONTEXT — ALREADY BUILT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

P39 — ProfileModel:
  handle, rating, maxRating, rank,
  problemsSolved, contestsParticipated,
  streakDays, avatar, ratingDelta

P41 — Providers:
  cfHandleProvider
    → FutureProvider<String?>
  profileProvider(handle)
    → FutureProvider.family

P43 — Home providers:
  homeReadinessProvider
    → FutureProvider<ReadinessScore>
  ratingDeltaProvider
    → FutureProvider<RatingDelta?>
  dismissContestProvider
    → StateNotifierProvider
        DismissContestNotifier,
        Set<int>>
    .dismiss(contestId)
    .isDismissed(contestId)

P43 — Home models:
  ReadinessScore:
    score (int 0-100)
    label (String)
    color (hex String)
  RatingDelta:
    delta (int)
    isPositive (bool)
    formatted (String)

Widgets available:
  AppBackground, MainScaffold,
  GlassCard, GlassCardType,
  UserAvatar, RankChip,
  StatCard, SectionHeader,
  ContestCard, CountdownTimer,
  OfflineBanner, StatsRowShimmer,
  GlassCardShimmer,
  AppErrorWidget

RouteNames (P17):
  RouteNames.profile
  RouteNames.contests
  RouteNames.upsolve
  RouteNames.practice

NOTE: ContestCard and upcoming
contests data comes from
upcomingContestsProvider which
is built in P46. For now use
placeholder contest swipe stack
with empty state if provider
not yet built.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
RIPPLE EFFECT
(Changes in already-built files)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

core/router/app_router.dart:
→ ADD import for HomeScreen
→ FIND home GoRoute
→ REPLACE _PlaceholderScreen
  with HomeScreen()
→ DO NOT touch other routes

No other already-built files
need changes for this prompt.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CASCADING EFFECT
(Future files that depend on this)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

home_screen.dart →
  P46 contest_provider.dart
    upcomingContestsProvider
    will replace the placeholder
    contest section here

  P59 notification_service.dart
    notification permission banner
    shown here

⚠️ home_screen uses MainScaffold
   which has bottom nav.
   DO NOT use PageWrapper here.
   Use MainScaffold as root.

⚠️ Avatar tap → /profile
   Already using RouteNames.profile

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SCREEN LAYOUT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Layout (top to bottom):
1. OfflineBanner (top)
2. Header row:
   "Hey, {handle} 👋" greeting
   + UserAvatar (taps → /profile)
3. Rating hero card:
   rating + rank + ratingDelta
   + readiness score bar
4. Stats row:
   Solved / Contests / Streak
5. "Upcoming Contests" section:
   Empty state if no contests yet
   (P46 will populate)
6. Pull to refresh

Loading states per section:
→ Profile: StatsRowShimmer
→ Each card: GlassCardShimmer

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TASK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

File 1 (CREATE/UPDATE):
→ features/home/screens/
  home_screen.dart

File 2 (UPDATE only):
→ core/router/app_router.dart
  home route only
  Do NOT touch other routes

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EXACT CODE — home_screen.dart
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
  glass_card.dart';
import 'package:algolens/core/widgets/
  loading_shimmer.dart';
import 'package:algolens/core/widgets/
  offline_banner.dart';
import 'package:algolens/core/widgets/
  rank_chip.dart';
import 'package:algolens/core/widgets/
  section_header.dart';
import 'package:algolens/core/widgets/
  stat_card.dart';
import 'package:algolens/core/widgets/
  user_avatar.dart';
import 'package:algolens/core/widgets/
  progress_bar_widget.dart';
import 'package:algolens/features/home/
  data/models/home_model.dart';
import 'package:algolens/features/home/
  providers/home_provider.dart';
import 'package:algolens/features/
  profile/data/models/
  profile_model.dart';
import 'package:algolens/features/
  profile/providers/
  profile_provider.dart';

class HomeScreen
  extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final handleAsync = ref.watch(
      cfHandleProvider,
    );

    return AppBackground(
      child: Scaffold(
        backgroundColor:
          Colors.transparent,
        body: Column(
          children: [

            // Offline banner
            // Always at top
            const OfflineBanner(),

            Expanded(
              child: handleAsync.when(
                loading: () =>
                  _LoadingBody(),
                error: (e, s) =>
                  _ErrorBody(
                    error: e.toString(),
                    onRetry: () =>
                      ref.invalidate(
                        cfHandleProvider,
                      ),
                  ),
                data: (handle) {
                  if (handle == null ||
                    handle.isEmpty) {
                    return _ErrorBody(
                      error:
                        'Handle not set',
                      onRetry: () =>
                        ref.invalidate(
                          cfHandleProvider,
                        ),
                    );
                  }
                  return _HomeBody(
                    handle: handle,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────
// HOME BODY
// Main content when handle loaded
// ─────────────────────────────────

class _HomeBody
  extends ConsumerWidget {

  const _HomeBody({
    required this.handle,
  });

  final String handle;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final profileAsync = ref.watch(
      profileProvider(handle),
    );
    final readinessAsync = ref.watch(
      homeReadinessProvider,
    );
    final deltaAsync = ref.watch(
      ratingDeltaProvider,
    );

    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.bgCard,
      onRefresh: () async {
        ref.invalidate(
          profileProvider(handle),
        );
        ref.invalidate(
          homeReadinessProvider,
        );
        ref.invalidate(
          ratingDeltaProvider,
        );
      },
      child: CustomScrollView(
        slivers: [

          SliverPadding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 16.h,
            ),
            sliver: SliverList(
              delegate:
                SliverChildListDelegate(
                  [

                // ──────────────────
                // HEADER
                // Greeting + Avatar
                // ──────────────────

                _Header(
                  handle: handle,
                  profileAsync:
                    profileAsync,
                  onAvatarTap: () =>
                    context.goNamed(
                      RouteNames.profile,
                    ),
                ),

                SizedBox(height: 20.h),

                // ──────────────────
                // RATING HERO CARD
                // Rating + readiness
                // ──────────────────

                profileAsync.when(
                  loading: () =>
                    GlassCardShimmer(
                      height: 140.h,
                    ),
                  error: (e, s) =>
                    const SizedBox
                      .shrink(),
                  data: (profile) =>
                    _RatingHeroCard(
                      profile: profile,
                      readinessAsync:
                        readinessAsync,
                      deltaAsync:
                        deltaAsync,
                    ),
                ),

                SizedBox(height: 16.h),

                // ──────────────────
                // STATS ROW
                // Solved/Contests/
                // Streak
                // ──────────────────

                profileAsync.when(
                  loading: () =>
                    const StatsRowShimmer(),
                  error: (e, s) =>
                    const SizedBox
                      .shrink(),
                  data: (profile) =>
                    _StatsRow(
                      profile: profile,
                    ),
                ),

                SizedBox(height: 24.h),

                // ──────────────────
                // UPCOMING CONTESTS
                // Empty until P46
                // ──────────────────

                SectionHeader(
                  title:
                    'Upcoming Contests',
                  actionLabel: 'See all',
                  onAction: () =>
                    context.goNamed(
                      RouteNames
                        .contests,
                    ),
                ),

                SizedBox(height: 12.h),

                // Placeholder until
                // upcomingContestsProvider
                // is built in P46
                GlassCard(
                  child: Center(
                    child: Padding(
                      padding:
                        EdgeInsets.all(
                          24.r,
                        ),
                      child: Column(
                        children: [
                          Icon(
                            Icons
                              .emoji_events_rounded,
                            color:
                              AppColors
                                .primary
                                .withValues(
                                  alpha:
                                    0.50,
                                ),
                            size: 32.r,
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Text(
                            'Contest data '
                            'coming soon',
                            style:
                              GoogleFonts
                              .inter(
                                fontSize:
                                  14.sp,
                                fontWeight:
                                  FontWeight
                                    .w500,
                                color:
                                  Colors
                                  .white
                                  .withValues(
                                    alpha:
                                      0.55,
                                  ),
                              ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 100.h),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────
// HEADER
// Greeting + avatar
// ─────────────────────────────────

class _Header extends StatelessWidget {

  const _Header({
    required this.handle,
    required this.profileAsync,
    required this.onAvatarTap,
  });

  final String handle;
  final AsyncValue<ProfileModel>
    profileAsync;
  final VoidCallback onAvatarTap;

  String _greeting() {
    final hour =
      DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 17) {
      return 'Good afternoon';
    }
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        // Greeting
        Expanded(
          child: Column(
            crossAxisAlignment:
              CrossAxisAlignment.start,
            children: [
              Text(
                _greeting(),
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight:
                    FontWeight.w500,
                  color: Colors.white
                    .withValues(
                      alpha: 0.55,
                    ),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                handle,
                style: GoogleFonts.inter(
                  fontSize: 22.sp,
                  fontWeight:
                    FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        // Avatar → profile
        profileAsync.when(
          loading: () => Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary
                .withValues(alpha: 0.15),
            ),
          ),
          error: (_, __) =>
            UserAvatar(
              handle: handle,
              rank: '',
              size: 44.r,
              onTap: onAvatarTap,
            ),
          data: (profile) =>
            UserAvatar(
              handle: profile.handle,
              rank: profile.rank,
              avatarUrl: profile.avatar,
              size: 44.r,
              onTap: onAvatarTap,
            ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────
// RATING HERO CARD
// Main rating display
// ─────────────────────────────────

class _RatingHeroCard
  extends StatelessWidget {

  const _RatingHeroCard({
    required this.profile,
    required this.readinessAsync,
    required this.deltaAsync,
  });

  final ProfileModel profile;
  final AsyncValue<ReadinessScore>
    readinessAsync;
  final AsyncValue<RatingDelta?>
    deltaAsync;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      type: GlassCardType.primary,
      child: Column(
        crossAxisAlignment:
          CrossAxisAlignment.start,
        children: [

          Row(
            crossAxisAlignment:
              CrossAxisAlignment.start,
            children: [

              // Rating number
              Column(
                crossAxisAlignment:
                  CrossAxisAlignment
                    .start,
                children: [
                  Text(
                    'Rating',
                    style: GoogleFonts
                      .inter(
                        fontSize: 12.sp,
                        fontWeight:
                          FontWeight.w500,
                        color: Colors
                          .white
                          .withValues(
                            alpha: 0.55,
                          ),
                      ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${profile.rating}',
                    style: GoogleFonts
                      .jetBrainsMono(
                        fontSize: 36.sp,
                        fontWeight:
                          FontWeight.w700,
                        color:
                          AppColors
                            .primary,
                      ),
                  ),
                ],
              ),

              const Spacer(),

              // Rank + delta
              Column(
                crossAxisAlignment:
                  CrossAxisAlignment
                    .end,
                children: [

                  RankChip(
                    rank: profile.rank,
                  ),

                  SizedBox(height: 8.h),

                  deltaAsync.when(
                    loading: () =>
                      const SizedBox
                        .shrink(),
                    error: (_, __) =>
                      const SizedBox
                        .shrink(),
                    data: (delta) {
                      if (delta == null) {
                        return const
                          SizedBox
                            .shrink();
                      }
                      return Text(
                        delta.formatted,
                        style: GoogleFonts
                          .jetBrainsMono(
                            fontSize:
                              14.sp,
                            fontWeight:
                              FontWeight
                                .w600,
                            color: delta
                              .isPositive
                              ? AppColors
                                .success
                              : AppColors
                                .error,
                          ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Readiness score
          readinessAsync.when(
            loading: () =>
              const SizedBox.shrink(),
            error: (_, __) =>
              const SizedBox.shrink(),
            data: (readiness) =>
              Column(
                crossAxisAlignment:
                  CrossAxisAlignment
                    .start,
                children: [
                  Row(
                    mainAxisAlignment:
                      MainAxisAlignment
                        .spaceBetween,
                    children: [
                      Text(
                        readiness.label,
                        style: GoogleFonts
                          .inter(
                            fontSize:
                              12.sp,
                            fontWeight:
                              FontWeight
                                .w600,
                            color: Colors
                              .white
                              .withValues(
                                alpha:
                                  0.70,
                              ),
                          ),
                      ),
                      Text(
                        '${readiness.score}%',
                        style: GoogleFonts
                          .jetBrainsMono(
                            fontSize:
                              12.sp,
                            fontWeight:
                              FontWeight
                                .w700,
                            color:
                              AppColors
                                .primary,
                          ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  ProgressBarWidget(
                    value: readiness
                      .score / 100,
                    color:
                      AppColors.primary,
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────
// STATS ROW
// 3 stat cards
// ─────────────────────────────────

class _StatsRow extends StatelessWidget {

  const _StatsRow({
    required this.profile,
  });

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            icon: Icons
              .check_circle_rounded,
            iconColor: AppColors.success,
            value:
              '${profile.problemsSolved}',
            label: 'Solved',
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: StatCard(
            icon: Icons
              .emoji_events_rounded,
            iconColor: AppColors.warning,
            value:
              '${profile.contestsParticipated}',
            label: 'Contests',
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: StatCard(
            icon: Icons
              .local_fire_department_rounded,
            iconColor: AppColors.error,
            value:
              '${profile.streakDays}',
            label: 'Streak',
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────
// LOADING BODY
// ─────────────────────────────────

class _LoadingBody
  extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 16.h,
      ),
      child: Column(
        children: [
          GlassCardShimmer(
            height: 60.h,
          ),
          SizedBox(height: 20.h),
          GlassCardShimmer(
            height: 140.h,
          ),
          SizedBox(height: 16.h),
          const StatsRowShimmer(),
        ],
      ),
    );
  }
}

// ─────────────────────────────────
// ERROR BODY
// ─────────────────────────────────

class _ErrorBody extends StatelessWidget {

  const _ErrorBody({
    required this.error,
    required this.onRetry,
  });

  final String error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: AppColors.error
                .withValues(alpha: 0.70),
              size: 48.r,
            ),
            SizedBox(height: 16.h),
            Text(
              error,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight:
                  FontWeight.w500,
                color: Colors.white
                  .withValues(alpha: 0.60),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            TextButton(
              onPressed: onRetry,
              child: Text(
                'Retry',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight:
                    FontWeight.w600,
                  color: AppColors.primary,
                ),
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

ADD import at top:
import 'package:algolens/features/home/
  screens/home_screen.dart';

FIND this exact code:
GoRoute(
  path: RoutePaths.home,
  name: RouteNames.home,
  builder: (context, state) =>
    const _PlaceholderScreen(
      label: 'Home',
    ),
),

REPLACE with:
GoRoute(
  path: RoutePaths.home,
  name: RouteNames.home,
  builder: (context, state) =>
    const HomeScreen(),
),

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
VERIFY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ home_screen.dart
  created/updated ✓
□ HomeScreen ConsumerWidget ✓
□ cfHandleProvider watched ✓
□ OfflineBanner at top ✓
□ _Header with greeting +
  avatar ✓
□ Greeting changes by
  time of day ✓
□ Avatar tap → /profile ✓
□ _RatingHeroCard shows:
  rating + rank + delta
  + readiness bar ✓
□ _StatsRow:
  Solved + Contests
  + Streak ✓
□ Upcoming Contests section
  with placeholder ✓
□ "See all" → /contests ✓
□ Pull to refresh
  invalidates providers ✓
□ Loading → shimmer ✓
□ Error → retry button ✓
□ AppBackground used ✓
□ No MainScaffold here
  (added by router shell) ✓
□ No Isar imports ✓
□ app_router.dart home
  route updated ✓
□ Other routes untouched ✓
□ flutter analyze 0 errors ✓

PROMPT 44 DONE. WAIT FOR PROMPT 45.