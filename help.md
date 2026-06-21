PROMPT 53 OF 68
AlgoLens — Competitive Programming Tracker
Job: Create/Update upsolve_model.dart
     and upsolve_repository.dart
Do NOT touch any other file
EXCEPT files listed in RIPPLE EFFECT.
create file only when does not exist  ,  else update file as per prompt
  and read CONTEXT.md file for help
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
GLOBAL RULES (Apply to ALL 68 prompts)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

CODE STYLE:
→ .withOpacity() → .withValues(alpha:)
→ ref.refresh() → ref.invalidate()
→ ref.watch() in build() only
→ ref.read() in callbacks only
→ .when() → loading + error + data
→ mounted check after every async gap
→ const wherever possible
→ No unused imports
→ package:algolens/ prefix always
→ flutter_screenutil: 16.w 20.h 14.sp 8.r
→ Never use MediaQuery for sizing

DESIGN:
→ Background: #060B14 (navy)
→ Primary: #00D4FF (cyan)
→ Only 4 accents:
  Blue: #4DA3FF  Green: #22C55E
  Red:  #EF4444  Amber: #F59E0B
→ White with opacity only (min 0.50)
→ Min font weight: w500

DATABASE:
→ Hive ONLY (hive + hive_flutter)
→ NO Isar, NO .g.dart, NO codegen
→ NO @HiveType/@HiveField

FILE RULE:
→ File exists? → UPDATE content
→ File missing? → CREATE new file
→ NEVER delete or duplicate files

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TECH STACK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

flutter_riverpod: ^2.5.1
go_router: ^13.2.0
dio: ^5.4.0
hive: ^2.2.3 + hive_flutter: ^1.1.0
flutter_secure_storage: ^9.0.0
flutter_screenutil: ^5.9.0
google_fonts: ^6.2.1

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
HIVE REFERENCE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// upsolveLocalState box tracks
// done/undone per problem
// Key: problemKey (contestId_index)
// Value: JSON string

// Check if done:
final box =
  HiveService.upsolveLocalState;
final raw =
  box.get(problemKey) as String?;
bool isCompleted = false;
if (raw != null) {
  final map = jsonDecode(raw)
    as Map<String, dynamic>;
  isCompleted =
    map['isCompleted'] as bool;
}

// Mark as done:
await box.put(
  problemKey,
  jsonEncode({
    'isCompleted': true,
    'completedAt': DateTime.now()
      .toIso8601String(),
  }),
);

// Mark as undone:
await box.put(
  problemKey,
  jsonEncode({
    'isCompleted': false,
    'completedAt': null,
  }),
);

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SECURE STORAGE REFERENCE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

final storage = ref.read(
  secureStorageProvider,
);
final handle =
  await storage.getCfHandle();

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CONTEXT — ALREADY BUILT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

ProblemModel (P51):
  contestId, index, name,
  rating, tags
  computed: url, problemKey

DioClient (P13):
  dioClientProvider
  client.get(path)
  throws ApiException on error

ApiEndpoints (P12):
  ApiEndpoints.upsolve(handle)
  → GET /insights/{handle}/upsolve
  Response: Map<String,List>
  Keys = contestId strings
  Values = List of problems
  MUST flatten to List<UpsolveModel>

HiveService (P09):
  HiveService.upsolveLocalState
  Key: problemKey (contestId_index)
  Value: JSON with isCompleted flag

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
RIPPLE EFFECT
(Changes in already-built files)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

No changes needed in any
already-built file for this prompt.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CASCADING EFFECT
(Future files that depend on this)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

upsolve_model.dart →
  P54 upsolve_provider.dart
    upsolveProvider returns
    List<UpsolveModel>
  P54 upsolve_screen.dart
    displays pending/solved tabs

upsolve_repository.dart →
  P54 upsolve_provider.dart
    upsolveRepositoryProvider
    used by upsolve providers

