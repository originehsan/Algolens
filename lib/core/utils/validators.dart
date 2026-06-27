// ─────────────────────────────────
// VALIDATORS
// Pure functions — no UI dependency
// Used across auth screens
// ─────────────────────────────────

/// Returns true if [email] is valid format.
bool isValidEmail(String email) {
  final regex = RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$');
  return regex.hasMatch(email.trim());
}

/// Returns true if [password] meets
/// minimum length requirement.
bool isValidPassword(String password) {
  return password.trim().length >= 8;
}

/// Returns true if [name] is non-empty.
bool isValidName(String name) {
  return name.trim().isNotEmpty;
}

/// Password strength score 0–4.
/// 0 = empty
/// 1 = weak  (length >= 8)
/// 2 = fair  (+ uppercase)
/// 3 = good  (+ digit)
/// 4 = strong (+ special char)
int passwordStrength(String password) {
  if (password.isEmpty) return 0;
  int score = 0;
  if (password.length >= 8) score++;
  if (password.contains(RegExp(r'[A-Z]'))) score++;
  if (password.contains(RegExp(r'[0-9]'))) score++;
  if (password.contains(
    RegExp(r'[!@#\$%^&*]'),
  )) {
    score++;
  }
  return score;
}
