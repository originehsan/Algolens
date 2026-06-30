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

  // ────────────────────────────
  // SUBMISSION STATS
  // FIXED: verdict keys now match
  // API doc contract (ACCEPTED,
  // not OK). If real backend turns
  // out to send OK instead, flag
  // to Anchal and flip this back.
  // ────────────────────────────

  static const Map<String, dynamic> submissionStatsResponse = {
    'totalSubmissions': 892,
    'solvedProblems': 347,
    'unSolvedProblems': 545,
    'verdictsCount': {
      'ACCEPTED': 347,
      'WRONG_ANSWER': 312,
      'TIME_LIMIT_EXCEEDED': 98,
      'MEMORY_LIMIT_EXCEEDED': 34,
      'COMPILATION_ERROR': 12,
      'RUNTIME_ERROR': 89,
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
      'content': [
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
      // FIXED: page shape now matches API doc contract exactly
      // (size, number, totalElements, totalPages) instead of
      // the old flat (total, page, size)
      'page': {
        'size': 20,
        'number': 0,
        'totalElements': 4,
        'totalPages': 1,
      },
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

  // FIXED: tier field kept (matches contract), maxRating kept
  // (matches contract) — this was already correct, untouched
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

  // FIXED: added solvedByFriends (was missing — required by
  // API contract for the "Solved by:" badges feature)
  static const List<Map<String, dynamic>> unsolvedByMeResponse = [
    {
      'contestId': 1991,
      'index': 'D',
      'name': 'Minimize the Difference',
      'rating': 1800,
      'tags': ['dp', 'greedy'],
      'solvedByFriends': ['Petr', 'jiangly'],
    },
    {
      'contestId': 1981,
      'index': 'C',
      'name': 'ada and the Game',
      'rating': 1600,
      'tags': ['binary search', 'greedy'],
      'solvedByFriends': ['Um_nik'],
    },
  ];

  // FIXED: now a flat array matching API contract exactly,
  // with field names currentStreak + lastSubmissionDate
  // (was nested under 'streaks' with wrong field name streakDays)
  static List<Map<String, dynamic>> get streakCompareResponse {
    final today = DateTime.now();
    String daysAgo(int d) =>
        today.subtract(Duration(days: d)).toIso8601String().split('T').first;

    return [
      {
        'handle': 'ehsan_cf',
        'currentStreak': 12,
        'lastSubmissionDate': daysAgo(0),
      },
      {
        'handle': 'jiangly',
        'currentStreak': 30,
        'lastSubmissionDate': daysAgo(0),
      },
      {
        'handle': 'Um_nik',
        'currentStreak': 21,
        'lastSubmissionDate': daysAgo(1),
      },
      {
        'handle': 'Petr',
        'currentStreak': 7,
        'lastSubmissionDate': daysAgo(2),
      },
    ];
  }

  // FIXED: now a flat array matching contract (rank, oldRating,
  // newRating, ratingChange per handle) — was nested under
  // 'participants' and missing oldRating/newRating
  static const List<Map<String, dynamic>> contestOverlapResponse = [
    {
      'handle': 'ehsan_cf',
      'rank': 1243,
      'oldRating': 1354,
      'newRating': 1412,
      'ratingChange': 58,
    },
    {
      'handle': 'Petr',
      'rank': 4,
      'oldRating': 3535,
      'newRating': 3547,
      'ratingChange': 12,
    },
  ];

  // ────────────────────────────
  // COMPARE
  // FIXED: field names now match
  // contract exactly — rank1/rank2,
  // ratingDelta, higherRatedHandle
  // were missing entirely
  // ────────────────────────────

  static const Map<String, dynamic> compareRatingResponse = {
    'handle1': 'ehsan_cf',
    'handle2': 'Petr',
    'rating1': 1487,
    'rating2': 3547,
    'ratingDelta': 2060,
    'higherRatedHandle': 'Petr',
    'maxRating1': 1523,
    'maxRating2': 3602,
    'rank1': 'specialist',
    'rank2': 'legendary grandmaster',
    'contestsParticipated1': 34,
    'contestsParticipated2': 198,
  };

  // FIXED: response shape now matches POST /compare/find
  // contract exactly (user1Result/user2Result objects with
  // solved, verdict, programmingLanguage, timeConsumedMillis,
  // memoryConsumedBytes, submittedAt, submissionId) — old shape
  // was a flat single-user object with wrong field names
  static const Map<String, dynamic> findSubmissionResponse = {
    'contestId': 1991,
    'index': 'A',
    'user1Result': {
      'handle': 'ehsan_cf',
      'solved': true,
      'verdict': 'ACCEPTED',
      'programmingLanguage': 'C++17',
      'timeConsumedMillis': 312,
      'memoryConsumedBytes': 2097152,
      'submittedAt': 1721055000,
      'submissionId': 287654321,
    },
    'user2Result': {
      'handle': 'Petr',
      'solved': true,
      'verdict': 'ACCEPTED',
      'programmingLanguage': 'C++20',
      'timeConsumedMillis': 78,
      'memoryConsumedBytes': 1048576,
      'submittedAt': 1721054200,
      'submissionId': 287654100,
    },
  };

  // ────────────────────────────
  // INSIGHTS
  // FIXED: acRate now 0–100 scale
  // (was 0.0–1.0), removed
  // 'severity' field (not in
  // contract — UI must derive
  // urgency from acRate itself,
  // e.g. < 40 = weak)
  // ────────────────────────────

  static const List<Map<String, dynamic>> weakTopicsResponse = [
    {
      'tag': 'dp',
      'totalAttempts': 42,
      'solvedCount': 18,
      'unsolvedCount': 24,
      'acRate': 42.9,
    },
    {
      'tag': 'binary search',
      'totalAttempts': 24,
      'solvedCount': 11,
      'unsolvedCount': 13,
      'acRate': 45.8,
    },
    {
      'tag': 'graphs',
      'totalAttempts': 31,
      'solvedCount': 16,
      'unsolvedCount': 15,
      'acRate': 51.6,
    },
    {
      'tag': 'greedy',
      'totalAttempts': 38,
      'solvedCount': 22,
      'unsolvedCount': 16,
      'acRate': 57.9,
    },
    {
      'tag': 'number theory',
      'totalAttempts': 28,
      'solvedCount': 17,
      'unsolvedCount': 11,
      'acRate': 60.7,
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

  // FIXED: removed 'isWeakTopic' (not in contract — derive in
  // UI by cross-referencing tags against weakTopicsResponse
  // instead of trusting a backend-provided flag that doesn't
  // exist)
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
    '1960': [
      {
        'contestId': 1960,
        'index': 'D',
        'name': 'Graph Problem',
        'rating': 1900,
        'tags': ['graphs', 'dfs and similar'],
        'bestVerdict': 'TIME_LIMIT_EXCEEDED',
        'url': 'https://codeforces.com/contest/1960/problem/D',
      },
    ],
  };

  // ────────────────────────────
  // ANALYSIS (AI — Groq)
  // Already matched contract —
  // untouched
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