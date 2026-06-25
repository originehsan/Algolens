import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/core/storage/secure_storage.dart';
import 'package:algolens/features/friends/data/models/friend_model.dart';
import 'package:algolens/features/friends/data/models/leaderboard_model.dart';
import 'package:algolens/features/friends/data/repositories/friends_repository.dart';

// ─────────────────────────────────
// FRIENDS PROVIDER
// Fetches friend list
// for own handle
// ─────────────────────────────────

/// Friends list provider
///
/// Uses cfHandleProvider to get
/// own handle automatically
///
/// Usage:
/// ref.watch(friendsProvider).when(
///   loading: () => shimmer,
///   error: (e, s) => errorWidget,
///   data: (friends) => list,
/// )
final friendsProvider = FutureProvider<List<FriendModel>>(
  (ref) async {
    final handle = await SecureStorage.getCfHandle();
    if (handle == null || handle.isEmpty) {
      return [];
    }
    final repo = ref.read(
      friendsRepositoryProvider,
    );
    return repo.getFriends(handle);
  },
);

// ─────────────────────────────────
// LEADERBOARD PROVIDER
// Friends ranked by rating
// ─────────────────────────────────

/// Friends leaderboard provider
///
/// Returns friends sorted by
/// rating descending
final leaderboardProvider = FutureProvider<List<LeaderboardModel>>(
  (ref) async {
    final handle = await SecureStorage.getCfHandle();
    if (handle == null || handle.isEmpty) {
      return [];
    }
    final repo = ref.read(
      friendsRepositoryProvider,
    );
    return repo.getLeaderboard(
      handle,
    );
  },
);

// ─────────────────────────────────
// UNSOLVED BY ME PROVIDER
// Problems friends solved
// but I haven't yet
// ─────────────────────────────────

/// Unsolved by me provider
///
/// Problems that friends have
/// solved but current user hasn't
/// Used in home + friends screen
final unsolvedByMeProvider = FutureProvider<List<Map<String, dynamic>>>(
  (ref) async {
    final handle = await SecureStorage.getCfHandle();
    if (handle == null || handle.isEmpty) {
      return [];
    }
    final repo = ref.read(
      friendsRepositoryProvider,
    );
    return repo.getUnsolvedByMe(
      handle,
    );
  },
);

// ─────────────────────────────────
// STREAK COMPARE PROVIDER
// Streak comparison with friends
// ─────────────────────────────────

/// Streak comparison provider
///
/// Returns streak data for
/// user and all friends
final streakCompareProvider = FutureProvider<List<Map<String, dynamic>>>(
  (ref) async {
    final handle = await SecureStorage.getCfHandle();
    if (handle == null || handle.isEmpty) {
      return [];
    }
    final repo = ref.read(
      friendsRepositoryProvider,
    );
    return repo.getStreakCompare(
      handle,
    );
  },
);

// ─────────────────────────────────
// COMPARE RATING PROVIDER
// Compares two CF handles
// FutureProvider.family
// ─────────────────────────────────

/// Rating comparison provider
///
/// Takes two handles as record
/// Returns comparison map
///
/// Usage:
/// ref.watch(
///   compareRatingProvider(
///     (handle1, handle2),
///   ),
/// )
final compareRatingProvider =
    FutureProvider.family<Map<String, dynamic>, (String, String)>(
  (ref, handles) async {
    final repo = ref.read(
      friendsRepositoryProvider,
    );
    return repo.compareRating(
      handles.$1,
      handles.$2,
    );
  },
);

// ─────────────────────────────────
// ADD FRIEND PROVIDER
// StateNotifierProvider
// Adds friend + refreshes list
// ─────────────────────────────────

/// Add friend provider
///
/// Usage:
/// final success = await ref.read(
///   addFriendProvider.notifier,
/// ).add('tourist');
final addFriendProvider =
    StateNotifierProvider<AddFriendNotifier, AsyncValue<void>>(
  (ref) => AddFriendNotifier(ref),
);

class AddFriendNotifier extends StateNotifier<AsyncValue<void>> {
  AddFriendNotifier(this._ref)
      : super(
          const AsyncValue.data(null),
        );

  final Ref _ref;

  Future<bool> add(
  String friendHandle,
) async {
  state = const AsyncValue.loading();
  try {
    final userHandle = await SecureStorage.getCfHandle();
    if (userHandle == null || userHandle.isEmpty) {
      state = const AsyncValue.data(null);
      return false;
    }
    final repo = _ref.read(
      friendsRepositoryProvider,
    );
    await repo.addFriend(
      userHandle,
      friendHandle,
    );
      state = const AsyncValue.data(null);

      // Refresh friends list
      _ref.invalidate(friendsProvider);
      _ref.invalidate(
        leaderboardProvider,
      );
      return true;
    } on ApiException catch (e) {
      state = AsyncValue.error(
        e,
        StackTrace.current,
      );
      return false;
    }
  }
}

// ─────────────────────────────────
// REMOVE FRIEND PROVIDER
// StateNotifierProvider
// Removes friend + refreshes list
// ─────────────────────────────────

/// Remove friend provider
///
/// Usage:
/// await ref.read(
///   removeFriendProvider.notifier,
/// ).remove('tourist');
final removeFriendProvider =
    StateNotifierProvider<RemoveFriendNotifier, AsyncValue<void>>(
  (ref) => RemoveFriendNotifier(ref),
);

class RemoveFriendNotifier extends StateNotifier<AsyncValue<void>> {
  RemoveFriendNotifier(this._ref)
      : super(
          const AsyncValue.data(null),
        );

  final Ref _ref;

  Future<void> remove(
    String friendHandle,
  ) async {
    state = const AsyncValue.loading();
    try {
      final repo = _ref.read(
        friendsRepositoryProvider,
      );
      await repo.removeFriend(
        friendHandle,
      );
      state = const AsyncValue.data(null);

      // Refresh friends list
      _ref.invalidate(friendsProvider);
      _ref.invalidate(
        leaderboardProvider,
      );
    } on ApiException catch (e) {
      state = AsyncValue.error(
        e,
        StackTrace.current,
      );
    }
  }
}
