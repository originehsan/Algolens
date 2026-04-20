import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/features/contests/data/repositories/contest_repository.dart';
import 'package:algolens/features/contests/data/models/contest_model.dart';

final contestRepositoryProvider = Provider<ContestRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ContestRepository(dioClient);
});

final upcomingContestsProvider = FutureProvider<List<Contest>>((ref) async {
  final repo = ref.read(contestRepositoryProvider);
  return repo.getUpcomingContests();
});

final allContestsProvider =
    FutureProvider.family<Map<String, dynamic>, int>((ref, page) async {
  final repo = ref.read(contestRepositoryProvider);
  return repo.getAllContests(page: page);
});
