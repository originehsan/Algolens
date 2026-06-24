import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/core/local/hive_service.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/features/upsolve/data/models/upsolve_model.dart';

final upsolveRepositoryProvider = Provider<UpsolveRepository>(
  (ref) => UpsolveRepository(ref.watch(dioClientProvider)),
);

class UpsolveRepository {
  UpsolveRepository(this._client);
  final DioClient _client;

  Future<List<UpsolveModel>> getUpsolveList(String handle) async {
    try {
      final data = await _client.get(ApiEndpoints.upsolve(handle));
      final items = <UpsolveModel>[];

      // Upsolve response is Map<contestId, List<problems>>
      // e.g. {'1991': [...], '1981': [...]}
      // DioClient._normalize() passes Map through as-is ✅
      // We need to skip non-contest keys like 'message'
      data.forEach((contestId, problems) {
        // Skip non-list values (e.g. 'message', 'status' keys)
        if (problems is! List) return;

        for (final p in problems) {
          if (p is! Map<String, dynamic>) continue;
          final key =
              '${p['contestId'] ?? contestId}_${p['index'] ?? ''}';
          final done = isDone(key);
          items.add(UpsolveModel.fromJson(p, isCompleted: done));
        }
      });

      // Sort: weak topics first, then by rating ascending
      items.sort((a, b) {
        if (a.isWeakTopic && !b.isWeakTopic) return -1;
        if (!a.isWeakTopic && b.isWeakTopic) return 1;
        return a.rating.compareTo(b.rating);
      });

      return items;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw const ApiException(
        message: 'Failed to load upsolve list. Please try again.',
        type: ApiExceptionType.unknown,
      );
    }
  }

  bool isDone(String problemKey) {
    final box = HiveService.upsolveLocalState;
    final raw = box.get(problemKey) as String?;
    if (raw == null) return false;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return (map['isCompleted'] as bool?) ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<void> toggleDone(String problemKey) async {
    final box = HiveService.upsolveLocalState;
    final current = isDone(problemKey);
    await box.put(
      problemKey,
      jsonEncode({
        'isCompleted': !current,
        'completedAt':
            !current ? DateTime.now().toIso8601String() : null,
      }),
    );
  }

  Future<void> markDone(String problemKey) async {
    final box = HiveService.upsolveLocalState;
    await box.put(
      problemKey,
      jsonEncode({
        'isCompleted': true,
        'completedAt': DateTime.now().toIso8601String(),
      }),
    );
  }

  Future<void> markUndone(String problemKey) async {
    final box = HiveService.upsolveLocalState;
    await box.put(
      problemKey,
      jsonEncode({
        'isCompleted': false,
        'completedAt': null,
      }),
    );
  }
}