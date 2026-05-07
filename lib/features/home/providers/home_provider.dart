import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/local/hive_service.dart';
import 'package:algolens/features/home/data/models/home_model.dart';
import 'package:algolens/features/profile/providers/profile_provider.dart';

// ─────────────────────────────────
// READINESS SCORE PROVIDER
// Computed from profile data
// ─────────────────────────────────

/// Contest readiness score 0-100
///
/// Computed from:
/// → rating (40 pts max)
/// → streak (30 pts max)
/// → problems solved (20 pts max)
/// → contests participated (10 pts)
///
/// Used in home_screen hero section
final homeReadinessProvider = FutureProvider<ReadinessScore>((ref) async {
  // Watch cfHandleProvider to get own handle
  final handle = await ref.watch(cfHandleProvider.future);

  if (handle == null || handle.isEmpty) {
    return const ReadinessScore(
      score: 0,
      label: 'Set up handle',
      color: '#EF4444',
    );
  }

  // Watch profileProvider to get stats
  final profile = await ref.watch(profileProvider(handle).future);

  return ReadinessScore.fromProfile(
    rating: profile.rating,
    streakDays: profile.streakDays,
    problemsSolved: profile.problemsSolved,
    contestsParticipated: profile.contestsParticipated,
  );
});

// ─────────────────────────────────
// RATING DELTA PROVIDER
// Change from last contest
// ─────────────────────────────────

/// Rating delta from last contest
///
/// Reads from profile ratingDelta
/// Shows +17 or -5 on home card
final ratingDeltaProvider = FutureProvider<RatingDelta?>((ref) async {
  // Watch cfHandleProvider to get own handle
  final handle = await ref.watch(cfHandleProvider.future);

  if (handle == null || handle.isEmpty) {
    return null;
  }

  // Watch profileProvider to get delta
  final profile = await ref.watch(profileProvider(handle).future);

  return RatingDelta(
    delta: profile.ratingDelta.abs(),
    isPositive: profile.ratingDelta >= 0,
  );
});

// ─────────────────────────────────
// DISMISSED CONTESTS PROVIDER
// Reads dismissed contest IDs
// from Hive box
// ─────────────────────────────────

/// Set of dismissed contest IDs
///
/// Used by home_screen swipe stack
/// to filter out dismissed cards
/// Persisted in Hive box
final dismissedContestsProvider = StateProvider<Set<int>>((ref) {
  final box = HiveService.dismissedContests;
  return box.keys
      .map((k) => int.tryParse(k.toString()) ?? -1)
      .where((id) => id != -1)
      .toSet();
});

// ─────────────────────────────────
// DISMISS CONTEST PROVIDER
// Saves dismissed contestId
// to Hive + updates state
// ─────────────────────────────────

/// Dismiss a contest from swipe stack
///
/// Saves to Hive so it persists
/// across app restarts
/// Updates dismissedContestsProvider
final dismissContestProvider =
    StateNotifierProvider<DismissContestNotifier, Set<int>>(
  (ref) => DismissContestNotifier(),
);

class DismissContestNotifier extends StateNotifier<Set<int>> {
  DismissContestNotifier() : super(_loadDismissed());

  static Set<int> _loadDismissed() {
    final box = HiveService.dismissedContests;
    return box.keys
        .map((k) => int.tryParse(k.toString()) ?? -1)
        .where((id) => id != -1)
        .toSet();
  }

  Future<void> dismiss(int contestId) async {
    await HiveService.dismissedContests.put(
      '$contestId',
      DateTime.now().toIso8601String(),
    );
    state = {...state, contestId};
  }

  bool isDismissed(int contestId) => state.contains(contestId);
}
