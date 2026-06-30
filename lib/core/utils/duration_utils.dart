abstract class DurationUtils {
  DurationUtils._();

  /// Format seconds to "2h 30m"
  /// Used for contest duration display
  static String formatSeconds(int totalSeconds) {
    final hours   = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    if (hours > 0 && minutes > 0) return '${hours}h ${minutes}m';
    if (hours > 0) return '${hours}h';
    return '${minutes}m';
  }

  /// Format Duration to countdown
  /// "02:14:33" or "1d 02:14:33"
  static String formatCountdown(Duration d) {
    if (d == Duration.zero) return '00:00:00';
    final days    = d.inDays;
    final hours   = d.inHours.remainder(24).toString().padLeft(2, '0');
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (days > 0) return '${days}d $hours:$minutes:$seconds';
    return '$hours:$minutes:$seconds';
  }

  /// Remaining duration from now
  /// Returns Duration.zero if past
  static Duration remaining(DateTime target) {
    final diff = target.difference(DateTime.now());
    return diff.isNegative ? Duration.zero : diff;
  }
}