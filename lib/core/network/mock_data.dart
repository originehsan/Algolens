import 'package:algolens/core/network/api_endpoints.dart';

// ──────────────────────────────
// MOCK DATA
// Fake responses for all endpoints
// ──────────────────────────────

/// Static mock responses
///
/// Rules:
/// → Exact shape as real API
/// → Realistic fake data
/// → Used by MockInterceptor
/// → Never used in production
abstract class MockData {
  MockData._();

  // ────────────────────────────
  // AUTH
  // ────────────────────────────

  static const Map<String, dynamic> loginResponse = {
    'accessToken': 'mock_access_token_xyz',
    'refreshToken': 'mock_refresh_token_xyz',
  };

  static const Map<String, dynamic> messageResponse = {
    'message': 'Success',
  };

  static const Map<String, dynamic> refreshResponse = {
    'accessToken': 'mock_access_token_refreshed',
    'refreshToken': 'mock_refresh_token_refreshed',
  };

  // ────────────────────────────
  // PROFILE
  // ────────────────────────────

  static const Map<String, dynamic> profileResponse = {
    'handle': 'tourist',
    'rating': 3979,
    'maxRating': 4006,
    'rank': 'legendary grandmaster',
    'maxRank': 'legendary grandmaster',
    'problemsSolved': 1842,
    'contestsParticipated': 312,
    'streakDays': 14,
    'lastActiveDate': '2024-12-01T00:00:00.000Z',
    'avatar': 'https://userpic.codeforces.org/422/title/tourist.jpg',
  };

  static const List<Map<String, dynamic>> ratingGraphResponse = [
    {
      'contestId': 1991,
      'contestName': 'Codeforces Round 957 (Div. 1)',
      'rating': 3979,
      'date': '2024-07-15T14:35:00.000Z',
    },
    {
      'contestId': 1981,
      'contestName': 'Codeforces Round 950 (Div. 1)',
      'rating': 3962,
      'date': '2024-06-10T14:35:00.000Z',
    },
    {
      'contestId': 1960,
      'contestName': 'Codeforces Round 940 (Div. 1)',
      'rating': 3944,
      'date': '2024-05-05T14:35:00.000Z',
    },
    {
      'contestId': 1935,
      'contestName': 'Codeforces Round 928 (Div. 1)',
      'rating': 3921,
      'date': '2024-03-20T14:35:00.000Z',
    },
    {
      'contestId': 1910,
      'contestName': 'Codeforces Round 915 (Div. 1)',
      'rating': 3898,
      'date': '2024-02-10T14:35:00.000Z',
    },
  ];

  static const Map<String, dynamic> submissionStatsResponse = {
    'totalSubmissions': 4821,
    'solvedProblems': 1842,
    'unSolvedProblems': 312,
    'verdictsCount': {
      'OK': 1842,
      'WRONG_ANSWER': 198,
      'TIME_LIMIT_EXCEEDED': 67,
      'MEMORY_LIMIT_EXCEEDED': 23,
      'RUNTIME_ERROR': 24,
    },
  };

  static const List<Map<String, dynamic>> contestHistoryResponse = [
    {
      'contestId': 1991,
      'contestName': 'Codeforces Round 957 (Div. 1)',
      'rank': 1,
      'oldRating': 3962,
      'newRating': 3979,
      'ratingChange': 17,
    },
    {
      'contestId': 1981,
      'contestName': 'Codeforces Round 950 (Div. 1)',
      'rank': 2,
      'oldRating': 3944,
      'newRating': 3962,
      'ratingChange': 18,
    },
    {
      'contestId': 1960,
      'contestName': 'Codeforces Round 940 (Div. 1)',
      'rank': 1,
      'oldRating': 3921,
      'newRating': 3944,
      'ratingChange': 23,
    },
  ];

  // ────────────────────────────
  // CONTESTS
  // ────────────────────────────

  static const List<Map<String, dynamic>> upcomingContestsResponse = [
    {
      'contestId': 2050,
      'name': 'Codeforces Round 992 (Div. 2)',
      'type': 'CF',
      'durationSeconds': 7200,
      'startTimeSeconds': 1735200000,
      'relativeTimeSeconds': -86400,
    },
    {
      'contestId': 2051,
      'name': 'Educational Codeforces Round 175',
      'type': 'ICPC',
      'durationSeconds': 7200,
      'startTimeSeconds': 1735286400,
      'relativeTimeSeconds': -172800,
    },
    {
      'contestId': 2052,
      'name': 'Codeforces Round 993 (Div. 1)',
      'type': 'CF',
      'durationSeconds': 9000,
      'startTimeSeconds': 1735372800,
      'relativeTimeSeconds': -259200,
    },
  ];

  static const Map<String, dynamic> allContestsResponse = {
    'contests': [
      {
        'contestId': 1991,
        'name': 'Codeforces Round 957 (Div. 1)',
        'type': 'CF',
        'durationSeconds': 9000,
        'startTimeSeconds': 1721051700,
        'relativeTimeSeconds': 999999,
      },
      {
        'contestId': 1981,
        'name': 'Codeforces Round 950 (Div. 1)',
        'type': 'CF',
        'durationSeconds': 9000,
        'startTimeSeconds': 1717942500,
        'relativeTimeSeconds': 999999,
      },
    ],
    'total': 2,
    'page': 1,
    'size': 20,
  };

