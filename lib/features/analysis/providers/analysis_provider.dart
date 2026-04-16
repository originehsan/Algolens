import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/features/analysis/data/repositories/analysis_repository.dart';
import 'package:algolens/features/analysis/data/models/analysis_model.dart';

final analysisRepositoryProvider = Provider<AnalysisRepository>((ref) {
  return AnalysisRepository();
});

final aiAnalysisProvider =
    FutureProvider.family<AiAnalysisResponse, String>((ref, handle) async {
  final repo = ref.read(analysisRepositoryProvider);
  return repo.getAiAnalysis(handle);
});
