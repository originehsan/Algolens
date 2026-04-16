import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/page_wrapper.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/app_text_field.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/segmented_tab.dart';
import 'package:algolens/core/widgets/user_avatar.dart';
import 'package:algolens/core/widgets/rank_chip.dart';
import 'package:algolens/core/widgets/loading_shimmer.dart';
import 'package:algolens/core/widgets/error_widget.dart';
import 'package:algolens/core/widgets/empty_widget.dart';
import 'package:algolens/features/auth/providers/auth_provider.dart';
import 'package:algolens/features/friends/providers/friends_provider.dart';
import 'package:algolens/features/friends/data/repositories/friends_repository.dart';

class FriendsScreen extends ConsumerStatefulWidget {
  const FriendsScreen({super.key});

  @override
  ConsumerState<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends ConsumerState<FriendsScreen> {
  int _selectedTab = 0;
  final _searchController = TextEditingController();
  bool _isAdding = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _addFriend(String handle, String friendHandle) async {
    if (_searchController.text.isEmpty) return;
    setState(() => _isAdding = true);
    try {
      await FriendsRepository().addFriend(
        userHandle: handle,
        friendHandle: _searchController.text.trim(),
      );
      _searchController.clear();
      ref.invalidate(friendsProvider(handle));
      ref.invalidate(leaderboardProvider(handle));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Friend added successfully',
            ),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isAdding = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final handle = authState.handle ?? 'ehsan_cf';

    return PageWrapper(
      title: 'Friends',
      showBackButton: true,
      child: Column(
        children: [
          // Search bar
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 12.h,
            ),
            child: Row(
              children: [
                Expanded(
                  child: AppTextField(
                    hint: 'Add friend by CF handle',
                    controller: _searchController,
                    prefixIcon: const Icon(
                      Icons.person_search_outlined,
                    ),
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () => _addFriend(
                      handle,
                      _searchController.text,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                AppButton(
                  label: 'Add',
                  onPressed: () => _addFriend(
                    handle,
                    _searchController.text,
                  ),
                  isLoading: _isAdding,
                  width: 70.w,
                ),
              ],
            ),
          ),

          // Tabs
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: SegmentedTab(
              tabs: const [
                'Friends',
                'Leaderboard',
              ],
              selectedIndex: _selectedTab,
              onTabSelected: (index) => setState(
                () => _selectedTab = index,
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Content
          Expanded(
            child: _selectedTab == 0
                ? _buildFriendsTab(handle)
                : _buildLeaderboardTab(handle),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendsTab(String handle) {
    final friendsAsync = ref.watch(friendsProvider(handle));

    return friendsAsync.when(
      loading: () => const ShimmerList(count: 4),
      error: (e, _) => AppErrorWidget(
        message: e.toString(),
        onRetry: () => ref.invalidate(friendsProvider(handle)),
      ),
      data: (friends) {
        if (friends.isEmpty) {
          return const AppEmptyWidget(
            title: 'No Friends Yet',
            subtitle: 'Add friends by their CF handle above',
            icon: Icons.people_outline_rounded,
          );
        }
        return ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          itemCount: friends.length,
          itemBuilder: (context, index) {
            final friend = friends[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: GlassCard(
                child: Row(
                  children: [
                    UserAvatar(
                      handle: friend.handle,
                      rank: friend.rank,
                      size: 44.r,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            friend.handle,
                            style: AppTextStyles.bodyBold,
                          ),
                          SizedBox(height: 4.h),
                          RankChip(
                            rank: friend.rank,
                            small: true,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            '${friend.contestsParticipated} contests',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${friend.rating}',
                          style: AppTextStyles.mono.copyWith(
                            color: AppColors.primary,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'max ${friend.maxRating}',
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(
                  delay: Duration(
                    milliseconds: index * 80,
                  ),
                  duration: 400.ms,
                );
          },
        );
      },
    );
  }

  Widget _buildLeaderboardTab(String handle) {
    final leaderboardAsync = ref.watch(leaderboardProvider(handle));

    return leaderboardAsync.when(
      loading: () => const ShimmerList(count: 5),
      error: (e, _) => AppErrorWidget(
        message: e.toString(),
        onRetry: () => ref.invalidate(leaderboardProvider(handle)),
      ),
      data: (entries) {
        if (entries.isEmpty) {
          return const AppEmptyWidget(
            title: 'No Leaderboard Data',
            subtitle: 'Add friends to see rankings',
            icon: Icons.leaderboard_outlined,
          );
        }
        return ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          itemCount: entries.length,
          itemBuilder: (context, index) {
            final entry = entries[index];
            final isCurrentUser = entry.handle == handle;
            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: GlassCard(
                borderColor: isCurrentUser
                    ? AppColors.primary.withValues(alpha: 0.50)
                    : null,
                child: Row(
                  children: [
                    // Rank number
                    SizedBox(
                      width: 32.w,
                      child: entry.rank <= 3
                          ? Text(
                              entry.rank == 1
                                  ? '🥇'
                                  : entry.rank == 2
                                      ? '🥈'
                                      : '🥉',
                              style: TextStyle(
                                fontSize: 20.sp,
                              ),
                            )
                          : Text(
                              '#${entry.rank}',
                              style: AppTextStyles.mono.copyWith(
                                fontSize: 14.sp,
                                color: AppColors.textMuted,
                              ),
                            ),
                    ),
                    SizedBox(width: 8.w),
                    UserAvatar(
                      handle: entry.handle,
                      rank: entry.tier,
                      size: 38.r,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                entry.handle,
                                style: isCurrentUser
                                    ? AppTextStyles.bodyBold.copyWith(
                                        color: AppColors.primary,
                                      )
                                    : AppTextStyles.bodyBold,
                              ),
                              if (isCurrentUser) ...[
                                SizedBox(width: 6.w),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary
                                        .withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: Text(
                                    'You',
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.primary,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          RankChip(
                            rank: entry.tier,
                            small: true,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${entry.rating}',
                      style: AppTextStyles.mono.copyWith(
                        color: AppColors.primary,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(
                  delay: Duration(
                    milliseconds: index * 80,
                  ),
                  duration: 400.ms,
                );
          },
        );
      },
    );
  }
}