⚠️ API returns Map<String,List>
   MUST flatten in repository:
   map.forEach((contestId, problems)
   for each problem:
     UpsolveModel.fromJson(p)
   isCompleted from Hive ONLY
   Backend has NO endpoint for this

⚠️ DO NOT rename:
  UpsolveModel fields:
    contestId, index, name,
    rating, tags, bestVerdict,
    url, isCompleted, isWeakTopic
  Repository methods:
    getUpsolveList(handle)
    toggleDone(problemKey)
    isDone(problemKey)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TASK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

File 1 (CREATE/UPDATE):
→ features/upsolve/data/models/
  upsolve_model.dart

File 2 (CREATE/UPDATE):
→ features/upsolve/data/repositories/
  upsolve_repository.dart

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EXACT CODE — upsolve_model.dart
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// Pure Dart — no annotations
// isCompleted from Hive only
// Backend has NO endpoint for this
// API response is Map<String, List>
// Flattened in repository

class UpsolveModel {
  const UpsolveModel({
    required this.contestId,
    required this.index,
    required this.name,
    required this.rating,
    required this.tags,
    required this.bestVerdict,
    required this.url,
    required this.isCompleted,
    required this.isWeakTopic,
  });

  final int contestId;
  final String index;
  final String name;
  final int rating;
  final List<String> tags;

  /// Best verdict from CF
  /// e.g. 'WRONG_ANSWER', 'TLE'
  final String bestVerdict;

  /// Direct CF problem URL
  final String url;

  /// Done/undone — Hive only
  /// NOT from API
  final bool isCompleted;

  /// True if topic is in
  /// user's weak topics list
  final bool isWeakTopic;

  factory UpsolveModel.fromJson(
    Map<String, dynamic> json, {
    bool isCompleted = false,
    bool isWeakTopic = false,
  }) {
    final contestId =
      (json['contestId'] as int?) ??
      0;
    final index =
      (json['index'] as String?) ?? '';

    return UpsolveModel(
      contestId: contestId,
      index: index,
      name:
        (json['name'] as String?) ??
        '',
      rating:
        (json['rating'] as int?) ?? 0,
      tags: (json['tags'] as List?)
        ?.map((e) => e as String)
        .toList() ?? [],
      bestVerdict:
        (json['bestVerdict']
          as String?) ?? '',
      url:
        (json['url'] as String?) ??
        'https://codeforces.com'
        '/contest/$contestId'
        '/problem/$index',
      isCompleted: isCompleted,
      isWeakTopic: isWeakTopic,
    );
  }

  Map<String, dynamic> toJson() => {
    'contestId': contestId,
    'index': index,
    'name': name,
    'rating': rating,
    'tags': tags,
    'bestVerdict': bestVerdict,
    'url': url,
    'isCompleted': isCompleted,
    'isWeakTopic': isWeakTopic,
  };

  // ───────────────────────────────
  // COMPUTED PROPERTIES
  // ───────────────────────────────

  /// Unique key for Hive
  String get problemKey =>
    '${contestId}_$index';

  /// Copy with updated isCompleted
  UpsolveModel copyWith({
    bool? isCompleted,
  }) =>
    UpsolveModel(
      contestId: contestId,
      index: index,
      name: name,
      rating: rating,
      tags: tags,
      bestVerdict: bestVerdict,
      url: url,
      isCompleted:
        isCompleted ?? this.isCompleted,
      isWeakTopic: isWeakTopic,
    );

  /// Verdict short label for UI
  String get verdictLabel =>
    switch (bestVerdict) {
      'WRONG_ANSWER' => 'WA',
      'TIME_LIMIT_EXCEEDED' => 'TLE',
      'MEMORY_LIMIT_EXCEEDED'
        => 'MLE',
      'RUNTIME_ERROR' => 'RE',
      'COMPILATION_ERROR' => 'CE',
      _ => bestVerdict.isNotEmpty
        ? bestVerdict
            .substring(0, 2)
            .toUpperCase()
        : '??',
    };
}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EXACT CODE — upsolve_repository.dart
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'dart:convert';
import 'package:flutter_riverpod/
  flutter_riverpod.dart';
import 'package:algolens/core/errors/
  app_exceptions.dart';
import 'package:algolens/core/local/
  hive_service.dart';
import 'package:algolens/core/network/
  api_endpoints.dart';
import 'package:algolens/core/network/
  dio_client.dart';
import 'package:algolens/features/
  upsolve/data/models/
  upsolve_model.dart';

// ─────────────────────────────────
// PROVIDER
// ─────────────────────────────────

final upsolveRepositoryProvider =
  Provider<UpsolveRepository>(
    (ref) => UpsolveRepository(
      ref.watch(dioClientProvider),
    ),
  );

// ─────────────────────────────────
// REPOSITORY
// ─────────────────────────────────

class UpsolveRepository {

  UpsolveRepository(this._client);
  final DioClient _client;

  // ───────────────────────────────
  // GET UPSOLVE LIST
  // Response is Map<String,List>
  // Keys = contestId strings
  // Values = List of problems
  // Flatten to List<UpsolveModel>
  // Merge isCompleted from Hive
  // Sort: weak topics first
  // ───────────────────────────────

  Future<List<UpsolveModel>>
    getUpsolveList(
      String handle,
    ) async {
    try {
      final data = await _client.get(
        ApiEndpoints.upsolve(handle),
      );

      final items = <UpsolveModel>[];

      // API returns
      // Map<String, dynamic>
      // Keys are contestId strings
      if (data is Map) {
        data.forEach(
          (contestId, problems) {
            if (problems is List) {
              for (final p in problems) {
                if (p is Map
                  String,
                  dynamic
                >) {
                  final key =
                    '${p['contestId'] ?? contestId}'
                    '_${p['index'] ?? ''}';
                  final done =
                    isDone(key);
                  items.add(
                    UpsolveModel
                      .fromJson(
                        p,
                        isCompleted:
                          done,
                      ),
                  );
                }
              }
            }
          },
        );
      }

      // Sort: weak topics first
      // then by rating ascending
      items.sort((a, b) {
        if (a.isWeakTopic &&
          !b.isWeakTopic) return -1;
        if (!a.isWeakTopic &&
          b.isWeakTopic) return 1;
        return a.rating
          .compareTo(b.rating);
      });

      return items;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException.unknown(
        e.toString(),
      );
    }
  }

  // ───────────────────────────────
  // IS DONE
  // Reads from Hive only
  // Backend has NO endpoint
  // ───────────────────────────────

  bool isDone(String problemKey) {
    final box =
      HiveService.upsolveLocalState;
    final raw =
      box.get(problemKey) as String?;
    if (raw == null) return false;
    try {
      final map = jsonDecode(raw)
        as Map<String, dynamic>;
      return
        (map['isCompleted']
          as bool?) ?? false;
    } catch (_) {
      return false;
    }
  }

  // ───────────────────────────────
  // TOGGLE DONE
  // Saves to Hive only
  // Backend has NO endpoint
  // ───────────────────────────────

  Future<void> toggleDone(
    String problemKey,
  ) async {
    final box =
      HiveService.upsolveLocalState;
    final current = isDone(problemKey);

    await box.put(
      problemKey,
      jsonEncode({
        'isCompleted': !current,
        'completedAt': !current
          ? DateTime.now()
            .toIso8601String()
          : null,
      }),
    );
  }

  // ───────────────────────────────
  // MARK DONE
  // Explicitly mark as done
  // ───────────────────────────────

  Future<void> markDone(
    String problemKey,
  ) async {
    final box =
      HiveService.upsolveLocalState;
    await box.put(
      problemKey,
      jsonEncode({
        'isCompleted': true,
        'completedAt': DateTime.now()
          .toIso8601String(),
      }),
    );
  }

  // ───────────────────────────────
  // MARK UNDONE
  // Explicitly mark as not done
  // ───────────────────────────────

  Future<void> markUndone(
    String problemKey,
  ) async {
    final box =
      HiveService.upsolveLocalState;
    await box.put(
      problemKey,
      jsonEncode({
        'isCompleted': false,
        'completedAt': null,
      }),
    );
  }
}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
VERIFY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ upsolve_model.dart
  created/updated ✓
□ 9 fields present ✓
□ isCompleted defaults false ✓
□ isWeakTopic defaults false ✓
□ fromJson() handles all
  nullable fields ✓
□ url fallback to CF URL
  if not in JSON ✓
□ toJson() present ✓
□ problemKey computed ✓
□ copyWith() present ✓
□ verdictLabel computed ✓
□ WA/TLE/MLE/RE/CE
  short labels ✓

□ upsolve_repository.dart
  created/updated ✓
□ upsolveRepositoryProvider ✓
□ getUpsolveList() flattens
  Map<String,List> correctly ✓
□ isCompleted merged from
  Hive for each item ✓
□ Sort: weak topics first
  then rating asc ✓
□ isDone() reads from
  Hive only ✓
□ Returns false on
  corrupted data ✓
□ toggleDone() flips
  isCompleted in Hive ✓
□ markDone() explicitly
  sets true ✓
□ markUndone() explicitly
  sets false ✓
□ dart:convert imported ✓
□ HiveService imported ✓
□ No Isar imports ✓
□ flutter analyze 0 errors ✓

PROMPT 53 DONE. WAIT FOR PROMPT 54.