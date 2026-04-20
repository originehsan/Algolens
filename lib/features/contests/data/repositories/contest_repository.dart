import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/features/contests/data/models/contest_model.dart';

class ContestRepository {
  final DioClient _dioClient;

  ContestRepository(this._dioClient);

  Future<List<Contest>> getUpcomingContests() async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.upcomingContests,
      );
      return (response as List)
          .map((item) => Contest.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
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
      return response as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }
}
