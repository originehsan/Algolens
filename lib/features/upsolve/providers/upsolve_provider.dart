import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/features/upsolve/data/repositories/upsolve_repository.dart';
import 'package:algolens/features/upsolve/data/models/upsolve_model.dart';

final upsolveRepositoryProvider = Provider<UpsolveRepository>((ref) {
  return UpsolveRepository();
});

final upsolveProvider =
    FutureProvider.family<List<UpsolveContest>, String>((ref, handle) async {
  final repo = ref.read(upsolveRepositoryProvider);
  return repo.getUpsolveProblems(handle);
});
