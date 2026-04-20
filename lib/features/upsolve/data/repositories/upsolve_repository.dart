import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/features/upsolve/data/models/upsolve_model.dart';

class UpsolveRepository {
  final DioClient _dioClient;

  UpsolveRepository(this._dioClient);

  Future<List<UpsolveContest>> getUpsolveProblems(String handle) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.upsolve(handle),
      );
      return UpsolveContest.fromApiResponse(
        response as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }
}
