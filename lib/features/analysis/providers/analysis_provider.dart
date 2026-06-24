import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/core/storage/secure_storage.dart';
import 'package:algolens/features/analysis/data/models/analysis_model.dart';
import 'package:algolens/features/analysis/data/repositories/analysis_repository.dart';

// 4 states for analysis lifecycle
sealed class AnalysisState {
  const AnalysisState();
}

/// Initial — user hasn't tapped "Run Analysis" yet
class AnalysisIdle extends AnalysisState {
  const AnalysisIdle();
}

/// Fetching from Groq AI — takes 5-30 seconds
class AnalysisLoading extends AnalysisState {
  const AnalysisLoading();
}

/// Analysis complete — results ready to display
class AnalysisSuccess extends AnalysisState {
  const AnalysisSuccess({required this.response});
  final AnalysisResponse response;
}

/// Analysis failed — show error + retry
class AnalysisError extends AnalysisState {
  const AnalysisError({required this.message});
  final String message;
}

// User manually triggers fetch via .notifier.runAnalysis()
// Not auto-fetched on screen load
final aiAnalysisProvider =
    StateNotifierProvider<AiAnalysisNotifier, AnalysisState>(
  (ref) => AiAnalysisNotifier(ref),
);

class AiAnalysisNotifier extends StateNotifier<AnalysisState> {
  AiAnalysisNotifier(this._ref) : super(const AnalysisIdle());

  final Ref _ref;

  Future<void> runAnalysis() async {
    state = const AnalysisLoading();
    try {
      // Get CF handle from SecureStorage — never from API
      final handle = await SecureStorage.getCfHandle();
      if (handle == null || handle.isEmpty) {
        state = const AnalysisError(
          message:
              'No CF handle found. Please set up your handle first.',
        );
        return;
      }

      final repo = _ref.read(analysisRepositoryProvider);
      final response = await repo.getAnalysis(handle);

      state = AnalysisSuccess(response: response);
    } on ApiException catch (e) {
      // ApiException already has user-friendly message
      state = AnalysisError(message: e.message);
    } catch (e) {
      // Unknown error — show generic message, not raw exception
      state = const AnalysisError(
        message: 'Analysis failed. Please try again.',
      );
    }
  }

  // Reset back to idle — used by refresh button
  void reset() => state = const AnalysisIdle();
}