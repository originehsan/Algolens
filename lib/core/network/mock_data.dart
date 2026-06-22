import 'package:algolens/core/network/api_endpoints.dart';

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
  // Using Ehsan's mock profile
  // ────────────────────────────

  static const Map<String, dynamic> profileResponse = {
    'handle': 'ehsan_cf',
    'rating': 1487,
    'maxRating': 1523,
    'rank': 'specialist',
    'maxRank': 'specialist',
    'problemsSolved': 347,
    'contestsParticipated': 34,
    'streakDays': 12,
    'lastActiveDate': '2026-06-20T00:00:00.000Z',
    'avatar': '',
  };

  static const List<Map<String, dynamic>> ratingGraphResponse = [
    {
      'contestId': 1910,
      'contestName': 'Codeforces Round 915 (Div. 3)',
      'rating': 1102,
      'date': '2024-02-10T14:35:00.000Z',
    },
    {
      'contestId': 1935,
      'contestName': 'Codeforces Round 928 (Div. 3)',
      'rating': 1198,
      'date': '2024-03-20T14:35:00.000Z',
    },
    {
      'contestId': 1960,
      'contestName': 'Codeforces Round 940 (Div. 3)',
      'rating': 1285,
      'date': '2024-05-05T14:35:00.000Z',
    },
    {
      'contestId': 1981,
      'contestName': 'Codeforces Round 950 (Div. 3)',
      'rating': 1354,
      'date': '2024-06-10T14:35:00.000Z',
    },
    {
      'contestId': 1991,
      'contestName': 'Codeforces Round 957 (Div. 3)',
      'rating': 1412,
      'date': '2024-07-15T14:35:00.000Z',
    },
    {
      'contestId': 2010,
      'contestName': 'Codeforces Round 968 (Div. 3)',
      'rating': 1445,
      'date': '2024-09-01T14:35:00.000Z',
    },
    {
      'contestId': 2035,
      'contestName': 'Codeforces Round 980 (Div. 2)',
      'rating': 1487,
      'date': '2024-11-15T14:35:00.000Z',
    },
  ];

  static const Map<String, dynamic> submissionStatsResponse = {
    'totalSubmissions': 892,
    'solvedProblems': 347,
    'unSolvedProblems': 545,
    'verdictsCount': {
      'OK': 347,
      'WRONG_ANSWER': 312,
      'TIME_LIMIT_EXCEEDED': 98,
      'MEMORY_LIMIT_EXCEEDED': 34,
      'RUNTIME_ERROR': 101,
    },
  };

  static const List<Map<String, dynamic>> contestHistoryResponse = [
    {
      'contestId': 2035,
      'contestName': 'Codeforces Round 980 (Div. 2)',
      'rank': 1842,
      'oldRating': 1445,
      'newRating': 1487,
      'ratingChange': 42,
    },
    {
      'contestId': 2010,
      'contestName': 'Codeforces Round 968 (Div. 3)',
      'rank': 956,
      'oldRating': 1412,
      'newRating': 1445,
      'ratingChange': 33,
    },
    {
      'contestId': 1991,
      'contestName': 'Codeforces Round 957 (Div. 3)',
      'rank': 1243,
      'oldRating': 1354,
      'newRating': 1412,
      'ratingChange': 58,
    },
    {
      'contestId': 1981,
      'contestName': 'Codeforces Round 950 (Div. 3)',
      'rank': 2341,
      'oldRating': 1285,
      'newRating': 1354,
      'ratingChange': 69,
    },
    {
      'contestId': 1960,
      'contestName': 'Codeforces Round 940 (Div. 3)',
      'rank': 3102,
      'oldRating': 1198,
      'newRating': 1285,
      'ratingChange': 87,
    },
    {
      'contestId': 1935,
      'contestName': 'Codeforces Round 928 (Div. 3)',
      'rank': 4521,
      'oldRating': 1102,
      'newRating': 1198,
      'ratingChange': 96,
    },
  ];

  // ────────────────────────────
  // CONTESTS
  // relativeTimeSeconds < 0 = upcoming
  // Use large negative values so
  // contests always show as upcoming
  // regardless of when app runs
  // ────────────────────────────

  static List<Map<String, dynamic>> get upcomingContestsResponse {
    // Current time in seconds
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    return [
      // Contest 1: starts in 2 days
      {
        'contestId': 2100,
        'name': 'Codeforces Round 1001 (Div. 2)',
        'type': 'CF',
        'durationSeconds': 7200,
        'startTimeSeconds': now + (2 * 24 * 3600),
        'relativeTimeSeconds': -(2 * 24 * 3600),
      },
      // Contest 2: starts in 4 days
      {
        'contestId': 2101,
        'name': 'Educational Codeforces Round 180',
        'type': 'ICPC',
        'durationSeconds': 7200,
        'startTimeSeconds': now + (4 * 24 * 3600),
        'relativeTimeSeconds': -(4 * 24 * 3600),
      },
      // Contest 3: starts in 6 days
      {
        'contestId': 2102,
        'name': 'Codeforces Round 1002 (Div. 1)',
        'type': 'CF',
        'durationSeconds': 9000,
        'startTimeSeconds': now + (6 * 24 * 3600),
        'relativeTimeSeconds': -(6 * 24 * 3600),
      },
      // Contest 4: starts in 1 hour (nearly live)
      {
        'contestId': 2103,
        'name': 'Codeforces Round 1003 (Div. 3)',
        'type': 'CF',
        'durationSeconds': 7200,
        'startTimeSeconds': now + 3600,
        'relativeTimeSeconds': -3600,
      },
      // Contest 5: LIVE right now
      {
        'contestId': 2104,
        'name': 'Codeforces Round 1000 (Div. 1 + Div. 2)',
        'type': 'CF',
        'durationSeconds': 9000,
        'startTimeSeconds': now - 1800,
        'relativeTimeSeconds': 1800,
      },
    ];
  }

  static Map<String, dynamic> get allContestsResponse {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return {
      'contests': [
        {
          'contestId': 2100,
          'name': 'Codeforces Round 1001 (Div. 2)',
          'type': 'CF',
          'durationSeconds': 7200,
          'startTimeSeconds': now + (2 * 24 * 3600),
          'relativeTimeSeconds': -(2 * 24 * 3600),
        },
        {
          'contestId': 2101,
          'name': 'Educational Codeforces Round 180',
          'type': 'ICPC',
          'durationSeconds': 7200,
          'startTimeSeconds': now + (4 * 24 * 3600),
          'relativeTimeSeconds': -(4 * 24 * 3600),
        },
        {
          'contestId': 1991,
          'name': 'Codeforces Round 957 (Div. 1)',
          'type': 'CF',
          'durationSeconds': 9000,
          'startTimeSeconds': now - (7 * 24 * 3600),
          'relativeTimeSeconds': 999999,
        },
        {
          'contestId': 1981,
          'name': 'Codeforces Round 950 (Div. 1)',
          'type': 'CF',
          'durationSeconds': 9000,
          'startTimeSeconds': now - (14 * 24 * 3600),
          'relativeTimeSeconds': 999999,
        },
      ],
      'total': 4,
      'page': 1,
      'size': 20,
    };
  }

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
      'handle': 'jiangly',
      'rating': 3827,
      'maxRating': 3859,
      'tier': 'legendary grandmaster',
    },
    {
      'rank': 2,
      'handle': 'Petr',
      'rating': 3547,
      'maxRating': 3602,
      'tier': 'legendary grandmaster',
    },
    {
      'rank': 3,
      'handle': 'Um_nik',
      'rating': 3439,
      'maxRating': 3523,
      'tier': 'legendary grandmaster',
    },
    {
      'rank': 4,
      'handle': 'ehsan_cf',
      'rating': 1487,
      'maxRating': 1523,
      'tier': 'specialist',
    },
  ];

  static const List<Map<String, dynamic>> unsolvedByMeResponse = [
    {
      'contestId': 1991,
      'index': 'D',
      'name': 'Minimize the Difference',
      'rating': 1800,
      'tags': ['dp', 'greedy'],
    },
    {
      'contestId': 1981,
      'index': 'C',
      'name': 'ada and the Game',
      'rating': 1600,
      'tags': ['binary search', 'greedy'],
    },
  ];

  static const Map<String, dynamic> streakCompareResponse = {
    'streaks': [
      {
        'handle': 'ehsan_cf',
        'streakDays': 12,
      },
      {
        'handle': 'Petr',
        'streakDays': 7,
      },
      {
        'handle': 'Um_nik',
        'streakDays': 21,
      },
      {
        'handle': 'jiangly',
        'streakDays': 30,
      },
    ],
  };

  static const Map<String, dynamic> contestOverlapResponse = {
    'contestId': 1991,
    'participants': [
      {
        'handle': 'ehsan_cf',
        'rank': 1243,
        'ratingChange': 58,
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
    'handle1': 'ehsan_cf',
    'handle2': 'Petr',
    'rating1': 1487,
    'rating2': 3547,
    'maxRating1': 1523,
    'maxRating2': 3602,
    'contestsParticipated1': 34,
    'contestsParticipated2': 198,
    'problemsSolved1': 347,
    'problemsSolved2': 1456,
  };

  static const Map<String, dynamic> findSubmissionResponse = {
    'found': true,
    'handle': 'ehsan_cf',
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
      'tag': 'binary search',
      'totalAttempts': 24,
      'solvedCount': 11,
      'unsolvedCount': 13,
      'acRate': 0.46,
      'severity': 'critical',
    },
    {
      'tag': 'number theory',
      'totalAttempts': 28,
      'solvedCount': 17,
      'unsolvedCount': 11,
      'acRate': 0.61,
      'severity': 'moderate',
    },
    {
      'tag': 'greedy',
      'totalAttempts': 38,
      'solvedCount': 22,
      'unsolvedCount': 16,
      'acRate': 0.58,
      'severity': 'high',
    },
  ];

  static const List<Map<String, dynamic>> recommendationsResponse = [
    {
      'contestId': 1234,
      'index': 'C',
      'name': 'Knapsack Problem',
      'rating': 1600,
      'tags': ['dp', 'greedy'],
    },
    {
      'contestId': 1456,
      'index': 'B',
      'name': 'Tree Queries',
      'rating': 1700,
      'tags': ['trees', 'dfs and similar'],
    },
    {
      'contestId': 1678,
      'index': 'C',
      'name': 'Graph Coloring',
      'rating': 1800,
      'tags': ['graphs', 'greedy'],
    },
    {
      'contestId': 1399,
      'index': 'C',
      'name': 'Binary Search on Array',
      'rating': 1500,
      'tags': ['binary search', 'sortings'],
    },
    {
      'contestId': 1512,
      'index': 'D',
      'name': 'Factorial Divisibility',
      'rating': 1600,
      'tags': ['number theory', 'math'],
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
        'isWeakTopic': true,
      },
      {
        'contestId': 1991,
        'index': 'E',
        'name': 'Permutation of Rows',
        'rating': 2200,
        'tags': ['constructive algorithms', 'greedy'],
        'bestVerdict': 'TIME_LIMIT_EXCEEDED',
        'url': 'https://codeforces.com/contest/1991/problem/E',
        'isWeakTopic': false,
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
        'isWeakTopic': true,
      },
    ],
    '1960': [
      {
        'contestId': 1960,
        'index': 'D',
        'name': 'Graph Problem',
        'rating': 1900,
        'tags': ['graphs', 'dfs and similar'],
        'bestVerdict': 'TIME_LIMIT_EXCEEDED',
        'url': 'https://codeforces.com/contest/1960/problem/D',
        'isWeakTopic': true,
      },
    ],
  };

  // ────────────────────────────
  // ANALYSIS (AI — Groq)
  // ────────────────────────────

  static const Map<String, dynamic> analysisResponse = {
    'overallRecommendation':
        'Focus on dynamic programming and binary search fundamentals. '
            'Your weak spots are state transition design and boundary conditions. '
            'Practice Div.2 C-D level problems daily for 2 weeks to reach Expert.',
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
        'conceptToStudy': 'Constructive algorithms + sorting to avoid brute force',
        'actionableTip':
            'Think about what the final arrangement must look like before simulating.',
      },
      {
        'contestId': 1981,
        'problemIndex': 'C',
        'problemName': 'ada and the Game',
        'likelyIssue': 'Binary search boundary off by one — check lo/hi carefully',
        'conceptToStudy': 'Binary search on answer + predicate design',
        'actionableTip':
            'Write the check() function first, then wrap binary search around it.',
      },
    ],
  };

  // ────────────────────────────
  // ENDPOINT → DATA MAP
  // Used by MockInterceptor
  // ────────────────────────────

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

    // PROFILE — check specific paths before generic /profile
    if (path.contains('/rating-graph')) return ratingGraphResponse;
    if (path.contains('/submission-stats')) return submissionStatsResponse;
    if (path.contains('/contest-history')) return contestHistoryResponse;
    if (path.contains('/profile')) return profileResponse;

    // CONTESTS
    if (path.contains(ApiEndpoints.upcomingContests)) {
      return upcomingContestsResponse;
    }
    if (path == ApiEndpoints.allContests) return allContestsResponse;

    // FRIENDS — check specific paths before generic /friends/
    if (path.contains(ApiEndpoints.addFriend)) return messageResponse;
    if (path.contains('/remove/')) return messageResponse;
    if (path.contains('/unsolved-by-me')) return unsolvedByMeResponse;
    if (path.contains('/streak-compare')) return streakCompareResponse;
    if (path.contains('/contest-overlap')) return contestOverlapResponse;
    if (path.contains('/leaderboard')) return leaderboardResponse;
    if (path.contains('/friends/')) return friendsResponse;

    // COMPARE
    if (path.contains(ApiEndpoints.compareRating)) return compareRatingResponse;
    if (path.contains(ApiEndpoints.findSubmission)) return findSubmissionResponse;

    // INSIGHTS — check /upsolve before /analysis
    if (path.contains('/weak-topics')) return weakTopicsResponse;
    if (path.contains('/recommendations')) return recommendationsResponse;
    if (path.contains('/upsolve') && !path.contains('/analysis')) {
      return upsolveResponse;
    }

    // ANALYSIS
    if (path.contains('/analysis/')) return analysisResponse;

    // VERIFICATION
    if (path.contains('/verification/')) return messageResponse;

    return <String, dynamic>{'message': 'Mock not found'};
  }
}