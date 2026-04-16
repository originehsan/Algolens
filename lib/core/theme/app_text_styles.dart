import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // ── Display — screen titles ──
  static TextStyle get display => GoogleFonts.inter(
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
        height: 1.2,
      );

  // ── Title — large headings ──
  static TextStyle get title => GoogleFonts.inter(
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.3,
        height: 1.2,
      );

  // ── Heading — card titles ──
  static TextStyle get heading => GoogleFonts.inter(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: -0.2,
        height: 1.3,
      );

  // ── Subheading — section titles ──
  static TextStyle get subheading => GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  // ── Body — primary content ──
  static TextStyle get body => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  // ── Body Bold ──
  static TextStyle get bodyBold => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  // ── Caption — meta text ──
  // w500 minimum — no w400 for small text
  static TextStyle get caption => GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textMuted,
        height: 1.4,
      );

  // ── Caption Bold ──
  static TextStyle get captionBold => GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  // ── Hint — helper labels ──
  // w500 minimum — visible on dark bg
  static TextStyle get hint => GoogleFonts.inter(
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textHint,
        height: 1.4,
      );

  // ── Label — ALL CAPS section labels ──
  static TextStyle get label => GoogleFonts.inter(
        fontSize: 10.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textHint,
        letterSpacing: 0.8,
        height: 1.4,
      );

  // ── Badge text ──
  static TextStyle get badge => GoogleFonts.inter(
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.2,
      );

  // ── Monospace — numbers/ratings ──
  static TextStyle get mono => GoogleFonts.jetBrainsMono(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        height: 1.4,
      );

  // ── Mono Large — big metrics ──
  static TextStyle get monoLarge => GoogleFonts.jetBrainsMono(
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.1,
        letterSpacing: -0.5,
      );

  // ── Mono Small ──
  static TextStyle get monoSmall => GoogleFonts.jetBrainsMono(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  // ── Countdown timer ──
  static TextStyle get countdown => GoogleFonts.jetBrainsMono(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        letterSpacing: 1.0,
        height: 1.2,
      );
}