  // ────────────────────────────
  // FRIENDS
  // ────────────────────────────

  static const List<Map<String, dynamic>> friendsResponse = [
    {
      'handle': 'Petr',
      'rating': 3547,
      'maxRating': 3602,
      'rank': 'legendary grandmaster',
      'avatar': 'https://userpic.codeforces.org/44651/title/Petr.jpg',
      'contestsParticipated': 198,
    },
    {
      'handle': 'Um_nik',
      'rating': 3439,
      'maxRating': 3523,
      'rank': 'legendary grandmaster',
      'avatar': 'https://userpic.codeforces.org/631572/title/Um_nik.jpg',
      'contestsParticipated': 156,
    },
    {
      'handle': 'jiangly',
      'rating': 3827,
      'maxRating': 3859,
      'rank': 'legendary grandmaster',
      'avatar': 'https://userpic.codeforces.org/1133887/title/jiangly.jpg',
      'contestsParticipated': 234,
    },
  ];

  static const List<Map<String, dynamic>> leaderboardResponse = [
    {
      'rank': 1,
      'handle': 'tourist',
      'rating': 3979,
      'maxRating': 4006,
      'tier': 'legendary grandmaster',
    },
    {
      'rank': 2,
      'handle': 'jiangly',
      'rating': 3827,
      'maxRating': 3859,
      'tier': 'legendary grandmaster',
    },
    {
      'rank': 3,
      'handle': 'Petr',
      'rating': 3547,
      'maxRating': 3602,
      'tier': 'legendary grandmaster',
    },
    {
      'rank': 4,
      'handle': 'Um_nik',
      'rating': 3439,
      'maxRating': 3523,
      'tier': 'legendary grandmaster',
    },
  ];

  static const List<Map<String, dynamic>> unsolvedByMeResponse = [
    {
      'contestId': 1991,
      'index': 'F',
      'name': 'Cyclic Cover',
      'rating': 3200,
      'tags': ['graphs', 'dfs and similar', 'trees'],
    },
    {
      'contestId': 1981,
      'index': 'G',
      'name': 'Strange Beauty',
      'rating': 2900,
      'tags': ['dp', 'number theory'],
    },
  ];

  static const Map<String, dynamic> streakCompareResponse = {
    'streaks': [
      {
        'handle': 'tourist',
        'streakDays': 14,
      },
      {
        'handle': 'Petr',
        'streakDays': 7,
      },
      {
        'handle': 'Um_nik',
        'streakDays': 21,
      },
    ],
  };

  static const Map<String, dynamic> contestOverlapResponse = {
    'contestId': 1991,
    'participants': [
      {
        'handle': 'tourist',
        'rank': 1,
        'ratingChange': 17,
      },
      {
        'handle': 'Petr',
        'rank': 4,
        'ratingChange': 12,
      },
    ],
  };

  // ────────────────────────────
  // COMPARE
  // ────────────────────────────

  static const Map<String, dynamic> compareRatingResponse = {
    'handle1': 'tourist',
    'handle2': 'Petr',
    'rating1': 3979,
    'rating2': 3547,
    'maxRating1': 4006,
    'maxRating2': 3602,
    'contestsParticipated1': 312,
    'contestsParticipated2': 198,
    'problemsSolved1': 1842,
    'problemsSolved2': 1456,
  };

  static const Map<String, dynamic> findSubmissionResponse = {
    'found': true,
    'handle': 'tourist',
    'contestId': 1991,
    'problemIndex': 'A',
    'verdict': 'OK',
    'submittedAt': '2024-07-15T15:10:00.000Z',
  };

  // ────────────────────────────
  // INSIGHTS
  // ────────────────────────────

  static const List<Map<String, dynamic>> weakTopicsResponse = [
    {
      'tag': 'dp',
      'totalAttempts': 42,
      'solvedCount': 18,
      'unsolvedCount': 24,
      'acRate': 0.43,
      'severity': 'critical',
    },
    {
      'tag': 'graphs',
      'totalAttempts': 31,
      'solvedCount': 16,
      'unsolvedCount': 15,
      'acRate': 0.52,
      'severity': 'high',
    },
    {
      'tag': 'number theory',
      'totalAttempts': 28,
      'solvedCount': 17,
      'unsolvedCount': 11,
      'acRate': 0.61,
      'severity': 'moderate',
    },
  ];

  static const List<Map<String, dynamic>> recommendationsResponse = [
    {
      'contestId': 1234,
      'index': 'C',
      'name': 'Knapsack',
      'rating': 1800,
      'tags': ['dp', 'greedy'],
    },
    {
      'contestId': 1456,
      'index': 'D',
      'name': 'Tree Queries',
      'rating': 2000,
      'tags': ['trees', 'dfs and similar'],
    },
    {
      'contestId': 1678,
      'index': 'C',
      'name': 'Graph Coloring',
      'rating': 1900,
      'tags': ['graphs', 'greedy'],
    },
  ];

