import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/app_text_field.dart';
import 'package:algolens/core/widgets/empty_widget.dart';
import 'package:algolens/core/widgets/error_widget.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/loading_shimmer.dart';
import 'package:algolens/core/widgets/rank_chip.dart';
import 'package:algolens/core/widgets/segmented_tab.dart';
import 'package:algolens/core/widgets/user_avatar.dart';
import 'package:algolens/features/friends/data/models/friend_model.dart';
import 'package:algolens/features/friends/data/models/leaderboard_model.dart';
import 'package:algolens/features/friends/providers/friends_provider.dart';
import 'package:algolens/features/profile/providers/profile_provider.dart';

class FriendsScreen extends ConsumerStatefulWidget {
  const FriendsScreen({super.key});

  @override
  ConsumerState<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends ConsumerState<FriendsScreen> {
  int _tabIndex = 0;
  final _searchCtrl = TextEditingController();
  bool _isAdding = false;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _addFriend() async {
    final handle = _searchCtrl.text.trim();
    if (handle.isEmpty) return;

    setState(() => _isAdding = true);
    final success = await ref
        .read(
          addFriendProvider.notifier,
        )
        .add(handle);
    if (!mounted) return;
    setState(() => _isAdding = false);

    if (success) {
      _searchCtrl.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '$handle added!',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: AppColors.success,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to add $handle',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: AppColors.danger,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final handleAsync = ref.watch(
      cfHandleProvider,
    );

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              floating: true,
              title: Text(
                'Friends',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    // Add friend input
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            label: 'Add Friend',
                            hint: 'CF handle',
                            controller: _searchCtrl,
                            prefixIcon: Icons.person_add_rounded,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => _addFriend(),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        SizedBox(
                          width: 80.w,
                          child: AppButton(
                            label: 'Add',
                            onTap: _addFriend,
                            isLoading: _isAdding,
                            height: 52.h,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    // Unsolved by me card
                    const _UnsolvedByMeCard(),
                    // Tabs
                    SegmentedTab(
                      tabs: const [
                        'Friends',
                        'Leaderboard',
                        'Streaks',
                      ],
                      currentIndex: _tabIndex,
                      onChanged: (i) => setState(
                        () => _tabIndex = i,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    // Tab content
                    if (_tabIndex == 0)
                      _FriendsList(
                        ownHandleAsync: handleAsync,
                      ),
                    if (_tabIndex == 1) const _LeaderboardList(),
                    if (_tabIndex == 2) const _StreaksList(),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────
// UNSOLVED BY ME CARD
// ─────────────────────────────────

class _UnsolvedByMeCard extends ConsumerWidget {
  const _UnsolvedByMeCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(unsolvedByMeProvider);

    return async.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (list) {
        if (list.isEmpty) return const SizedBox.shrink();
        final item = list.first;
        return GlassCard(
          type: GlassCardType.warning,
          margin: EdgeInsets.only(bottom: 16.h),
          onTap: () => launchUrl(
            Uri.parse(
              'https://codeforces.com/contest/'
              '${item['contestId']}/problem/${item['index']}',
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.people_rounded,
                color: AppColors.warning,
                size: 18.r,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  '${item['handle']} solved ${item['name']} — can you?',
                  style: AppTextStyles.bodySmall,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.warning,
                size: 14.r,
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────
// FRIENDS LIST TAB
// ─────────────────────────────────

class _FriendsList extends ConsumerWidget {
  const _FriendsList({
    required this.ownHandleAsync,
  });

  final AsyncValue<String?> ownHandleAsync;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final friendsAsync = ref.watch(
      friendsProvider,
    );

    return friendsAsync.when(
      loading: () => const FriendsListShimmer(),
      error: (e, s) => AppErrorWidget(
        message: e is ApiException
            ? e.message
            : 'Something went wrong. Please try again.',
        onRetry: () => ref.invalidate(
          friendsProvider,
        ),
      ),
      data: (friends) {
        if (friends.isEmpty) {
          return const EmptyWidget(
            icon: Icons.people_outline,
            message: 'No friends yet',
            subtitle: 'Add friends by their CF handle above',
          );
        }
        return Column(
          children: friends
              .map(
                (f) => _FriendTile(
                  friend: f,
                  ownHandleAsync: ownHandleAsync,
                ),
              )
              .toList(),
        );
      },
    );
  }
}

// ─────────────────────────────────
// FRIEND TILE
// Swipe to remove + tap to compare
// ─────────────────────────────────

class _FriendTile extends ConsumerWidget {
  const _FriendTile({
    required this.friend,
    required this.ownHandleAsync,
  });

  final FriendModel friend;
  final AsyncValue<String?> ownHandleAsync;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Dismissible(
      key: Key(friend.handle),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(
          right: 20.w,
        ),
        decoration: BoxDecoration(
          color: AppColors.danger.withValues(alpha: 0.20),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Icon(
          Icons.delete_rounded,
          color: AppColors.danger,
          size: 24.r,
        ),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                backgroundColor: const Color(0xFF0E1E3C),
                title: Text(
                  'Remove Friend?',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                content: Text(
                  'Remove ${friend.handle} from your friends list?',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(
                      alpha: 0.70,
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(
                      ctx,
                      false,
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(
                          alpha: 0.60,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(
                      ctx,
                      true,
                    ),
                    child: Text(
                      'Remove',
                      style: GoogleFonts.inter(
                        color: AppColors.danger,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ) ??
            false;
      },
      onDismissed: (_) {
        ref
            .read(
              removeFriendProvider.notifier,
            )
            .remove(friend.handle);
      },
      child: GlassCard(
        margin: EdgeInsets.only(
          bottom: 10.h,
        ),
        onTap: () {
          final ownHandle = ownHandleAsync.value;
          if (ownHandle != null) {
            context.goNamed(
              RouteNames.comparison,
              extra: (
                ownHandle,
                friend.handle,
              ),
            );
          }
        },
        child: Row(
          children: [
            UserAvatar(
              handle: friend.handle,
              rank: friend.rank,
              avatarUrl: friend.avatar,
              size: 44.r,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    friend.handle,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  RankChip(
                    rank: friend.rank,
                    compact: true,
                  ),
                ],
              ),
            ),
            Text(
              '${friend.rating}',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────
// LEADERBOARD TAB
// ─────────────────────────────────

class _LeaderboardList extends ConsumerWidget {
  const _LeaderboardList();

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final async = ref.watch(
      leaderboardProvider,
    );

    return async.when(
      loading: () => const FriendsListShimmer(),
      error: (e, s) => AppErrorWidget(
        message: e is ApiException
            ? e.message
            : 'Something went wrong. Please try again.',
        onRetry: () => ref.invalidate(
          leaderboardProvider,
        ),
      ),
      data: (entries) {
        if (entries.isEmpty) {
          return const EmptyWidget(
            icon: Icons.leaderboard_rounded,
            message: 'No leaderboard yet',
          );
        }
        return Column(
          children: entries
              .map(
                (e) => _LeaderboardTile(
                  entry: e,
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _LeaderboardTile extends StatelessWidget {
  const _LeaderboardTile({
    required this.entry,
  });

  final LeaderboardModel entry;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: EdgeInsets.only(
        bottom: 10.h,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 40.r,
            child: Center(
              child: Text(
                entry.rankEmoji,
                style: TextStyle(
                  fontSize: 20.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.handle,
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                RankChip(
                  rank: entry.tier,
                  compact: true,
                ),
              ],
            ),
          ),
          Text(
            '${entry.rating}',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────
// STREAKS TAB
// ─────────────────────────────────

class _StreaksList extends ConsumerWidget {
  const _StreaksList();

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final async = ref.watch(
      streakCompareProvider,
    );

    return async.when(
      loading: () => const FriendsListShimmer(),
      error: (e, s) => AppErrorWidget(
        message: e is ApiException
            ? e.message
            : 'Something went wrong. Please try again.',
        onRetry: () => ref.invalidate(
          streakCompareProvider,
        ),
      ),
      data: (data) {
        final streaks = data['streaks'] as List? ?? [];
        if (streaks.isEmpty) {
          return const EmptyWidget(
            icon: Icons.local_fire_department_rounded,
            message: 'No streak data',
          );
        }
        return Column(
          children: streaks.map(
            (s) {
              final map = s as Map<String, dynamic>;
              final handle = map['handle'] as String;
              final days = map['streakDays'] as int? ?? 0;
              final maxDays = streaks
                  .map(
                    (x) => (x as Map)['streakDays'] as int? ?? 0,
                  )
                  .reduce(
                    (a, b) => a > b ? a : b,
                  );

              return GlassCard(
                margin: EdgeInsets.only(
                  bottom: 10.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.local_fire_department_rounded,
                          color: AppColors.warning,
                          size: 18.r,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          handle,
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '$days days',
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.warning,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    LinearProgressIndicator(
                      value: maxDays > 0 ? days / maxDays : 0,
                      backgroundColor: Colors.white.withValues(
                        alpha: 0.10,
                      ),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.warning,
                      ),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ],
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }
}