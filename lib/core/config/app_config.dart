/// App-wide Configuration
///
/// Contains app metadata and
/// feature flags for AlgoLens
library algolens.core.config.app_config;

class AppConfig {
  AppConfig._();

  // ──────────────────────────────
  // APP METADATA
  // ──────────────────────────────

  static const String appName = 'AlgoLens';

  static const String appVersion = '1.0.0';

  static const String buildNumber = '1';

  static const String packageName = 'com.algolens.app';

  static const String tagline = 'Competitive Programming Analytics';

  // ──────────────────────────────
  // DESIGN CANVAS
  // For flutter_screenutil
  // ──────────────────────────────

  /// Design canvas width
  static const double designWidth = 390.0;

  /// Design canvas height
  static const double designHeight = 844.0;

  // ──────────────────────────────
  // PAGINATION
  // ──────────────────────────────

  /// Default page size for contests
  static const int contestPageSize = 20;

  /// Default page size for friends
  static const int friendsPageSize = 50;

  // ──────────────────────────────
  // CF HANDLE RULES
  // ──────────────────────────────

  /// Min CF handle length
  static const int minHandleLength = 3;

  /// Max CF handle length
  static const int maxHandleLength = 24;

  // ──────────────────────────────
  // PASSWORD RULES
  // Match backend validation
  // ──────────────────────────────

  /// Min password length
  /// Backend requires 8+
  static const int minPasswordLength = 8;

  // ──────────────────────────────
  // FEATURE FLAGS
  // Toggle features on/off
  // ──────────────────────────────

  /// Premium features enabled
  /// false = show locked UI
  /// true = unlock after payment
  static const bool premiumEnabled = false;

  /// Home widget enabled
  static const bool widgetEnabled = true;

  /// TTS voice reminder enabled
  static const bool ttsEnabled = true;

  /// AI analysis enabled
  static const bool aiEnabled = true;

  /// Friends feature enabled
  static const bool friendsEnabled = true;

  // ──────────────────────────────
  // ONBOARDING
  // ──────────────────────────────

  /// Number of onboarding slides
  static const int onboardingSlides = 3;

  // ──────────────────────────────
  // SWIPE STACK (Hotstar style)
  // Home screen contest cards
  // ──────────────────────────────

  /// Max cards in swipe stack
  static const int maxSwipeCards = 5;

  /// Scale per depth level
  static const double scalePerDepth = 0.045;

  /// Translate X per depth
  static const double translateXDepth = 18.0;

  /// Translate Y per depth
  static const double translateYDepth = 10.0;

  /// Opacity per depth
  static const double opacityPerDepth = 0.18;

  /// Edge resistance
  static const double edgeResistance = 0.22;

  /// Velocity threshold for swipe
  static const double velThreshold = 650.0;

  /// Distance threshold for swipe
  /// As fraction of card width
  static const double distThreshold = 0.22;

  // ──────────────────────────────
  // RATING CHART
  // fl_chart configuration
  // ──────────────────────────────

  /// Max points on rating chart
  static const int maxChartPoints = 50;

  // ──────────────────────────────
  // UPSOLVE
  // ──────────────────────────────

  /// Days to look back for upsolve
  static const int upsolveLookbackDays = 14;
}