  static const Map<String, dynamic> upsolveResponse = {
    '1991': [
      {
        'contestId': 1991,
        'index': 'D',
        'name': 'Minimize the Difference',
        'rating': 1800,
        'tags': ['dp', 'greedy'],
        'bestVerdict': 'WRONG_ANSWER',
        'url': 'https://codeforces.com/contest/1991/problem/D',
      },
      {
        'contestId': 1991,
        'index': 'E',
        'name': 'Permutation of Rows',
        'rating': 2200,
        'tags': ['constructive algorithms', 'greedy'],
        'bestVerdict': 'TIME_LIMIT_EXCEEDED',
        'url': 'https://codeforces.com/contest/1991/problem/E',
      },
    ],
    '1981': [
      {
        'contestId': 1981,
        'index': 'C',
        'name': 'ada and the Game',
        'rating': 1600,
        'tags': ['binary search', 'greedy'],
        'bestVerdict': 'WRONG_ANSWER',
        'url': 'https://codeforces.com/contest/1981/problem/C',
      },
    ],
  };

  // ────────────────────────────
  // ANALYSIS (AI — Groq)
  // ────────────────────────────

  static const Map<String, dynamic> analysisResponse = {
    'overallRecommendation':
        'Focus on dynamic programming fundamentals. Your weak spots are state transition design and memoization. Practice Div.2 D-level DP problems daily for 2 weeks.',
    'problemAnalyses': [
      {
        'contestId': 1991,
        'problemIndex': 'D',
        'problemName': 'Minimize the Difference',
        'likelyIssue':
            'Incorrect greedy ordering — not sorting before applying prefix minimums',
        'conceptToStudy': 'Prefix minimum arrays + greedy invariants',
        'actionableTip':
            'Sort input first, then apply prefix min. Try CF 1399C as a warm-up.',
      },
      {
        'contestId': 1991,
        'problemIndex': 'E',
        'problemName': 'Permutation of Rows',
        'likelyIssue': 'TLE due to O(n²) simulation instead of O(n log n) sort',
        'conceptToStudy': 'Constructive + sorting to avoid brute force',
        'actionableTip':
            'Think about what the final arrangement must look like before simulating.',
      },
    ],
  };

  // ────────────────────────────
  // ENDPOINT → DATA MAP
  // Used by MockInterceptor
  // ────────────────────────────

  /// Returns mock data for a
  /// given request path
  ///
  /// Matches by path prefix
  /// to handle dynamic routes
  static dynamic getResponse(
    String path,
    String method,
  ) {
    // AUTH
    if (path.contains(ApiEndpoints.login)) return loginResponse;

    if (path.contains(ApiEndpoints.register)) return messageResponse;

    if (path.contains(ApiEndpoints.refresh)) return refreshResponse;

    if (path.contains(ApiEndpoints.logout)) return messageResponse;

    if (path.contains(ApiEndpoints.forgotPassword)) return messageResponse;

    if (path.contains(ApiEndpoints.verifyResetToken)) return messageResponse;

    if (path.contains(ApiEndpoints.resetPassword)) return messageResponse;

    if (path.contains(ApiEndpoints.resendVerification)) return messageResponse;

    // PROFILE
    if (path.contains('/rating-graph')) {
      return ratingGraphResponse;
    }

    if (path.contains('/submission-stats')) return submissionStatsResponse;

    if (path.contains('/contest-history')) return contestHistoryResponse;

    if (path.contains('/profile')) {
      return profileResponse;
    }

    // CONTESTS
    if (path.contains(ApiEndpoints.upcomingContests)) {
      return upcomingContestsResponse;
    }

    if (path == ApiEndpoints.allContests) {
      return allContestsResponse;
    }

    // FRIENDS
    if (path.contains(ApiEndpoints.addFriend)) return messageResponse;

    if (path.contains('/remove/')) {
      return messageResponse;
    }

    if (path.contains('/unsolved-by-me')) return unsolvedByMeResponse;

    if (path.contains('/streak-compare')) return streakCompareResponse;

    if (path.contains('/contest-overlap')) return contestOverlapResponse;

    if (path.contains('/leaderboard')) {
      return leaderboardResponse;
    }

    if (path.contains('/friends/')) {
      return friendsResponse;
    }

    // COMPARE
    if (path.contains(ApiEndpoints.compareRating)) {
      return compareRatingResponse;
    }

    if (path.contains(ApiEndpoints.findSubmission)) {
      return findSubmissionResponse;
    }

    // INSIGHTS
    if (path.contains('/weak-topics')) {
      return weakTopicsResponse;
    }

    if (path.contains('/recommendations')) {
      return recommendationsResponse;
    }

    if (path.contains('/upsolve') && !path.contains('/analysis')) {
      return upsolveResponse;
    }

    // ANALYSIS
    if (path.contains('/analysis/')) {
      return analysisResponse;
    }

    // VERIFICATION
    if (path.contains('/verification/')) {
      return messageResponse;
    }

    /// Unknown endpoint
    return <String, dynamic>{
      'message': 'Mock not found',
    };
  }
}
