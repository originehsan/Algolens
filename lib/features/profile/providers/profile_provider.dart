import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/storage/secure_storage.dart';
import 'package:algolens/features/profile/data/models/profile_model.dart';
import 'package:algolens/features/profile/data/models/rating_graph_model.dart';
import 'package:algolens/features/profile/data/models/submission_stats_model.dart';
import 'package:algolens/features/profile/data/models/contest_history_model.dart';
import 'package:algolens/features/profile/data/repositories/profile_repository.dart';

// ─────────────────────────────────
// CF HANDLE PROVIDER
// Reads own handle from
// SecureStorage
// Used by profile_screen to
// auto-load own profile
// ─────────────────────────────────

/// Reads cfHandle from SecureStorage
/// Returns null if not set
/// profile_screen watches this
/// to know whose profile to load
final cfHandleProvider =
    FutureProvider<String?>((ref) async {
  return SecureStorage.getCfHandle();
});

// ─────────────────────────────────
// PROFILE PROVIDER
// FutureProvider.family
// Takes handle as arg
// Checks Hive cache (5 min)
// ─────────────────────────────────

/// Profile data provider
///
/// Usage:
/// final handle = 'tourist';
/// ref.watch(
///   profileProvider(handle),
/// ).when(
///   loading: () => shimmer,
///   error: (e, s) => errorWidget,
///   data: (profile) => profileCard,
/// )
final profileProvider =
    FutureProvider.family<ProfileModel, String>((ref, handle) async {
  final repo = ref.read(profileRepositoryProvider);
  return repo.getProfile(handle);
});

// ─────────────────────────────────
// RATING GRAPH PROVIDER
// FutureProvider.family
// Takes handle as arg
// No cache — always fresh
// ─────────────────────────────────

/// Rating graph data provider
///
/// Returns list of rating points
/// for fl_chart line chart
/// in profile_screen
final ratingGraphProvider =
    FutureProvider.family<List<RatingGraphModel>, String>((ref, handle) async {
  final repo = ref.read(profileRepositoryProvider);
  return repo.getRatingGraph(handle);
});

// ─────────────────────────────────
// SUBMISSION STATS PROVIDER
// FutureProvider.family
// Takes handle as arg
// ─────────────────────────────────

/// Submission stats provider
///
/// Returns verdict counts:
/// AC / WA / TLE / MLE / RE
/// Used in profile_screen grid
final submissionStatsProvider =
    FutureProvider.family<SubmissionStatsModel, String>((ref, handle) async {
  final repo = ref.read(profileRepositoryProvider);
  return repo.getSubmissionStats(handle);
});

// ─────────────────────────────────
// CONTEST HISTORY PROVIDER
// FutureProvider.family
// Takes handle as arg
// ─────────────────────────────────

/// Contest history provider
///
/// Returns list of past contests
/// with rating changes
/// Used in profile_screen list
final contestHistoryProvider =
    FutureProvider.family<List<ContestHistoryModel>, String>((ref, handle) async {
  final repo = ref.read(profileRepositoryProvider);
  return repo.getContestHistory(handle);
});

// ─────────────────────────────────
// REFRESH HELPERS
// Call these to force refresh
// Invalidates cache and re-fetches
// ─────────────────────────────────

/// Refresh all profile data
/// for a given handle
///
/// Usage on pull-to-refresh:
/// refreshProfile(ref, handle);
void refreshProfile(Ref ref, String handle) {
  ref.invalidate(profileProvider(handle));
  ref.invalidate(ratingGraphProvider(handle));
  ref.invalidate(submissionStatsProvider(handle));
  ref.invalidate(contestHistoryProvider(handle));
}
