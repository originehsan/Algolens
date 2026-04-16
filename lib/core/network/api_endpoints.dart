class ApiEndpoints {
  ApiEndpoints._();

  // Auth endpoints
  static const String register = '/api/auth/register';
  static const String login = '/api/auth/login';
  static const String refresh = '/api/auth/refresh';
  static const String logout = '/api/auth/logout';
  static const String logoutAll = '/api/auth/logout-all';
  static const String verifyEmail = '/api/auth/verify-email';
  static const String resendVerification = '/api/auth/resend-verification';
  static const String forgotPassword = '/api/auth/forgot-password';
  static const String verifyResetToken = '/api/auth/verify-reset-token';
  static const String resetPassword = '/api/auth/reset-password';

  // User endpoints
  static String userProfile(String handle) => '/api/users/$handle/profile';
  static String contestHistory(String handle) =>
      '/api/users/$handle/contest-history';
  static String ratingGraph(String handle) => '/api/users/$handle/rating-graph';
  static String submissionStats(String handle) =>
      '/api/users/$handle/submission-stats';

  // Contest endpoints
  static const String upcomingContests = '/api/contests/upcoming';
  static const String allContests = '/api/contests';

  // Comparison endpoints
  static const String compareRating = '/api/compare/rating';
  static const String compareFind = '/api/compare/find';

  // Friends endpoints
  static const String addFriend = '/api/friends/add';
  static String removeFriend(String userHandle, String friendHandle) =>
      '/api/friends/$userHandle/remove/$friendHandle';
  static String getFriends(String handle) => '/api/friends/$handle';
  static String friendsLeaderboard(String handle) =>
      '/api/friends/$handle/leaderboard';
  static String unsolvedByMe(String handle) =>
      '/api/friends/$handle/unsolved-by-me';
  static String streakCompare(String handle) =>
      '/api/friends/$handle/streak-compare';
  static String contestOverlap(String handle, int contestId) =>
      '/api/friends/$handle/contest-overlap/$contestId';

  // Insights endpoints
  static String weakTopics(String handle) =>
      '/api/insights/$handle/weak-topics';
  static String recommendations(String handle) =>
      '/api/insights/$handle/recommendations';
  static String upsolve(String handle) => '/api/insights/$handle/upsolve';

  // Analysis endpoint
  static String aiAnalysis(String handle) => '/api/analysis/upsolve/$handle';
}
