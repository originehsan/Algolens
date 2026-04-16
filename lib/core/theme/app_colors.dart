import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Backgrounds ──
  // Deep navy base
  static const Color bgDark = Color(0xFF0B1E3A);
  static const Color bgMid = Color(0xFF132A4A);
  static const Color bgLight = Color(0xFF0F2040);
  static const Color bgEdge = Color(0xFF081426);

  // ── Glass Card System ──
  // bg: rgba(255,255,255,0.09→0.04) gradient
  // border: rgba(255,255,255,0.14)
  static const Color glassBg = Color(0x17FFFFFF);
  static const Color glassBorder = Color(0x24FFFFFF);
  static const Color glassHighlight = Color(0x17FFFFFF);
  static const Color glassHighlight2 = Color(0x0AFFFFFF);
  static const Color glassShadow = Color(0x73000000);

  // ── 4 Accent Colors ONLY ──
  static const Color primary = Color(0xFF4DA3FF);
  static const Color success = Color(0xFF22C55E);
  static const Color danger = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  // ── Semantic aliases ──
  static const Color primaryLight = Color(0xFF4DA3FF);
  static const Color primaryDark = Color(0xFF2563EB);
  static const Color primaryGlow = Color(0x1F4DA3FF);

  // ── Text — WHITE WITH OPACITY ONLY ──
  // NO gray hex values allowed
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xCCFFFFFF); // 80%
  static const Color textMuted = Color(0x99FFFFFF); // 60%
  static const Color textHint = Color(0x80FFFFFF); // 50%

  // ── CF Rank Colors ──
  // Used ONLY in RankChip widget
  static const Color cfNewbie = Color(0xFF808080);
  static const Color cfPupil = Color(0xFF008000);
  static const Color cfSpecialist = Color(0xFF03A89E);
  static const Color cfExpert = Color(0xFF3B82F6);
  static const Color cfCM = Color(0xFFAA00AA);
  static const Color cfMaster = Color(0xFFFF8C00);
  static const Color cfGM = Color(0xFFFF3333);

  // ── Dividers ──
  static const Color divider = Color(0x1AFFFFFF);
  static const Color dividerStrong = Color(0x26FFFFFF);

  // ── Card Glow Colors ──
  static const Color glowPrimary = Color(0x1F4DA3FF);
  static const Color glowSuccess = Color(0x1F22C55E);
  static const Color glowDanger = Color(0x1FEF4444);
  static const Color glowWarning = Color(0x1FF59E0B);

  // ── Utility ──
  static const Color transparent = Color(0x00000000);
  static const Color overlay = Color(0x80000000);
  static const Color scrim = Color(0xCC000000);

  // ── Background orbs ──
  // Used in AppBackground radial gradients
  static const Color orbBlue1 = Color(0xCC2563EB); // 80%
  static const Color orbBlue2 = Color(0xB31D4ED8); // 70%

  // ── Rank color helper ──
  static Color rankColor(String rank) {
    final r = rank.toLowerCase();
    if (r.contains('legendary') || r.contains('international')) return cfGM;
    if (r.contains('grandmaster')) return cfGM;
    if (r.contains('master')) return cfMaster;
    if (r.contains('candidate')) return cfCM;
    if (r.contains('expert')) return cfExpert;
    if (r.contains('specialist')) return cfSpecialist;
    if (r.contains('pupil')) return cfPupil;
    return cfNewbie;
  }

  // ── Glow for card type ──
  static Color glowForCard(
    String type,
  ) {
    switch (type) {
      case 'primary':
        return glowPrimary;
      case 'success':
        return glowSuccess;
      case 'danger':
        return glowDanger;
      case 'warning':
        return glowWarning;
      default:
        return glowPrimary;
    }
  }
}
