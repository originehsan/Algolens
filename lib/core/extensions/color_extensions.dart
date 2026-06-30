import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  /// Safe withValues wrapper
  /// Clamps alpha 0.0–1.0
  Color withSafeAlpha(double alpha) =>
      withValues(alpha: alpha.clamp(0.0, 1.0));

  /// Darken by [amount] 0.0–1.0
  Color darken(double amount) {
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }

  /// Lighten by [amount] 0.0–1.0
  Color lighten(double amount) {
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness((hsl.lightness + amount).clamp(0.0, 1.0))
        .toColor();
  }
}