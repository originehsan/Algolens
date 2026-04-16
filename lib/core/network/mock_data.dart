class MockData {
  MockData._();

  static Map<String, dynamic> get loginResponse => {
        'accessToken': 'mock_access_token_12345',
        'refreshToken': 'mock_refresh_token_67890',
      };

  static Map<String, dynamic> get profileResponse => {
        'handle': 'ehsan_cf',
        'rating': 1487,
        'maxRating': 1523,
        'rank': 'specialist',
        'problemsSolved': 347,
        'contestsParticipated': 34,
        'streakDays': 12,
        'lastActiveDate': '2026-04-14',
        'avatar': '',
      };

  static List<Map<String, dynamic>> get contestHistoryResponse => [
        {
          'contestId': 1987,
          'contestName': 'Codeforces Round 987 Div 2',
          'rank': 1247,
          'oldRating': 1423,
          'newRating': 1487,
          'ratingChange': 64,
        },
        {
          'contestId': 1985,
          'contestName': 'Codeforces Round 985 Div 2',
          'rank': 1456,
          'oldRating': 1459,
          'newRating': 1423,
          'ratingChange': -36,
        },
        {
          'contestId': 1982,
          'contestName': 'CF Educational Round 161',
          'rank': 987,
          'oldRating': 1417,
          'newRating': 1459,
          'ratingChange': 42,
        },
        {
          'contestId': 1980,
          'contestName': 'Codeforces Round 980 Div 2',
          'rank': 1823,
          'oldRating': 1400,
          'newRating': 1417,
          'ratingChange': 17,
        },
        {
          'contestId': 1975,
          'contestName': 'Codeforces Round 975 Div 2',
          'rank': 2341,
          'oldRating': 1350,
          'newRating': 1400,
          'ratingChange': 50,
        },
      ];

  static List<Map<String, dynamic>> get ratingGraphResponse => [
        {
          'contestId': 1950,
          'contestName': 'CF Round 950 Div 2',
          'rating': 1200,
          'date': '2025-01-15',
        },
        {
          'contestId': 1955,
          'contestName': 'CF Round 955 Div 2',
          'rating': 1280,
          'date': '2025-02-01',
        },
        {
          'contestId': 1960,
          'contestName': 'CF Round 960 Div 2',
          'rating': 1350,
          'date': '2025-02-20',
        },
        {
          'contestId': 1965,
          'contestName': 'CF Round 965 Div 2',
          'rating': 1320,
          'date': '2025-03-05',
        },
        {
          'contestId': 1970,
          'contestName': 'CF Round 970 Div 2',
          'rating': 1400,
          'date': '2025-03-20',
        },
        {
          'contestId': 1975,
          'contestName': 'CF Round 975 Div 2',
          'rating': 1350,
          'date': '2025-04-01',
        },
        {
          'contestId': 1980,
          'contestName': 'CF Round 980 Div 2',
          'rating': 1417,
          'date': '2025-04-15',
        },
        {
          'contestId': 1985,
          'contestName': 'CF Round 985 Div 2',
          'rating': 1423,
          'date': '2025-05-01',
        },
        {
          'contestId': 1987,
          'contestName': 'CF Round 987 Div 2',
          'rating': 1487,
          'date': '2025-05-15',
        },
      ];

  static Map<String, dynamic> get submissionStatsResponse => {
        'totalSubmissions': 892,
        'solvedProblems': 347,
        'unSolvedProblems': 523,
        'verdictsCount': {
          'ACCEPTED': 347,
          'WRONG_ANSWER': 298,
          'TIME_LIMIT_EXCEEDED': 145,
          'MEMORY_LIMIT_EXCEEDED': 52,
          'COMPILATION_ERROR': 31,
          'RUNTIME_ERROR': 19,
        },
      };

  static List<Map<String, dynamic>> get upcomingContestsResponse => [
        {
          'contestId': 1990,
          'name': 'Codeforces Round 990 Div 2',
          'type': 'CF',
          'durationSeconds': 7200,
          'startTimeSeconds': 1744999200,
          'relativeTimeSeconds': -86400,
        },
        {
          'contestId': 1991,
          'name': 'Educational Codeforces Round 162',
          'type': 'ICPC',
          'durationSeconds': 7200,
          'startTimeSeconds': 1745085600,
          'relativeTimeSeconds': -172800,
        },
        {
          'contestId': 1992,
          'name': 'Codeforces Round 992 Div 1',
          'type': 'CF',
          'durationSeconds': 7200,
          'startTimeSeconds': 1745172000,
          'relativeTimeSeconds': -259200,
        },
        {
          'contestId': 1993,
          'name': 'Codeforces Round 993 Div 2',
          'type': 'CF',
          'durationSeconds': 7200,
          'startTimeSeconds': 1745258400,
          'relativeTimeSeconds': -345600,
        },
        {
          'contestId': 1994,
          'name': 'Codeforces Round 994 Div 1 + Div 2',
          'type': 'CF',
          'durationSeconds': 9000,
          'startTimeSeconds': 1745344800,
          'relativeTimeSeconds': -432000,
        },
      ];

  static Map<String, dynamic> get allContestsResponse => {
        'content': [
          {
            'contestId': 1987,
            'name': 'Codeforces Round 987 Div 2',
            'type': 'CF',
            'durationSeconds': 7200,
            'startTimeSeconds': 1712869200,
            'relativeTimeSeconds': 1296000,
          },
          {
            'contestId': 1985,
            'name': 'Codeforces Round 985 Div 2',
            'type': 'CF',
            'durationSeconds': 7200,
            'startTimeSeconds': 1712264400,
            'relativeTimeSeconds': 1900800,
          },
          {
            'contestId': 1982,
            'name': 'CF Educational Round 161',
            'type': 'ICPC',
            'durationSeconds': 7200,
            'startTimeSeconds': 1711659600,
            'relativeTimeSeconds': 2505600,
          },
        ],
        'page': {
          'size': 20,
          'number': 0,
          'totalElements': 1987,
          'totalPages': 100,
        },
      };

  static List<Map<String, dynamic>> get weakTopicsResponse => [
        {
          'tag': 'divide and conquer',
          'totalAttempts': 23,
          'solvedCount': 4,
          'unsolvedCount': 19,
          'acRate': 17.4,
        },
        {
          'tag': 'suffix array',
          'totalAttempts': 15,
          'solvedCount': 3,
          'unsolvedCount': 12,
          'acRate': 20.0,
        },
        {
          'tag': 'square root decomposition',
          'totalAttempts': 28,
          'solvedCount': 8,
          'unsolvedCount': 20,
          'acRate': 28.6,
        },
        {
          'tag': 'segment tree',
          'totalAttempts': 34,
          'solvedCount': 12,
          'unsolvedCount': 22,
          'acRate': 35.3,
        },
        {
          'tag': 'heavy light decomposition',
          'totalAttempts': 19,
          'solvedCount': 8,
          'unsolvedCount': 11,
          'acRate': 42.1,
        },
      ];

  static List<Map<String, dynamic>> get recommendationsResponse => [
        {
          'contestId': 1853,
          'index': 'C',
          'name': 'Prefix Sum Optimization',
          'rating': 1600,
          'tags': ['divide and conquer', 'prefix sums'],
        },
        {
          'contestId': 1800,
          'index': 'D',
          'name': 'Segment Tree Basics',
          'rating': 1800,
          'tags': ['segment tree', 'data structures'],
        },
        {
          'contestId': 1750,
          'index': 'E',
          'name': 'Suffix Array Construction',
          'rating': 2100,
          'tags': ['suffix array', 'strings'],
        },
        {
          'contestId': 1720,
          'index': 'C',
          'name': 'Square Root Trick',
          'rating': 1900,
          'tags': ['square root decomposition'],
        },
        {
          'contestId': 1700,
          'index': 'D',
          'name': 'HLD Implementation',
          'rating': 2400,
          'tags': ['heavy light decomposition', 'trees'],
        },
        {
          'contestId': 1680,
          'index': 'B',
          'name': 'Divide and Conquer DP',
          'rating': 2200,
          'tags': ['divide and conquer', 'dp'],
        },
      ];

  static Map<String, dynamic> get upsolveResponse => {
        '1987': [
          {
            'contestId': 1987,
            'index': 'D',
            'name': 'Yet Another Problem',
            'rating': 2000,
            'tags': ['binary search', 'greedy', 'sorting'],
            'bestVerdict': 'WRONG_ANSWER',
            'url': 'https://codeforces.com/contest/1987/problem/D',
          },
          {
            'contestId': 1987,
            'index': 'E',
            'name': 'Complex Algorithm',
            'rating': 2400,
            'tags': ['divide and conquer', 'segment tree'],
            'bestVerdict': 'TIME_LIMIT_EXCEEDED',
            'url': 'https://codeforces.com/contest/1987/problem/E',
          },
        ],
        '1985': [
          {
            'contestId': 1985,
            'index': 'D',
            'name': 'Array Reconstruction',
            'rating': 1800,
            'tags': ['dp', 'greedy'],
            'bestVerdict': 'WRONG_ANSWER',
            'url': 'https://codeforces.com/contest/1985/problem/D',
          },
          {
            'contestId': 1985,
            'index': 'E',
            'name': 'Graph Connectivity',
            'rating': 2200,
            'tags': ['graphs', 'dsu'],
            'bestVerdict': 'TIME_LIMIT_EXCEEDED',
            'url': 'https://codeforces.com/contest/1985/problem/E',
          },
        ],
      };

  static Map<String, dynamic> get compareRatingResponse => {
        'handle1': 'ehsan_cf',
        'handle2': 'tourist',
        'rating1': 1487,
        'rating2': 3950,
        'ratingDelta': 2463,
        'higherRatedHandle': 'tourist',
        'maxRating1': 1523,
        'maxRating2': 3957,
        'rank1': 'specialist',
        'rank2': 'legendary grandmaster',
        'contestsParticipated1': 34,
        'contestsParticipated2': 450,
      };

  static List<Map<String, dynamic>> get friendsListResponse => [
        {
          'handle': 'arjun_cf',
          'rating': 1650,
          'maxRating': 1720,
          'rank': 'specialist',
          'avatar': '',
          'contestsParticipated': 41,
        },
        {
          'handle': 'rahul_cp',
          'rating': 1820,
          'maxRating': 1890,
          'rank': 'expert',
          'avatar': '',
          'contestsParticipated': 52,
        },
        {
          'handle': 'priya_codes',
          'rating': 2100,
          'maxRating': 2150,
          'rank': 'candidate master',
          'avatar': '',
          'contestsParticipated': 67,
        },
        {
          'handle': 'vikram_cf',
          'rating': 1350,
          'maxRating': 1400,
          'rank': 'pupil',
          'avatar': '',
          'contestsParticipated': 28,
        },
      ];

  static List<Map<String, dynamic>> get friendsLeaderboardResponse => [
        {
          'rank': 1,
          'handle': 'priya_codes',
          'rating': 2100,
          'tier': 'candidate master',
          'maxRating': 2150,
        },
        {
          'rank': 2,
          'handle': 'rahul_cp',
          'rating': 1820,
          'tier': 'expert',
          'maxRating': 1890,
        },
        {
          'rank': 3,
          'handle': 'ehsan_cf',
          'rating': 1487,
          'tier': 'specialist',
          'maxRating': 1523,
        },
        {
          'rank': 4,
          'handle': 'arjun_cf',
          'rating': 1650,
          'tier': 'specialist',
          'maxRating': 1720,
        },
        {
          'rank': 5,
          'handle': 'vikram_cf',
          'rating': 1350,
          'tier': 'pupil',
          'maxRating': 1400,
        },
      ];

  static Map<String, dynamic> get aiAnalysisResponse => {
        'problemAnalyses': [
          {
            'contestId': 1987,
            'problemIndex': 'D',
            'problemName': 'Yet Another Problem',
            'likelyIssue':
                'Implementation complexity leading to off-by-one errors in indexing logic',
            'conceptToStudy':
                'Careful boundary handling in iterative approaches and segment trees',
            'actionableTip':
                'Use 0-based indexing consistently and add assertions for boundary conditions',
          },
          {
            'contestId': 1987,
            'problemIndex': 'E',
            'problemName': 'Complex Algorithm',
            'likelyIssue':
                'TLE caused by inefficient traversal with O(n squared) complexity',
            'conceptToStudy':
                'Binary Lifting and Divide and Conquer optimization techniques',
            'actionableTip':
                'Precompute using binary lifting to reduce query complexity to O(log n)',
          },
          {
            'contestId': 1985,
            'problemIndex': 'D',
            'problemName': 'Array Reconstruction',
            'likelyIssue':
                'Greedy approach not correctly identifying optimal substructure',
            'conceptToStudy': 'Dynamic programming with greedy preprocessing',
            'actionableTip':
                'Sort by value first then apply greedy selection with DP verification',
          },
        ],
        'overallRecommendation':
            'Focus on mastering Segment Trees and Divide and Conquer techniques. Practice problems in the 1800 to 2200 range targeting these topics. Your implementations are correct but need optimization for time complexity.',
      };
}
