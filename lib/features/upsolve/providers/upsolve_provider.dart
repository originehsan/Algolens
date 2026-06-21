import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/storage/secure_storage.dart';
import 'package:algolens/features/upsolve/data/models/upsolve_model.dart';
import 'package:algolens/features/upsolve/data/repositories/upsolve_repository.dart';

// Fetches full upsolve list for the logged-in user.
// isCompleted state is merged from Hive inside the repository.
final upsolveProvider = FutureProvider<List<UpsolveModel>>((ref) async {
  // Get CF handle from secure storage — never from API
  final handle = await SecureStorage.getCfHandle();
  if (handle == null || handle.isEmpty) return [];

  final repo = ref.read(upsolveRepositoryProvider);
  // Repository flattens Map<String,List> and sorts weak topics first
  return repo.getUpsolveList(handle);
});

// Tracks which problemKeys are currently being toggled.
// Set<String> = keys in progress — used to show spinner in UI.
final toggleUpsolveProvider =
    StateNotifierProvider<ToggleUpsolveNotifier, Set<String>>(
  (ref) => ToggleUpsolveNotifier(ref),
);

class ToggleUpsolveNotifier extends StateNotifier<Set<String>> {
  ToggleUpsolveNotifier(this._ref) : super({});

  final Ref _ref;

  Future<void> toggle(String problemKey) async {
    final repo = _ref.read(upsolveRepositoryProvider);

    // Write to Hive — no API call needed
    await repo.toggleDone(problemKey);

    // Remove from in-progress set after toggle completes
    state = {...state}..remove(problemKey);

    // Invalidate so upsolveProvider refetches with updated Hive state
    _ref.invalidate(upsolveProvider);
  }

  // Returns true while toggle is in progress — shows spinner in card
  bool isToggling(String problemKey) => state.contains(problemKey);
}