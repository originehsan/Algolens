import 'package:flutter/material.dart';

/// AlgoLens Color System
///
/// RULES:
/// → Only 4 accent colors
/// → No gray hex for text
/// → All text = white with opacity
/// → Min opacity 0.50
/// → No purple anywhere ever

class AppColors {
  AppColors._();

  // ──────────────────────────────
  // BACKGROUND SYSTEM
  // Deep navy — NOT black
  // ──────────────────────────────

  static const Color bgBase = Color(0xFF0B1E3A);
  static const Color bgCenter = Color(0xFF132A4A);
  static const Color bgEdge = Color(0xFF081426);
  static const Color bgMid = Color(0xFF0F2040);

  // ──────────────────────────────
  // BLUE ORBS
  // Used ONLY in AppBackground
  // Top-right + bottom-left
  // NO purple orb ever
  // ──────────────────────────────

  static const Color orbBlue1 = Color(0xCC2563EB); // 80%
  static const Color orbBlue2 = Color(0xB31D4ED8); // 70%

  // ──────────────────────────────
  // GLASS CARD SYSTEM
  // ──────────────────────────────

  static const Color glassBg1 = Color(0x17FFFFFF); // white 9%
  static const Color glassBg2 = Color(0x0AFFFFFF); // white 4%
  static const Color glassBorder = Color(0x24FFFFFF); // white 14%
  static const Color glassShadow = Color(0x73000000); // black 45%

  // ──────────────────────────────
  // 4 ACCENT COLORS ONLY
  // Never add more accents
  // ──────────────────────────────

  static const Color primary = Color(0xFF4DA3FF);
  static const Color success = Color(0xFF22C55E);
  static const Color danger = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  // ──────────────────────────────
  // PRIMARY VARIANTS
  // ──────────────────────────────

  static const Color primaryDark = Color(0xFF2563EB);
  static const Color primaryDeep = Color(0xFF1D4ED8);

  // ──────────────────────────────
  // TEXT COLORS
  // WHITE WITH OPACITY ONLY
  // NO gray hex values ever
  // Min opacity = 0.50
  // ──────────────────────────────

  /// 100% white — headings
  static const Color textPrimary = Color(0xFFFFFFFF);

  /// 80% white — body text
  static const Color textSecondary = Color(0xCCFFFFFF);

  /// 78% white — content
  static const Color textBody = Color(0xC7FFFFFF);

  /// 60% white — meta text
  static const Color textMuted = Color(0x99FFFFFF);

  /// 50% white — hint text
  /// This is the MINIMUM opacity
  /// Never go below this
  static const Color textHint = Color(0x80FFFFFF);

  // ──────────────────────────────
  // GLOW COLORS
  // Used in card BoxShadow
  // ──────────────────────────────

  static const Color glowPrimary = Color(0x1F4DA3FF); // 12%
  static const Color glowSuccess = Color(0x1F22C55E); // 12%
  static const Color glowDanger = Color(0x1FEF4444); // 12%
  static const Color glowWarning = Color(0x1FF59E0B); // 12%

  // ──────────────────────────────
  // CARD BORDER COLORS
  // For semantic card borders
  // ──────────────────────────────

  static const Color borderPrimary = Color(0x4D4DA3FF); // 30%
  static const Color borderSuccess = Color(0x4D22C55E); // 30%
  static const Color borderDanger = Color(0x4DEF4444); // 30%
  static const Color borderWarning = Color(0x48F59E0B); // 28%

  // ──────────────────────────────
  // CF RANK COLORS
  // Used ONLY in RankChip widget
  // Do NOT use elsewhere
  // ──────────────────────────────

  static const Color rankNewbie = Color(0xFF808080);
  static const Color rankPupil = Color(0xFF008000);
  static const Color rankSpecialist = Color(0xFF03A89E);
  static const Color rankExpert = Color(0xFF3B82F6);
  static const Color rankCM = Color(0xFFAA00AA);
  static const Color rankMaster = Color(0xFFFF8C00);
  static const Color rankGM = Color(0xFFFF3333);
  static const Color rankLGM = Color(0xFFFF0000);

  // ──────────────────────────────
  // DIVIDERS
  // ──────────────────────────────

  static const Color divider = Color(0x1AFFFFFF); // 10%
  static const Color dividerStrong = Color(0x26FFFFFF); // 15%

  // ──────────────────────────────
  // UTILITY
  // ──────────────────────────────

  static const Color transparent = Colors.transparent;
  static const Color overlay = Color(0x80000000); // 50%
  static const Color scrim = Color(0xCC000000); // 80%
  static const Color navBg = Color(0x99000000); // 60%

  // ──────────────────────────────
  // HELPER METHODS
  // ──────────────────────────────

  /// Get rank color from rank string
  /// Use ONLY in RankChip widget
  static Color rankColor(String rank) {
    final r = rank.toLowerCase();
    if (r.contains('legendary') || r.contains('international')) return rankLGM;
    if (r.contains('grandmaster')) return rankGM;
    if (r.contains('master')) return rankMaster;
    if (r.contains('candidate')) return rankCM;
    if (r.contains('expert')) return rankExpert;
    if (r.contains('specialist')) return rankSpecialist;
    if (r.contains('pupil')) return rankPupil;
    return rankNewbie;
  }

  /// Get glow color for card type
  static Color glowFor(String type) {
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

  /// Get border color for card type
  static Color borderFor(String type) {
    switch (type) {
      case 'primary':
        return borderPrimary;
      case 'success':
        return borderSuccess;
      case 'danger':
        return borderDanger;
      case 'warning':
        return borderWarning;
      default:
        return glassBorder;
    }
  }
}
