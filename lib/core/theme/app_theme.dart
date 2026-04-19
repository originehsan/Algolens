import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';

/// AlgoLens Theme System
///
/// RULES:
/// → Dark theme ONLY
/// → No light theme
/// → Inter font throughout
/// → Transparent AppBar always
/// → Page transition: scale + fade

class AppTheme {
  AppTheme._();

  // ──────────────────────────────
  // DARK THEME
  // Only theme in AlgoLens
  // ──────────────────────────────

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Color scheme
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.success,
        surface: AppColors.bgBase,
        onSurface: AppColors.textPrimary,
        error: AppColors.danger,
        onPrimary: AppColors.textPrimary,
        onSecondary: AppColors.textPrimary,
        onError: AppColors.textPrimary,
      ),

      // Background
      scaffoldBackgroundColor: AppColors.bgBase,

      // Google Fonts Inter globally
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme,
      ).apply(
        bodyColor: AppColors.textSecondary,
        displayColor: AppColors.textPrimary,
      ),

      // AppBar — always transparent
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        titleTextStyle: AppTextStyles.h2,
        iconTheme: IconThemeData(
          color: AppColors.textPrimary,
          size: 20,
        ),
        actionsIconTheme: IconThemeData(
          color: AppColors.textPrimary,
          size: 20,
        ),
      ),

      // Bottom navigation
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.navBg,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textHint,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: AppTextStyles.tabLabelActive,
        unselectedLabelStyle: AppTextStyles.tabLabel,
      ),

      // Icons
      iconTheme: IconThemeData(
        color: AppColors.textMuted,
        size: 20,
      ),

      // Divider
      dividerTheme: DividerThemeData(
        color: AppColors.divider,
        thickness: 0.5,
        space: 0,
      ),

      // SnackBar — floating glass style
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.07),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.glassBorder,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.glassBorder,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.primary.withValues(alpha: 0.55),
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.danger.withValues(alpha: 0.55),
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.danger.withValues(alpha: 0.75),
            width: 1.5,
          ),
        ),
        hintStyle: AppTextStyles.inputHint,
        labelStyle: AppTextStyles.body,
        errorStyle: AppTextStyles.hint.copyWith(
          color: AppColors.danger,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      // Dialog theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.bgCenter,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: AppColors.glassBorder,
            width: 1.0,
          ),
        ),
        titleTextStyle: AppTextStyles.h3,
        contentTextStyle: AppTextStyles.body,
      ),

      // Bottom sheet
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.bgCenter,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        dragHandleColor: AppColors.textHint,
        dragHandleSize: const Size(40, 4),
      ),

      // Page transitions
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: _AlgoLensPageTransition(),
          TargetPlatform.iOS: _AlgoLensPageTransition(),
        },
      ),
    );
  }
}

// ──────────────────────────────────
// PAGE TRANSITION
// Scale 0.96→1.0 + fade
// easeOutCubic 300ms
// ──────────────────────────────────

class _AlgoLensPageTransition extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
    );

    return FadeTransition(
      opacity: curved,
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 0.96,
          end: 1.0,
        ).animate(curved),
        child: child,
      ),
    );
  }
}
