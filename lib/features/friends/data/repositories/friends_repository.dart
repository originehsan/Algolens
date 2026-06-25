import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/core/storage/secure_storage.dart';
import 'package:algolens/features/friends/data/models/friend_model.dart';
import 'package:algolens/features/friends/data/models/leaderboard_model.dart';

final friendsRepositoryProvider = Provider<FriendsRepository>((ref) {
  return FriendsRepository(ref.watch(dioClientProvider));
});

class FriendsRepository {
  FriendsRepository(this._client);
  final DioClient _client;

  // ────────────────────────────
  // ADD FRIEND
  // Both handles required by API
  // POST /friends/add
  // ────────────────────────────

  Future<void> addFriend(
    String userHandle,
    String friendHandle,
  ) async {
    try {
      await _client.post(
        ApiEndpoints.addFriend,
        body: {
          'userHandle': userHandle,
          'friendHandle': friendHandle,
        },
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw const ApiException(
        message: 'Failed to add friend. Please try again.',
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ────────────────────────────
  // REMOVE FRIEND
  // DELETE /friends/{user}/remove/{friend}
  // ────────────────────────────

  Future<void> removeFriend(String friendHandle) async {
    try {
      final userHandle = await SecureStorage.getCfHandle() ?? '';
      await _client.delete(
        ApiEndpoints.removeFriend(userHandle, friendHandle),
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw const ApiException(
        message: 'Failed to remove friend. Please try again.',
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ────────────────────────────
  // GET FRIENDS
  // GET /friends/{handle}
  // ────────────────────────────

  Future<List<FriendModel>> getFriends(String handle) async {
    try {
      final data = await _client.get(ApiEndpoints.getFriends(handle));
      final list = _extractList(data, keys: ['friends', 'data']);
      return list
          .map((e) => FriendModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw const ApiException(
        message: 'Failed to load friends. Please try again.',
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ────────────────────────────
  // GET LEADERBOARD
  // GET /friends/{handle}/leaderboard
  // ────────────────────────────

  Future<List<LeaderboardModel>> getLeaderboard(String handle) async {
    try {
      final data = await _client.get(
        ApiEndpoints.leaderboard(handle),
      );
      final list = _extractList(data, keys: ['leaderboard', 'data']);
      return list
          .map(
            (e) => LeaderboardModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw const ApiException(
        message: 'Failed to load leaderboard. Please try again.',
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ────────────────────────────
  // GET UNSOLVED BY ME
  // GET /friends/{handle}/unsolved-by-me
  // ────────────────────────────

  Future<List<Map<String, dynamic>>> getUnsolvedByMe(
    String handle,
  ) async {
    try {
      final data = await _client.get(
        ApiEndpoints.unsolvedByMe(handle),
      );
      final list = _extractList(data, keys: ['problems', 'data']);
      return list.cast<Map<String, dynamic>>();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw const ApiException(
        message: 'Failed to load unsolved problems. Please try again.',
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ────────────────────────────
  // GET STREAK COMPARE
  // GET /friends/{handle}/streak-compare
  // API returns flat List not Map
  // ────────────────────────────

  Future<List<Map<String, dynamic>>> getStreakCompare(
    String handle,
  ) async {
    try {
      final data = await _client.get(
        ApiEndpoints.streakCompare(handle),
      );
      final list = _extractList(data, keys: ['data']);
      return list.cast<Map<String, dynamic>>();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw const ApiException(
        message: 'Failed to load streak data. Please try again.',
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ────────────────────────────
  // COMPARE RATING
  // GET /compare/rating?handle1=&handle2=
  // ────────────────────────────

  Future<Map<String, dynamic>> compareRating(
    String handle1,
    String handle2,
  ) async {
    try {
      return await _client.get(
        ApiEndpoints.compareRating,
        queryParameters: {
          'handle1': handle1,
          'handle2': handle2,
        },
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw const ApiException(
        message: 'Failed to compare ratings. Please try again.',
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ────────────────────────────
  // FIND SUBMISSION
  // POST /compare/find
  // ────────────────────────────

  Future<Map<String, dynamic>> findSubmission({
    required String handle1,
    required String handle2,
    required int contestId,
    required String index,
  }) async {
    try {
      return await _client.post(
        ApiEndpoints.findSubmission,
        body: {
          'handle1': handle1,
          'handle2': handle2,
          'contestId': contestId,
          'index': index,
        },
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw const ApiException(
        message: 'Failed to find submission. Please try again.',
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ────────────────────────────
  // EXTRACT LIST
  // Tries multiple keys to find
  // the list in the response
  // ────────────────────────────

  List<dynamic> _extractList(
    Map<String, dynamic> data, {
    required List<String> keys,
  }) {
    for (final key in keys) {
      if (data[key] is List) return data[key] as List;
    }
    return [];
  }
}