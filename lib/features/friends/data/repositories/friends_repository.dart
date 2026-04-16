import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/features/friends/data/models/friend_model.dart';
import 'package:algolens/features/friends/data/models/leaderboard_model.dart';

class FriendsRepository {
  final DioClient _dioClient;

  FriendsRepository({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient.instance;

  Future<List<Friend>> getFriends(String handle) async {
    try {
      final response = await _dioClient.dio.get(
        ApiEndpoints.getFriends(handle),
      );
      return (response.data as List)
          .map((item) => Friend.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw AppException.fromDioException(e);
    }
  }

  Future<String> addFriend({
    required String userHandle,
    required String friendHandle,
  }) async {
    try {
      final response = await _dioClient.dio.post(
        ApiEndpoints.addFriend,
        data: {
          'userHandle': userHandle,
          'friendHandle': friendHandle,
        },
      );
      return response.data as String;
    } catch (e) {
      throw AppException.fromDioException(e);
    }
  }

  Future<String> removeFriend({
    required String userHandle,
    required String friendHandle,
  }) async {
    try {
      final response = await _dioClient.dio.delete(
        ApiEndpoints.removeFriend(userHandle, friendHandle),
      );
      return response.data as String;
    } catch (e) {
      throw AppException.fromDioException(e);
    }
  }

  Future<List<LeaderboardEntry>> getLeaderboard(String handle) async {
    try {
      final response = await _dioClient.dio.get(
        ApiEndpoints.friendsLeaderboard(handle),
      );
      return (response.data as List)
          .map(
              (item) => LeaderboardEntry.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw AppException.fromDioException(e);
    }
  }

  Future<Map<String, dynamic>> compareRating({
    required String handle1,
    required String handle2,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        ApiEndpoints.compareRating,
        queryParameters: {
          'handle1': handle1,
          'handle2': handle2,
        },
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw AppException.fromDioException(e);
    }
  }
}
