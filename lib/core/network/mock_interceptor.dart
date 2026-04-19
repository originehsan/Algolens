import 'package:dio/dio.dart';
import 'package:algolens/core/config/env_config.dart';
import 'package:algolens/core/network/mock_data.dart';

class MockInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!EnvConfig.useMock) {
      handler.next(options);
      return;
    }

    // Simulate network delay
    await Future.delayed(EnvConfig.mockDelay);

    final path = options.path;
    dynamic mockData;

    // Auth endpoints
    if (path.contains('/api/auth/login')) {
      mockData = MockData.loginResponse;
    } else if (path.contains('/api/auth/register')) {
      mockData = 'User registered successfully. Verification email sent.';
    } else if (path.contains('/api/auth/verify-email')) {
      mockData = 'Email verified successfully';
    } else if (path.contains('/api/auth/refresh')) {
      mockData = MockData.loginResponse;
    } else if (path.contains('/api/auth/logout')) {
      mockData = 'Logged out successfully';
    } else if (path.contains('/api/auth/forgot-password')) {
      mockData = {'message': 'Password reset OTP sent'};
    } else if (path.contains('/api/auth/verify-reset-token')) {
      mockData = {'message': 'Token verified successfully'};
    } else if (path.contains('/api/auth/reset-password')) {
      mockData = {'message': 'Password reset successfully'};

      // User endpoints
    } else if (path.contains('/profile')) {
      mockData = MockData.profileResponse;
    } else if (path.contains('/contest-history')) {
      mockData = MockData.contestHistoryResponse;
    } else if (path.contains('/rating-graph')) {
      mockData = MockData.ratingGraphResponse;
    } else if (path.contains('/submission-stats')) {
      mockData = MockData.submissionStatsResponse;

      // Contest endpoints
    } else if (path.contains('/api/contests/upcoming')) {
      mockData = MockData.upcomingContestsResponse;
    } else if (path.contains('/api/contests')) {
      mockData = MockData.allContestsResponse;

      // Insights endpoints
    } else if (path.contains('/weak-topics')) {
      mockData = MockData.weakTopicsResponse;
    } else if (path.contains('/recommendations')) {
      mockData = MockData.recommendationsResponse;
    } else if (path.contains('/insights') && path.contains('/upsolve')) {
      mockData = MockData.upsolveResponse;

      // Comparison endpoints
    } else if (path.contains('/api/compare/rating')) {
      mockData = MockData.compareRatingResponse;
    } else if (path.contains('/api/compare/find')) {
      mockData = MockData.compareRatingResponse;

      // Friends endpoints
    } else if (path.contains('/leaderboard')) {
      mockData = MockData.friendsLeaderboardResponse;
    } else if (path.contains('/api/friends/add')) {
      mockData = 'Friend added successfully';
    } else if (path.contains('/remove')) {
      mockData = 'Friend removed successfully';
    } else if (path.contains('/api/friends')) {
      mockData = MockData.friendsListResponse;

      // Analysis endpoint
    } else if (path.contains('/api/analysis/upsolve')) {
      mockData = MockData.aiAnalysisResponse;
    } else {
      handler.next(options);
      return;
    }

    handler.resolve(
      Response(
        requestOptions: options,
        data: mockData,
        statusCode: 200,
        statusMessage: 'OK',
      ),
    );
  }
}
