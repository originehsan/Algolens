import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/features/upsolve/data/repositories/upsolve_repository.dart';
import 'package:algolens/features/upsolve/data/models/upsolve_model.dart';

final upsolveRepositoryProvider = Provider<UpsolveRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return UpsolveRepository(dioClient);
});

final upsolveProvider =
    FutureProvider.family<List<UpsolveContest>, String>((ref, handle) async {
  final repo = ref.read(upsolveRepositoryProvider);
  return repo.getUpsolveProblems(handle);
});
