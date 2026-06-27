import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// ═════════════════════════════════
// NAVIGATION UTILS
// Shared navigation helpers
// Used by: login, home screens
// ═════════════════════════════════

/// Double back to exit app.
/// First press → snackbar warning
/// Second press within 2s → exit
///
/// Usage in onPopInvokedWithResult:
/// handleDoubleBackExit(
///   context: context,
///   lastBackPress: _lastBackPress,
///   onUpdate: (t) => _lastBackPress = t,
/// );
void handleDoubleBackExit({
  required BuildContext context,
  required DateTime? lastBackPress,
  required void Function(DateTime) onUpdate,
}) {
  final now = DateTime.now();
  if (lastBackPress == null ||
      now.difference(lastBackPress) >
          const Duration(seconds: 2)) {
    onUpdate(now);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Press back again to exit',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor:
            Colors.black.withValues(alpha: 0.85),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    return;
  }
  SystemNavigator.pop();
}