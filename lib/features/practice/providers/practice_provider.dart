import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/storage/secure_storage.dart';
import 'package:algolens/features/practice/data/models/problem_model.dart';
import 'package:algolens/features/practice/data/models/weak_topic_model.dart';
import 'package:algolens/features/practice/data/repositories/practice_repository.dart';

// ─────────────────────────────────
// WEAK TOPICS PROVIDER
// Fetches weak topics for own handle
// ─────────────────────────────────

final weakTopicsProvider =
    FutureProvider<List<WeakTopicModel>>((ref) async {
  final handle = await SecureStorage.getCfHandle();
  if (handle == null || handle.isEmpty) {
    return [];
  }
  final repo = ref.read(practiceRepositoryProvider);
  final topics = await repo.getWeakTopics(handle);

  // Sort: critical → high → moderate
  topics.sort((a, b) {
    const order = {'critical': 0, 'high': 1, 'moderate': 2};
    return (order[a.severity] ?? 3).compareTo(order[b.severity] ?? 3);
  });

  return topics;
});

// ─────────────────────────────────
// RECOMMENDATIONS PROVIDER
// Fetches recommended problems
// for own handle
// ─────────────────────────────────

final recommendationsProvider =
    FutureProvider<List<ProblemModel>>((ref) async {
  final handle = await SecureStorage.getCfHandle();
  if (handle == null || handle.isEmpty) {
    return [];
  }
  final repo = ref.read(practiceRepositoryProvider);
  final problems = await repo.getRecommendations(handle);

  // Sort by rating ascending
  problems.sort((a, b) => a.rating.compareTo(b.rating));

  return problems;
});

final blindModeProvider = StateProvider<bool>((ref) => false);

final selectedTopicFilterProvider = StateProvider<String>((ref) => '');
