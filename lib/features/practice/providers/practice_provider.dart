import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/features/practice/data/repositories/practice_repository.dart';
import 'package:algolens/features/practice/data/models/weak_topic_model.dart';
import 'package:algolens/features/practice/data/models/problem_model.dart';

final practiceRepositoryProvider = Provider<PracticeRepository>((ref) {
  return PracticeRepository();
});

final weakTopicsProvider =
    FutureProvider.family<List<WeakTopic>, String>((ref, handle) async {
  final repo = ref.read(practiceRepositoryProvider);
  return repo.getWeakTopics(handle);
});

final recommendationsProvider =
    FutureProvider.family<List<Problem>, String>((ref, handle) async {
  final repo = ref.read(practiceRepositoryProvider);
  return repo.getRecommendations(handle);
});

final blindModeProvider = StateProvider<bool>((ref) => false);

final selectedTopicFilterProvider = StateProvider<String>((ref) => '');
