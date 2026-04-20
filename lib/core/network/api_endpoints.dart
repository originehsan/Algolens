// ──────────────────────────────
// API ENDPOINTS
// All paths as constants
// ──────────────────────────────

/// Central registry of all
/// AlgoLens API endpoints
///
/// Rules:
/// → Never hardcode paths elsewhere
/// → Always use this class
/// → Static only — no instantiation
/// → Dynamic paths via methods
abstract class ApiEndpoints {
  ApiEndpoints._();

  // ────────────────────────────
  // AUTH
  // POST endpoints
  // ────────────────────────────

  /// POST /auth/register
  /// Body: RegisterRequest
  static const String register = '/auth/register';

  /// POST /auth/resend-verification
  /// Body: { email }
  static const String resendVerification = '/auth/resend-verification';

  /// POST /auth/login
  /// Body: LoginRequest
  static const String login = '/auth/login';

  /// POST /auth/refresh
  /// Body: RefreshTokenRequest
  static const String refresh = '/auth/refresh';

  /// POST /auth/logout
  /// Body: LogoutRequest
  static const String logout = '/auth/logout';

  /// POST /auth/logout-all
  /// Body: LogoutRequest
  static const String logoutAll = '/auth/logout-all';

  /// POST /auth/forgot-password
  /// Body: ForgotPasswordRequest
  static const String forgotPassword = '/auth/forgot-password';

  /// POST /auth/verify-reset-token
  /// Body: VerifyResetTokenRequest
  static const String verifyResetToken = '/auth/verify-reset-token';

  /// POST /auth/reset-password
  /// Body: ResetPasswordRequest
  static const String resetPassword = '/auth/reset-password';

  // ────────────────────────────
  // PROFILE
  // GET endpoints
  // Requires CF handle in path
  // ────────────────────────────

  /// GET /users/{handle}/profile
  /// Returns ProfileModel
  static String profile(
    String handle,
  ) =>
      '/users/$handle/profile';

  /// GET /users/{handle}/rating-graph
  /// Returns List<RatingGraphModel>
  static String ratingGraph(
    String handle,
  ) =>
      '/users/$handle/rating-graph';

  /// GET /users/{handle}/
  ///     submission-stats
  /// Returns SubmissionStatsModel
  static String submissionStats(
    String handle,
  ) =>
      '/users/$handle/submission-stats';

  /// GET /users/{handle}/
  ///     contest-history
  /// Returns List<ContestHistoryModel>
  static String contestHistory(
    String handle,
  ) =>
      '/users/$handle/contest-history';

  // ────────────────────────────
  // CONTESTS
  // GET endpoints
  // ────────────────────────────

  /// GET /contests/upcoming
  /// Returns List<ContestModel>
  /// Cached 1 hour in Isar
  static const String upcomingContests = '/contests/upcoming';

  /// GET /contests?page=&size=
  /// Returns paginated contests
  static const String allContests = '/contests';

  // ────────────────────────────
  // FRIENDS
  // GET + POST + DELETE
  // ────────────────────────────

  /// POST /friends/add
  /// Body: { userHandle, friendHandle }
  static const String addFriend = '/friends/add';

  /// DELETE /friends/{u}/remove/{f}
  static String removeFriend(
    String userHandle,
    String friendHandle,
  ) =>
      '/friends/$userHandle'
      '/remove/$friendHandle';

  /// GET /friends/{handle}
  /// Returns List<FriendModel>
  static String getFriends(
    String handle,
  ) =>
      '/friends/$handle';

  /// GET /friends/{handle}/leaderboard
  /// Returns List<LeaderboardModel>
  static String leaderboard(
    String handle,
  ) =>
      '/friends/$handle/leaderboard';

  /// GET /friends/{handle}/
  ///     unsolved-by-me
  /// Returns List<ProblemModel>
  static String unsolvedByMe(
    String handle,
  ) =>
      '/friends/$handle/unsolved-by-me';

  /// GET /friends/{handle}/
  ///     streak-compare
  /// Returns streak comparison data
  static String streakCompare(
    String handle,
  ) =>
      '/friends/$handle/streak-compare';

  /// GET /friends/{handle}/
  ///     contest-overlap/{contestId}
  /// Returns contest overlap data
  static String contestOverlap(
    String handle,
    int contestId,
  ) =>
      '/friends/$handle'
      '/contest-overlap/$contestId';

  // ────────────────────────────
  // COMPARE
  // GET + POST
  // ────────────────────────────

  /// GET /compare/rating
  /// Query: handle1, handle2
  /// Returns rating comparison
  static const String compareRating = '/compare/rating';

  /// POST /compare/find
  /// Body: comparison params
  /// Returns submission comparison
  static const String findSubmission = '/compare/find';

  // ────────────────────────────
  // INSIGHTS
  // GET endpoints
  // ────────────────────────────

  /// GET /insights/{handle}/
  ///     weak-topics
  /// Returns List<WeakTopicModel>
  static String weakTopics(
    String handle,
  ) =>
      '/insights/$handle/weak-topics';

  /// GET /insights/{handle}/
  ///     recommendations
  /// Returns List<ProblemModel>
  static String recommendations(
    String handle,
  ) =>
      '/insights/$handle'
      '/recommendations';

  /// GET /insights/{handle}/upsolve
  /// Returns upsolve problems map
  static String upsolve(
    String handle,
  ) =>
      '/insights/$handle/upsolve';

  // ────────────────────────────
  // ANALYSIS
  // GET endpoint (Groq AI)
  // Takes 5–30 seconds
  // ────────────────────────────

  /// GET /analysis/upsolve/{handle}
  /// Returns AnalysisResponse
  /// Long running — show spinner
  static String aiAnalysis(
    String handle,
  ) =>
      '/analysis/upsolve/$handle';

  // ────────────────────────────
  // VERIFICATION (PREMIUM 🔒)
  // POST endpoints
  // ────────────────────────────

  /// POST /verification/send-otp
  /// Body: { phoneNumber }
  /// PREMIUM 🔒
  static const String sendOtp = '/verification/send-otp';

  /// POST /verification/verify-otp
  /// Body: { phoneNumber, otp }
  /// PREMIUM 🔒
  static const String verifyOtp = '/verification/verify-otp';
}
