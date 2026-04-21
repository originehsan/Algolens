import 'dart:convert';
import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/local/hive_service.dart';
import 'package:algolens/features/contests/data/models/contest_model.dart';

class ContestRepository {
  final DioClient _dioClient;

  ContestRepository(this._dioClient);

  Future<List<Contest>> getUpcomingContests() async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.upcomingContests,
      );
      final contests = (response as List)
          .map((item) => Contest.fromJson(item as Map<String, dynamic>))
          .toList();

      // Cache as JSON
      await HiveService.cachedContests.put(
        'upcoming_contests',
        jsonEncode(response),
      );

      return contests;
    } catch (e) {
      // Try cache fallback
      final cached = HiveService.cachedContests.get('upcoming_contests');
      if (cached != null) {
        try {
          return (jsonDecode(cached as String) as List)
              .map((item) => Contest.fromJson(item as Map<String, dynamic>))
              .toList();
        } catch (_) {
          rethrow;
        }
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getAllContests({
    int page = 0,
    int size = 20,
  }) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.allContests,
        queryParameters: {
          'page': page,
          'size': size,
        },
      );

      // Cache as JSON
      final cacheKey = 'all_contests_p${page}_s$size';
      await HiveService.cachedContests.put(
        cacheKey,
        jsonEncode(response),
      );

      return response;
    } catch (e) {
      // Try cache fallback
      final cacheKey = 'all_contests_p${page}_s$size';
      final cached = HiveService.cachedContests.get(cacheKey);
      if (cached != null) {
        try {
          return jsonDecode(cached as String);
        } catch (_) {
          rethrow;
        }
      }
      rethrow;
    }
  }
}
