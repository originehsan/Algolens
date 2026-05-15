import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/core/storage/secure_storage.dart';
import 'package:algolens/features/friends/data/models/friend_model.dart';
import 'package:algolens/features/friends/data/models/leaderboard_model.dart';

// ─────────────────────────────────
// PROVIDER
// ─────────────────────────────────

final friendsRepositoryProvider = Provider<FriendsRepository>((ref) {
  return FriendsRepository(
    ref.watch(dioClientProvider),
  );
});

// ─────────────────────────────────
// REPOSITORY
// ─────────────────────────────────

class FriendsRepository {
  FriendsRepository(
    this._client,
  );

  final DioClient _client;

  // ───────────────────────────────
  // ADD FRIEND
  // userHandle from SecureStorage
  // ───────────────────────────────

  Future<void> addFriend(
    String friendHandle,
  ) async {
    try {
      final userHandle = await SecureStorage.getCfHandle() ?? '';
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
      throw ApiException(
        message: e.toString(),
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ───────────────────────────────
  // REMOVE FRIEND
  // userHandle from SecureStorage
  // ───────────────────────────────

  Future<void> removeFriend(
    String friendHandle,
  ) async {
    try {
      final userHandle = await SecureStorage.getCfHandle() ?? '';
      await _client.delete(
        ApiEndpoints.removeFriend(
          userHandle,
          friendHandle,
        ),
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: e.toString(),
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ───────────────────────────────
  // GET FRIENDS
  // ───────────────────────────────

  Future<List<FriendModel>> getFriends(
    String handle,
  ) async {
    try {
      final data = await _client.get(
        ApiEndpoints.getFriends(handle),
      );
      final list = (data['friends'] as List?) ??
          (data is List ? data as List : []) as List;
      return (list)
          .map(
            (e) => FriendModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: e.toString(),
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ───────────────────────────────
  // GET LEADERBOARD
  // ───────────────────────────────

  Future<List<LeaderboardModel>> getLeaderboard(
    String handle,
  ) async {
    try {
      final data = await _client.get(
        ApiEndpoints.leaderboard(
          handle,
        ),
      );
      final list = (data['leaderboard'] as List?) ??
          (data is List ? data as List : []) as List;
      return (list)
          .map(
            (e) => LeaderboardModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: e.toString(),
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ───────────────────────────────
  // GET UNSOLVED BY ME
  // Problems friends solved
  // but I haven't
  // ───────────────────────────────

  Future<List<Map<String, dynamic>>> getUnsolvedByMe(
    String handle,
  ) async {
    try {
      final data = await _client.get(
        ApiEndpoints.unsolvedByMe(
          handle,
        ),
      );
      final list = ((data['problems'] as List?) ??
          (data is List ? data as List : []) as List) as List;
      return list.cast<Map<String, dynamic>>();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: e.toString(),
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ───────────────────────────────
  // GET STREAK COMPARE
  // ───────────────────────────────

  Future<Map<String, dynamic>> getStreakCompare(
    String handle,
  ) async {
    try {
      return await _client.get(
        ApiEndpoints.streakCompare(
          handle,
        ),
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: e.toString(),
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ───────────────────────────────
  // COMPARE RATING
  // ───────────────────────────────

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
      throw ApiException(
        message: e.toString(),
        type: ApiExceptionType.unknown,
      );
    }
  }

  // ───────────────────────────────
  // FIND SUBMISSION
  // ───────────────────────────────

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
      throw ApiException(
        message: e.toString(),
        type: ApiExceptionType.unknown,
      );
    }
  }
}
