import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/features/profile/data/repositories/profile_repository.dart';
import 'package:algolens/features/profile/data/models/profile_model.dart';
import 'package:algolens/features/profile/data/models/rating_graph_model.dart';
import 'package:algolens/features/profile/data/models/submission_stats_model.dart';
import 'package:algolens/features/profile/data/models/contest_history_model.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ProfileRepository(dioClient);
});

final profileProvider =
    FutureProvider.family<UserProfile, String>((ref, handle) async {
  final repo = ref.read(profileRepositoryProvider);
  return repo.getProfile(handle);
});

final ratingGraphProvider =
    FutureProvider.family<List<RatingPoint>, String>((ref, handle) async {
  final repo = ref.read(profileRepositoryProvider);
  return repo.getRatingGraph(handle);
});

final submissionStatsProvider =
    FutureProvider.family<SubmissionStats, String>((ref, handle) async {
  final repo = ref.read(profileRepositoryProvider);
  return repo.getSubmissionStats(handle);
});

final contestHistoryProvider =
    FutureProvider.family<List<ContestHistoryItem>, String>(
        (ref, handle) async {
  final repo = ref.read(profileRepositoryProvider);
  return repo.getContestHistory(handle);
});
