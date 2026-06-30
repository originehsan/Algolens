import 'package:algolens/features/contests/data/models/contest_model.dart';

/// Pure data — the current state of the reminder-setting sheet
/// for one contest. No Flutter, no business logic, just facts
/// and derived getters computed from those facts.
class ReminderSelectionState {
  const ReminderSelectionState({
    required this.contest,
    required this.savedMinutes,
    required this.selectedMinutes,
    required this.customMinutes,
    required this.isSaving,
  });

  final ContestModel contest;

  /// What's actually persisted in Hive right now.
  final Set<int> savedMinutes;

  /// What the user has currently checked in the sheet —
  /// starts as a copy of [savedMinutes], mutated by toggles.
  final Set<int> selectedMinutes;

  /// The custom interval value, if the user picked one.
  /// Null means no custom reminder is configured.
  final int? customMinutes;

  final bool isSaving;

  static const presetMinutes = [30, 60, 120];
  static const maxReminders = 3;

  /// Minimum window for the custom picker to be meaningfully usable.
  /// Below this, there isn't enough range to "pick" anything distinct.
  static const minCustomWindowMinutes = 2;

  /// Custom reminders are fixed to a 3hr–12hr-before window.
  static const customMinMinutes = 180; // 3 hours
  static const customMaxMinutes = 720; // 12 hours

  // ── Derived facts — computed fresh every read, never stored ──

  Duration get timeUntilStart =>
      contest.startDateTime.difference(DateTime.now());

  bool get isLive => contest.isLive;

  bool get hasAnySaved => savedMinutes.isNotEmpty;

  /// True if there's an actual difference between what's saved
  /// and what's currently selected — i.e. the save button should
  /// be visible and active.
  bool get hasPendingChanges => !_setEquals(savedMinutes, selectedMinutes);

  Set<int> get toAdd => selectedMinutes.difference(savedMinutes);
  Set<int> get toRemove => savedMinutes.difference(selectedMinutes);

  bool isPresetValid(int minutes) => timeUntilStart.inMinutes > minutes;

  bool isPresetSelectable(int minutes) =>
      isPresetValid(minutes) &&
      (selectedMinutes.length < maxReminders ||
          selectedMinutes.contains(minutes));

  /// Custom is only pickable if the contest is at least 3hr away —
  /// below that, no value in the 3hr-12hr window is still valid.
  bool get canPickCustom =>
      timeUntilStart.inMinutes >= customMinMinutes &&
      (selectedMinutes.length < maxReminders ||
          (customMinutes != null && selectedMinutes.contains(customMinutes)));

  /// The slider's actual usable max — 12hr, unless the contest
  /// starts sooner than that, in which case it clamps down so the
  /// user can never drag past "now."
  int get customSliderMaxMinutes => timeUntilStart.inMinutes < customMaxMinutes
      ? timeUntilStart.inMinutes
      : customMaxMinutes;

  /// Fixed 5-minute steps across the 3-12hr range — fine enough to
  /// be useful, coarse enough that the slider isn't fiddly.
  int get customSliderDivisionStep => 5;

  ReminderSelectionState copyWith({
    Set<int>? savedMinutes,
    Set<int>? selectedMinutes,
    int? customMinutes,
    bool clearCustom = false,
    bool? isSaving,
  }) {
    return ReminderSelectionState(
      contest: contest,
      savedMinutes: savedMinutes ?? this.savedMinutes,
      selectedMinutes: selectedMinutes ?? this.selectedMinutes,
      customMinutes: clearCustom ? null : (customMinutes ?? this.customMinutes),
      isSaving: isSaving ?? this.isSaving,
    );
  }

  static bool _setEquals(Set<int> a, Set<int> b) =>
      a.length == b.length && a.containsAll(b);
}
