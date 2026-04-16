import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/features/friends/data/repositories/friends_repository.dart';
import 'package:algolens/features/friends/data/models/friend_model.dart';
import 'package:algolens/features/friends/data/models/leaderboard_model.dart';

final friendsRepositoryProvider = Provider<FriendsRepository>((ref) {
  return FriendsRepository();
});

final friendsProvider =
    FutureProvider.family<List<Friend>, String>((ref, handle) async {
  final repo = ref.read(friendsRepositoryProvider);
  return repo.getFriends(handle);
});

final leaderboardProvider =
    FutureProvider.family<List<LeaderboardEntry>, String>((ref, handle) async {
  final repo = ref.read(friendsRepositoryProvider);
  return repo.getLeaderboard(handle);
});
