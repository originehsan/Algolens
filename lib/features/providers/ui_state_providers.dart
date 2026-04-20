import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// ──────────────────────────────
// UI STATE PROVIDERS
// Feature-level UI state
// ──────────────────────────────

// ────────────────────────────
// CONNECTIVITY STREAM
// Live internet status
// ────────────────────────────

/// Live connectivity stream
///
/// Emits ConnectivityResult
/// whenever network changes
///
/// Used by offline_banner.dart
/// to show/hide automatically
///
/// Usage:
/// ref.watch(
///   connectivityStreamProvider,
/// ).when(
///   loading: () => ...,
///   error: (e, s) => ...,
///   data: (result) => ...,
/// );
final connectivityStreamProvider = StreamProvider<List<ConnectivityResult>>(
  (ref) {
    return Connectivity().onConnectivityChanged;
  },
);

// ────────────────────────────
// SEARCH QUERY
// Used in friends search
// ────────────────────────────

/// Current search query string
/// for friends search input
///
/// Reset to empty on screen
/// dispose
final friendSearchQueryProvider = StateProvider<String>(
  (ref) => '',
);

// ────────────────────────────
// CONTEST TAB INDEX
// Upcoming / Live / All tabs
// ────────────────────────────

/// Active tab in contests screen
///
/// 0 = Upcoming
/// 1 = Live
/// 2 = All
final contestTabIndexProvider = StateProvider<int>((ref) => 0);

// ────────────────────────────
// UPSOLVE TAB INDEX
// Pending / Solved tabs
// ────────────────────────────

/// Active tab in upsolve screen
///
/// 0 = Pending
/// 1 = Solved
final upsolveTabIndexProvider = StateProvider<int>((ref) => 0);

// ────────────────────────────
// FRIENDS TAB INDEX
// Friends / Leaderboard /
// Streaks tabs
// ────────────────────────────

/// Active tab in friends screen
///
/// 0 = Friends
/// 1 = Leaderboard
/// 2 = Streaks
final friendsTabIndexProvider = StateProvider<int>((ref) => 0);

// ────────────────────────────
// LOADING STATES
// Per-action loading flags
// ────────────────────────────

/// Whether add friend action
/// is in progress
final addFriendLoadingProvider = StateProvider<bool>((ref) => false);

/// Whether sync action
/// is in progress
/// Used in settings screen
final syncLoadingProvider = StateProvider<bool>((ref) => false);

/// Whether logout action
/// is in progress
final logoutLoadingProvider = StateProvider<bool>((ref) => false);
