import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

// Tab selection for screens
final upsolveTabIndexProvider = StateProvider<int>((ref) => 0);

final contestTabIndexProvider = StateProvider<int>((ref) => 0);

final allContestsPageProvider = StateProvider<int>((ref) => 1);

final friendsTabIndexProvider = StateProvider<int>((ref) => 0);

final recommendationsTabIndexProvider = StateProvider<int>((ref) => 0);

// Settings screens
final contestRemindersProvider = StateProvider<bool>((ref) => true);

final streakRemindersProvider = StateProvider<bool>((ref) => true);

final appVersionProvider = FutureProvider<String?>((ref) async {
  try {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  } catch (e) {
    return null;
  }
});

// Comparison screen
final comparisonLoadingProvider = StateProvider<bool>((ref) => false);

final comparisonResultProvider = StateProvider<dynamic>((ref) => null);
