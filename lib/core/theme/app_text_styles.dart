import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:algolens/core/theme/app_colors.dart';

/// AlgoLens Typography System
///
/// FONTS:
/// → Inter for all UI text
/// → JetBrains Mono for numbers only
///
/// RULES:
/// → No gray hex colors
/// → All colors from AppColors
/// → Min w500 for small text
/// → Min w600 for labels
/// → Min w700 for headings
/// → Min opacity 0.50

class AppTextStyles {
  AppTextStyles._();

  // ──────────────────────────────
  // DISPLAY
  // App logo / hero text
  // ──────────────────────────────

  /// AlgoLens logo
  /// Used on splash + auth screens
  static TextStyle get display => GoogleFonts.inter(
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        letterSpacing: -1.0,
        height: 1.1,
      );

  // ──────────────────────────────
  // HEADINGS
  // ──────────────────────────────

  /// Screen titles
  /// "Home" "Contests" "Friends"
  static TextStyle get h1 => GoogleFonts.inter(
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
        height: 1.2,
      );

  /// Card titles
  /// "Codeforces Rating"
  static TextStyle get h2 => GoogleFonts.inter(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: -0.3,
        height: 1.3,
      );

  /// Section headings
  /// "Weak Topics" "Upcoming"
  static TextStyle get h3 => GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: -0.2,
        height: 1.3,
      );

  /// Sub headings
  /// Contest names, problem titles
  static TextStyle get h4 => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.4,
      );

  // ──────────────────────────────
  // BODY
  // ──────────────────────────────

  /// Primary body text
  /// Card content, descriptions
  /// w500 minimum — not w400
  static TextStyle get body => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  /// Body bold
  /// Emphasized content
  static TextStyle get bodyBold => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  /// Small body
  /// Secondary card content
  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  // ──────────────────────────────
  // CAPTION
  // Meta + helper text
  // Min w500 — never w400 for small
  // ──────────────────────────────

  /// Meta text
  /// "2 hours ago" "Rated 2100"
  static TextStyle get caption => GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textMuted,
        height: 1.4,
      );

  /// Caption bold
  /// Tags, emphasized small text
  static TextStyle get captionBold => GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  /// Helper / hint text
  /// Input placeholders, sublabels
  /// Min opacity 0.50 (textHint)
  static TextStyle get hint => GoogleFonts.inter(
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textHint,
        height: 1.4,
      );

  // ──────────────────────────────
  // LABELS
  // ALL CAPS section headers
  // ──────────────────────────────

  /// Section label ALL CAPS
  /// "CODEFORCES RATING"
  /// "UPCOMING CONTESTS"
  static TextStyle get label => GoogleFonts.inter(
        fontSize: 10.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textHint,
        letterSpacing: 0.8,
        height: 1.4,
      );

  /// Tab label inactive
  static TextStyle get tabLabel => GoogleFonts.inter(
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textMuted,
        height: 1.2,
      );

  /// Tab label active
  static TextStyle get tabLabelActive => GoogleFonts.inter(
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
        height: 1.2,
      );

  // ──────────────────────────────
  // BUTTONS
  // ──────────────────────────────

  /// Primary button text
  static TextStyle get button => GoogleFonts.inter(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 0.2,
        height: 1.2,
      );

  /// Small button text
  static TextStyle get buttonSmall => GoogleFonts.inter(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 0.1,
        height: 1.2,
      );

  // ──────────────────────────────
  // CHIPS + BADGES
  // ──────────────────────────────

  /// Chip text
  /// Rank chips, difficulty chips
  static TextStyle get chip => GoogleFonts.inter(
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        height: 1.2,
      );

  // ──────────────────────────────
  // MONOSPACE
  // JetBrains Mono — numbers only
  // ──────────────────────────────

  /// Large metric
  /// Rating: "1,487"
  /// Big numbers on cards
  static TextStyle get metricLarge => GoogleFonts.jetBrainsMono(
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
        height: 1.1,
      );

  /// Medium metric
  /// Smaller ratings, scores
  static TextStyle get metricMedium => GoogleFonts.jetBrainsMono(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.1,
      );

  /// Small metric
  /// Stats row numbers
  static TextStyle get metricSmall => GoogleFonts.jetBrainsMono(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.1,
      );

  /// Countdown timer
  /// "02:14:33"
  /// Always primary color
  static TextStyle get countdown => GoogleFonts.jetBrainsMono(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        letterSpacing: 1.0,
        height: 1.1,
      );

  /// Countdown large
  /// Home screen next contest
  static TextStyle get countdownLarge => GoogleFonts.jetBrainsMono(
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        letterSpacing: 1.5,
        height: 1.1,
      );

  /// Mono small
  /// Problem ratings "2100"
  static TextStyle get monoSmall => GoogleFonts.jetBrainsMono(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        height: 1.2,
      );

  // ──────────────────────────────
  // INPUT
  // ──────────────────────────────

  /// Input field text
  static TextStyle get input => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        height: 1.4,
      );

  /// Input placeholder
  static TextStyle get inputHint => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textHint,
        height: 1.4,
      );

  // ──────────────────────────────
  // LINKS
  // ──────────────────────────────

  /// Tappable link
  /// "Sign In" "Forgot Password?"
  static TextStyle get link => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
        height: 1.4,
      );

  /// Small link
  static TextStyle get linkSmall => GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
        height: 1.4,
      );

  // ──────────────────────────────
  // COLOR HELPERS
  // Apply color to any style
  // ──────────────────────────────

  /// Apply primary color
  static TextStyle primary(
    TextStyle style,
  ) =>
      style.copyWith(
        color: AppColors.primary,
      );

  /// Apply success color
  static TextStyle success(
    TextStyle style,
  ) =>
      style.copyWith(
        color: AppColors.success,
      );

  /// Apply danger color
  static TextStyle danger(
    TextStyle style,
  ) =>
      style.copyWith(
        color: AppColors.danger,
      );

  /// Apply warning color
  static TextStyle warning(
    TextStyle style,
  ) =>
      style.copyWith(
        color: AppColors.warning,
      );

  /// Apply muted color
  static TextStyle muted(
    TextStyle style,
  ) =>
      style.copyWith(
        color: AppColors.textMuted,
      );
}
