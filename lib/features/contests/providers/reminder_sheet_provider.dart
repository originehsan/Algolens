import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/features/contests/data/models/contest_model.dart';
import 'package:algolens/features/contests/data/models/reminder_selection_state.dart';
import 'package:algolens/features/contests/providers/contest_provider.dart';

/// Owns all reminder-sheet business logic: loading existing
/// reminders, toggling selection, validating against time
/// remaining, diffing for save, and persisting via the real
/// reminder providers (addReminderProvider / removeReminderProvider).
///
/// The widget layer only reads this state and calls these methods —
/// it contains zero business logic of its own.
final reminderSheetProvider = StateNotifierProvider.family
    <ReminderSheetNotifier, ReminderSelectionState, ContestModel>(
  (ref, contest) => ReminderSheetNotifier(ref, contest),
);

class ReminderSheetNotifier extends StateNotifier<ReminderSelectionState> {
  ReminderSheetNotifier(this._ref, ContestModel contest)
      : super(_initial(_ref, contest));

  final Ref _ref;
  Timer? _tickTimer;

  static ReminderSelectionState _initial(Ref ref, ContestModel contest) {
    final existing =
        ref.read(contestReminderProvider(contest.contestId)).toSet();
    final customExisting = existing
        .where((m) => !ReminderSelectionState.presetMinutes.contains(m))
        .toList();
    return ReminderSelectionState(
      contest: contest,
      savedMinutes: existing,
      selectedMinutes: existing,
      customMinutes: customExisting.isEmpty ? null : customExisting.first,
      isSaving: false,
    );
  }

  /// Re-evaluates time-dependent validity every 20s while the sheet
  /// is open, so a preset that was valid when opened correctly
  /// disables itself if the user lingers past its threshold.
  void startLiveValidation() {
    _tickTimer?.cancel();
    _tickTimer = Timer.periodic(const Duration(seconds: 20), (_) {
      // timeUntilStart is a getter — reassigning state with the same
      // values still triggers a rebuild, which is all that's needed
      // to re-evaluate isPresetValid / canPickCustom against now().
      state = state.copyWith();
    });
  }

  void togglePreset(int minutes) {
    if (!state.isPresetSelectable(minutes)) return;
    final next = {...state.selectedMinutes};
    if (next.contains(minutes)) {
      next.remove(minutes);
    } else {
      next.add(minutes);
    }
    state = state.copyWith(selectedMinutes: next);
  }

  void setCustom(int minutes) {
    final next = {...state.selectedMinutes};
    if (state.customMinutes != null) next.remove(state.customMinutes);
    next.add(minutes);
    state = state.copyWith(selectedMinutes: next, customMinutes: minutes);
  }

  void removeCustom() {
    final next = {...state.selectedMinutes};
    if (state.customMinutes != null) next.remove(state.customMinutes);
    state = state.copyWith(selectedMinutes: next, clearCustom: true);
  }

  Future<bool> save() async {
    if (!state.hasPendingChanges) return false;
    state = state.copyWith(isSaving: true);

    for (final minutes in state.toRemove) {
      await _ref.read(removeReminderProvider.notifier).remove(
            contestId: state.contest.contestId,
            minutesBefore: minutes,
          );
    }
    for (final minutes in state.toAdd) {
      await _ref.read(addReminderProvider.notifier).add(
            contestId: state.contest.contestId,
            contestName: state.contest.name,
            minutesBefore: minutes,
            startDateTime: state.contest.startDateTime,
          );
    }

    // addReminderProvider / removeReminderProvider already invalidate
    // contestReminderProvider internally — but invalidate again here
    // explicitly so any widget watching it (e.g. the bell icon via
    // contestHasReminderProvider) is guaranteed to refresh regardless
    // of call order or future changes to those notifiers.
    _ref.invalidate(contestReminderProvider(state.contest.contestId));

    state = state.copyWith(
      savedMinutes: state.selectedMinutes,
      isSaving: false,
    );
    return true;
  }

  Future<void> removeAll() async {
    state = state.copyWith(isSaving: true);
    await _ref
        .read(removeReminderProvider.notifier)
        .removeAll(state.contest.contestId);

    _ref.invalidate(contestReminderProvider(state.contest.contestId));

    state = state.copyWith(
      savedMinutes: {},
      selectedMinutes: {},
      clearCustom: true,
      isSaving: false,
    );
  }

  @override
  void dispose() {
    _tickTimer?.cancel();
    super.dispose();
  }
}