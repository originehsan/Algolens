import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/local/hive_service.dart';
import 'package:algolens/features/contests/data/models/contest_model.dart';
import 'package:algolens/features/contests/data/repositories/contest_repository.dart';

// ─────────────────────────────────
// UPCOMING CONTESTS PROVIDER
// FutureProvider
// Hive cache 1 hour
// ─────────────────────────────────

/// Upcoming contests list
///
/// Cached in Hive 1 hour
/// Returns only upcoming + live
/// Sorted by start time ascending
///
/// Usage:
/// ref.watch(
///   upcomingContestsProvider,
/// ).when(
///   loading: () => shimmer,
///   error: (e, s) => errorWidget,
///   data: (contests) => list,
/// )
final upcomingContestsProvider = FutureProvider<List<ContestModel>>(
  (ref) async {
    final repo = ref.read(
      contestRepositoryProvider,
    );
    final all = await repo.getUpcomingContests();

    // Filter and sort
    final filtered = all
        .where(
          (c) => c.isUpcoming || c.isLive,
        )
        .toList()
      ..sort(
        (a, b) => a.startTimeSeconds.compareTo(
          b.startTimeSeconds,
        ),
      );

    return filtered;
  },
);

// ─────────────────────────────────
// ALL CONTESTS PROVIDER
// StateNotifierProvider
// Supports pagination
// ─────────────────────────────────

/// All contests with pagination
///
/// Use .notifier.loadMore()
/// to fetch next page
///
/// Usage:
/// ref.watch(
///   allContestsProvider,
/// ) → List<ContestModel>
///
/// ref.read(
///   allContestsProvider.notifier,
/// ).loadMore();
final allContestsProvider =
    StateNotifierProvider<AllContestsNotifier, AsyncValue<List<ContestModel>>>(
  (ref) => AllContestsNotifier(ref),
);

class AllContestsNotifier
    extends StateNotifier<AsyncValue<List<ContestModel>>> {
  AllContestsNotifier(this._ref)
      : super(
          const AsyncValue.loading(),
        ) {
    _load();
  }

  final Ref _ref;
  int _page = 0;
  bool _hasMore = true;
  bool _loading = false;
  final List<ContestModel> _contests = [];

  Future<void> _load() async {
    if (_loading || !_hasMore) return;
    _loading = true;

    try {
      final repo = _ref.read(
        contestRepositoryProvider,
      );
      final response = await repo.getAllContests(
        page: _page,
        size: 20,
      );

      // Extract contests from response
      final list = (response['contests'] ?? []) as List;
      final newItems = list
          .map(
            (e) => ContestModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();

      _contests.addAll(newItems);
      _page++;

      if (newItems.length < 20) {
        _hasMore = false;
      }

      state = AsyncValue.data(
        List.from(_contests),
      );
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    } finally {
      _loading = false;
    }
  }

  /// Load next page
  Future<void> loadMore() => _load();

  /// Refresh from start
  Future<void> refresh() async {
    _page = 0;
    _hasMore = true;
    _contests.clear();
    state = const AsyncValue.loading();
    await _load();
  }

  bool get hasMore => _hasMore;
  bool get isLoadingMore => _loading;
}

// ─────────────────────────────────
// CONTEST REMINDER PROVIDER
// Reads reminders for a contest
// from Hive box
// ─────────────────────────────────

/// Get reminder minutes for a contest
///
/// Returns List<int> of minutesBefore
/// e.g. [30, 60] means 2 reminders
/// Empty list = no reminders
///
/// Usage:
/// final mins = ref.watch(
///   contestReminderProvider(
///     contestId,
///   ),
/// );
/// final hasReminder =
///   mins.isNotEmpty;
final contestReminderProvider = Provider.family<List<int>, int>(
  (ref, contestId) {
    final box = HiveService.contestReminders;
    final reminders = <int>[];

    for (final key in box.keys) {
      final id = int.tryParse(
            key.toString(),
          ) ??
          0;
      if (id ~/ 100 == contestId) {
        try {
          final raw = box.get(key) as String?;
          if (raw != null) {
            final map = jsonDecode(raw) as Map<String, dynamic>;
            reminders.add(
              map['minutesBefore'] as int,
            );
          }
        } catch (_) {
          // Skip corrupted entry
        }
      }
    }

    return reminders;
  },
);

// ─────────────────────────────────
// ADD REMINDER PROVIDER
// Saves reminder to Hive
// Max 3 per contest
// ─────────────────────────────────

/// Add a contest reminder
///
/// Returns true if added
/// Returns false if max 3 reached
///
/// notifId = contestId * 100 + mins
///
/// Usage:
/// final added = await ref.read(
///   addReminderProvider.notifier,
/// ).add(
///   contestId: 1991,
///   contestName: 'CF Round 957',
///   minutesBefore: 30,
///   startDateTime: contest
///     .startDateTime,
/// );
final addReminderProvider = StateNotifierProvider<AddReminderNotifier, bool>(
  (ref) => AddReminderNotifier(ref),
);

class AddReminderNotifier extends StateNotifier<bool> {
  AddReminderNotifier(this._ref) : super(false);

  final Ref _ref;

  Future<bool> add({
    required int contestId,
    required String contestName,
    required int minutesBefore,
    required DateTime startDateTime,
  }) async {
    final box = HiveService.contestReminders;

    // Count existing reminders
    // for this contest
    int count = 0;
    for (final key in box.keys) {
      final id = int.tryParse(
            key.toString(),
          ) ??
          0;
      if (id ~/ 100 == contestId) {
        count++;
      }
    }

    // Max 3 reminders per contest
    if (count >= 3) return false;

    final notifId = contestId * 100 + minutesBefore;
    final scheduledAt = startDateTime.subtract(
      Duration(minutes: minutesBefore),
    );

    await box.put(
      '$notifId',
      jsonEncode({
        'contestId': contestId,
        'contestName': contestName,
        'minutesBefore': minutesBefore,
        'notificationId': notifId,
        'scheduledAt': scheduledAt.toIso8601String(),
        'isActive': true,
      }),
    );

    // Refresh reminder provider
    _ref.invalidate(
      contestReminderProvider(
        contestId,
      ),
    );

    return true;
  }
}

// ─────────────────────────────────
// REMOVE REMINDER PROVIDER
// Deletes reminder from Hive
// ─────────────────────────────────

/// Remove a contest reminder
///
/// Usage:
/// await ref.read(
///   removeReminderProvider.notifier,
/// ).remove(
///   contestId: 1991,
///   minutesBefore: 30,
/// );
final removeReminderProvider =
    StateNotifierProvider<RemoveReminderNotifier, bool>(
  (ref) => RemoveReminderNotifier(ref),
);

class RemoveReminderNotifier extends StateNotifier<bool> {
  RemoveReminderNotifier(this._ref) : super(false);

  final Ref _ref;

  Future<void> remove({
    required int contestId,
    required int minutesBefore,
  }) async {
    final notifId = contestId * 100 + minutesBefore;
    await HiveService.contestReminders.delete('$notifId');

    // Refresh reminder provider
    _ref.invalidate(
      contestReminderProvider(
        contestId,
      ),
    );
  }

  /// Remove ALL reminders
  /// for a contest
  Future<void> removeAll(
    int contestId,
  ) async {
    final box = HiveService.contestReminders;
    final toDelete = box.keys.where((k) {
      final id = int.tryParse(
            k.toString(),
          ) ??
          0;
      return id ~/ 100 == contestId;
    }).toList();

    for (final key in toDelete) {
      await box.delete(key);
    }

    _ref.invalidate(
      contestReminderProvider(
        contestId,
      ),
    );
  }
}
