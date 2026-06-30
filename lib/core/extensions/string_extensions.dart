extension StringExtensions on String {
  /// First letter uppercase
  /// "specialist" → "Specialist"
  String get capitalized =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  /// First letter of string
  /// Used for avatar initials
  String get initial =>
      isEmpty ? '?' : this[0].toUpperCase();

  /// Truncate with ellipsis
  /// "Codeforces Round 900..." 
  String truncate(int maxLength) =>
      length <= maxLength ? this : '${substring(0, maxLength)}...';

  /// Is valid CF handle?
  /// 3–24 chars, alphanumeric + _
  bool get isValidCfHandle {
    if (length < 3 || length > 24) return false;
    return RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(this);
  }

  /// Is valid phone (international)?
  /// Must start with +
  bool get isValidPhone =>
      RegExp(r'^\+[1-9]\d{7,14}$').hasMatch(trim());

  /// Is 6-digit OTP?
  bool get isValidOtp =>
      RegExp(r'^\d{6}$').hasMatch(trim());
}