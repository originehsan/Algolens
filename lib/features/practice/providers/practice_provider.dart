import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/storage/secure_storage.dart';
import 'package:algolens/features/practice/data/models/problem_model.dart';
import 'package:algolens/features/practice/data/models/weak_topic_model.dart';
import 'package:algolens/features/practice/data/repositories/practice_repository.dart';

final weakTopicsProvider = FutureProvider<List<WeakTopicModel>>((ref) async {
  final handle = await SecureStorage.getCfHandle();
  if (handle == null || handle.isEmpty) return [];

  final repo = ref.read(practiceRepositoryProvider);
  final topics = await repo.getWeakTopics(handle);

  topics.sort((a, b) {
    const order = {'critical': 0, 'high': 1, 'moderate': 2};
    return (order[a.severity] ?? 3).compareTo(order[b.severity] ?? 3);
  });

  return topics;
});

final recommendationsProvider = FutureProvider<List<ProblemModel>>((ref) async {
  final handle = await SecureStorage.getCfHandle();
  if (handle == null || handle.isEmpty) return [];

  final repo = ref.read(practiceRepositoryProvider);
  final problems = await repo.getRecommendations(handle);

  problems.sort((a, b) => a.rating.compareTo(b.rating));

  return problems;
});