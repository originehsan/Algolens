extension DateTimeExtensions on DateTime {
  /// Is same calendar day as now?
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Is tomorrow?
  bool get isTomorrow {
    final t = DateTime.now().add(const Duration(days: 1));
    return year == t.year && month == t.month && day == t.day;
  }

  /// Remaining duration from now
  /// Returns Duration.zero if past
  Duration get remaining {
    final diff = difference(DateTime.now());
    return diff.isNegative ? Duration.zero : diff;
  }

  /// Unix epoch seconds
  int get toEpochSeconds => millisecondsSinceEpoch ~/ 1000;

  /// Short readable "Apr 13"
  String get toShortDate {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[month - 1]} $day';
  }
}