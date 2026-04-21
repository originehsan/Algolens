/// Environment Configuration
///
/// RULES:
/// → Change useMock to true
///   when backend not running
/// → Change useMock to false
///   when backend is running
/// → Never hardcode baseUrl
///   in any other file
/// → Always use EnvConfig.baseUrl
library algolens.core.config.env_config;

class EnvConfig {
  EnvConfig._();

  // ──────────────────────────────
  // API CONFIGURATION
  // ──────────────────────────────

  /// Backend base URL
  /// Anchal's Spring Boot server
  /// Change to production URL later
  static const String baseUrl = 'http://localhost:8080/api';

  // ──────────────────────────────
  // MOCK CONFIGURATION
  // ──────────────────────────────

  /// Set true = use mock data
  /// Set false = use real backend
  ///
  /// When to use mock:
  /// → Backend not running
  /// → Testing UI without backend
  /// → Demo mode
  ///
  /// When to use real:
  /// → Backend is running
  /// → Integration testing
  /// → Production
  static const bool useMock = true;

  /// Fake network delay for mock
  /// Simulates real API latency
  static const Duration mockDelay = Duration(milliseconds: 800);

  /// AI analysis mock delay
  /// Groq takes 5-30 seconds
  /// Mock simulates this
  static const Duration aiMockDelay = Duration(seconds: 3);

  // ──────────────────────────────
  // TIMEOUTS
  // ──────────────────────────────

  /// Connection timeout
  static const Duration connectTimeout = Duration(seconds: 15);

  /// Receive timeout
  /// High because AI takes 30s
  static const Duration receiveTimeout = Duration(seconds: 60);

  /// Send timeout
  static const Duration sendTimeout = Duration(seconds: 15);

  // ──────────────────────────────
  // CACHE DURATIONS
  // Match backend Redis TTL
  // ──────────────────────────────

  /// Profile cache duration
  /// Matches backend Redis: 5 min
  static const Duration profileCache = Duration(minutes: 5);

  /// Contest cache duration
  /// Matches backend Redis: 1 hour
  static const Duration contestCache = Duration(hours: 1);

  /// Analysis cache duration
  /// Matches backend Redis: 1 hour
  static const Duration analysisCache = Duration(hours: 1);

  // ──────────────────────────────
  // NOTIFICATION LIMITS
  // ──────────────────────────────

  /// Max reminders per contest
  static const int maxReminders = 3;

  /// Min reminder minutes
  static const int minReminderMins = 0;

  /// Max reminder minutes
  static const int maxReminderMins = 120;

  /// Default reminder minutes
  static const int defaultReminderMins = 30;

  /// Banner reshow after days
  /// Notification permission banner
  static const int bannerReshowDays = 3;

  // ──────────────────────────────
  // WIDGET CONFIGURATION
  // ──────────────────────────────

  /// Home widget update interval
  static const Duration widgetInterval = Duration(minutes: 30);

  // ──────────────────────────────
  // DEBOUNCE
  // ──────────────────────────────

  /// CF handle verification debounce
  /// Wait before calling API
  static const Duration handleDebounce = Duration(milliseconds: 800);

  /// Search debounce
  static const Duration searchDebounce = Duration(milliseconds: 500);
}
