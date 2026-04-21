import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/features/friends/data/models/friend_model.dart';
import 'package:algolens/features/friends/data/models/leaderboard_model.dart';

class FriendsRepository {
  final DioClient _dioClient;

  FriendsRepository(this._dioClient);

  Future<List<Friend>> getFriends(String handle) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.getFriends(handle),
      );
      return (response as List)
          .map((item) => Friend.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addFriend({
    required String userHandle,
    required String friendHandle,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.addFriend,
        body: {
          'userHandle': userHandle,
          'friendHandle': friendHandle,
        },
      );
      return response as String;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> removeFriend({
    required String userHandle,
    required String friendHandle,
  }) async {
    try {
      final response = await _dioClient.delete(
        ApiEndpoints.removeFriend(userHandle, friendHandle),
      );
      return response as String;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<LeaderboardEntry>> getLeaderboard(String handle) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.leaderboard(handle),
      );
      return (response as List)
          .map(
              (item) => LeaderboardEntry.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> compareRating({
    required String handle1,
    required String handle2,
  }) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.compareRating,
        queryParameters: {
          'handle1': handle1,
          'handle2': handle2,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
