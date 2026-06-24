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

  Future<void> addFriend(String friendHandle) async {
    try {
      final userHandle = await SecureStorage.getCfHandle() ?? '';
      await _client.post(
        ApiEndpoints.addFriend,
        body: {'userHandle': userHandle, 'friendHandle': friendHandle},
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

  Future<List<FriendModel>> getFriends(String handle) async {
    try {
      final data = await _client.get(ApiEndpoints.getFriends(handle));
      // Mock returns List → DioClient wraps as {'data': [...]}
      // Real API returns {'friends': [...]}
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

  Future<List<LeaderboardModel>> getLeaderboard(String handle) async {
    try {
      final data = await _client.get(ApiEndpoints.leaderboard(handle));
      // Mock returns List → DioClient wraps as {'data': [...]}
      // Real API returns {'leaderboard': [...]}
      final list = _extractList(data, keys: ['leaderboard', 'data']);
      return list
          .map((e) => LeaderboardModel.fromJson(e as Map<String, dynamic>))
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

  Future<List<Map<String, dynamic>>> getUnsolvedByMe(String handle) async {
    try {
      final data = await _client.get(ApiEndpoints.unsolvedByMe(handle));
      // Mock returns List → DioClient wraps as {'data': [...]}
      // Real API returns {'problems': [...]}
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

  Future<Map<String, dynamic>> getStreakCompare(String handle) async {
    try {
      return await _client.get(ApiEndpoints.streakCompare(handle));
    } on ApiException {
      rethrow;
    } catch (e) {
      throw const ApiException(
        message: 'Failed to load streak data. Please try again.',
        type: ApiExceptionType.unknown,
      );
    }
  }

  Future<Map<String, dynamic>> compareRating(
    String handle1,
    String handle2,
  ) async {
    try {
      return await _client.get(
        ApiEndpoints.compareRating,
        queryParameters: {'handle1': handle1, 'handle2': handle2},
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