import 'dart:convert';
import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/local/hive_service.dart';
import 'package:algolens/features/upsolve/data/models/upsolve_model.dart';

class UpsolveRepository {
  final DioClient _dioClient;

  UpsolveRepository(this._dioClient);

  Future<List<UpsolveContest>> getUpsolveProblems(String handle) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.upsolve(handle),
      );
      final upsolve = UpsolveContest.fromApiResponse(response);

      // Cache as JSON
      await HiveService.cachedContests.put(
        'upsolve_$handle',
        jsonEncode(response),
      );

      return upsolve;
    } catch (e) {
      // Try cache fallback
      final cached = HiveService.cachedContests.get('upsolve_$handle');
      if (cached != null) {
        try {
          return UpsolveContest.fromApiResponse(jsonDecode(cached as String));
        } catch (_) {
          rethrow;
        }
      }
      rethrow;
    }
  }
}
