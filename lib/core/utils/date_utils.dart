import 'package:algolens/core/constants/app_strings.dart';

abstract class AppDateUtils {
  AppDateUtils._();

  /// Time-based greeting string
  /// Good morning / afternoon /
  /// evening / Hey
  static String greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return AppStrings.greetMorning;
    if (hour < 17) return AppStrings.greetAfternoon;
    if (hour < 21) return AppStrings.greetEvening;
    return AppStrings.greetNight;
  }

  /// Convert Unix epoch seconds
  /// to DateTime (UTC→local)
  static DateTime fromEpochSeconds(int seconds) =>
      DateTime.fromMillisecondsSinceEpoch(seconds * 1000);

  /// Format DateTime to readable
  /// "Apr 13, 2026 · 9:00 PM"
  static String toReadable(DateTime dt) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final h = dt.hour > 12 ? dt.hour - 12 : dt.hour == 0 ? 12 : dt.hour;
    final m = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '${months[dt.month - 1]} ${dt.day}, ${dt.year} · $h:$m $period';
  }

  /// Format DateTime to short date
  /// "Apr 13"
  static String toShortDate(DateTime dt) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[dt.month - 1]} ${dt.day}';
  }

  /// ISO-8601 date string
  /// "2026-04-13" → DateTime
  static DateTime fromIsoDate(String iso) =>
      DateTime.parse(iso);

  /// Is same calendar day?
  static bool isToday(DateTime dt) {
    final now = DateTime.now();
    return dt.year == now.year &&
        dt.month == now.month &&
        dt.day == now.day;
  }

  /// Is tomorrow?
  static bool isTomorrow(DateTime dt) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return dt.year == tomorrow.year &&
        dt.month == tomorrow.month &&
        dt.day == tomorrow.day;
  }
}