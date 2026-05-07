import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/features/profile/data/repositories/profile_repository.dart';
import 'package:algolens/features/profile/data/models/profile_model.dart';
import 'package:algolens/features/profile/data/models/rating_graph_model.dart';
import 'package:algolens/features/profile/data/models/submission_stats_model.dart';
import 'package:algolens/features/profile/data/models/contest_history_model.dart';

// ─────────────────────────────────
// PROFILE PROVIDERS
// profileRepositoryProvider is in
// profile_repository.dart (P40)
// ─────────────────────────────────

final profileProvider =
    FutureProvider.family<ProfileModel, String>((ref, handle) async {
  final repo = ref.watch(profileRepositoryProvider);
  return repo.getProfile(handle);
});

final ratingGraphProvider =
    FutureProvider.family<List<RatingGraphModel>, String>((ref, handle) async {
  final repo = ref.watch(profileRepositoryProvider);
  return repo.getRatingGraph(handle);
});

final submissionStatsProvider =
    FutureProvider.family<SubmissionStatsModel, String>((ref, handle) async {
  final repo = ref.watch(profileRepositoryProvider);
  return repo.getSubmissionStats(handle);
});

final contestHistoryProvider =
    FutureProvider.family<List<ContestHistoryModel>, String>(
        (ref, handle) async {
  final repo = ref.watch(profileRepositoryProvider);
  return repo.getContestHistory(handle);
});
