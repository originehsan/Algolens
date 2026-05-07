PROMPT 40 OF 68
AlgoLens — Competitive Programming Tracker
Job: Create/Update profile_repository.dart
Do NOT touch any other file
EXCEPT files listed in RIPPLE EFFECT.
only create file when file does not exist else do updation in existing file only as per prompt
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

// Profile cache box:
// HiveService.cachedProfiles
// Key: handle (String)
// Value: JSON string
// Valid: 5 minutes

// Check cache:
final box = HiveService.cachedProfiles;
final raw = box.get(handle) as String?;
if (raw != null) {
  final map = jsonDecode(raw)
    as Map<String, dynamic>;
  final cachedAt = DateTime.parse(
    map['cachedAt'] as String,
  );
  final isValid = DateTime.now()
    .difference(cachedAt)
    .inMinutes < 5;
  if (isValid) {
    return ProfileModel.fromJson(map);
  }
}

// Save to cache:
await box.put(
  handle,
  jsonEncode({
    ...profile.toJson(),
    'cachedAt': DateTime.now()
      .toIso8601String(),
  }),
);

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SECURE STORAGE REFERENCE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

final storage = ref.read(
  secureStorageProvider,
);
await storage.getCfHandle();

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CONTEXT — ALREADY BUILT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

P39 — Profile models:
  ProfileModel (fromJson, toJson)
  RatingGraphModel (fromJson)
  SubmissionStatsModel (fromJson)
  ContestHistoryModel (fromJson)

DioClient (P13):
  dioClientProvider
  client.get(path)
  throws ApiException on error

ApiEndpoints (P12):
  ApiEndpoints.profile(handle)
  → GET /users/{handle}/profile
  ApiEndpoints.ratingGraph(handle)
  → GET /users/{handle}/rating-graph
  ApiEndpoints.submissionStats(handle)
  → GET /users/{handle}/submission-stats
  ApiEndpoints.contestHistory(handle)
  → GET /users/{handle}/contest-history

HiveService (P09):
  HiveService.cachedProfiles
  Box<dynamic> key=handle
  value=JSON string with cachedAt

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

profile_repository.dart →
  P41 profile_provider.dart
    profileRepositoryProvider
    used by all 4 FutureProviders
  P42 profile_screen.dart
    reads all 4 providers which
    call this repository
  P43 home_provider.dart
    calls getProfile(handle) for
    home screen hero card
  P44 home_screen.dart
    indirectly via home_provider

⚠️ DO NOT rename any method:
  getProfile()
  getRatingGraph()
  getSubmissionStats()
  getContestHistory()
  All used by P41 provider.

⚠️ Cache logic MUST use
  HiveService.cachedProfiles box.
  5 minute expiry only for profile.
  Other endpoints NOT cached.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TASK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

File (CREATE/UPDATE):
→ features/profile/data/repositories/
  profile_repository.dart

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EXACT CODE
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
  profile/data/models/
  profile_model.dart';
import 'package:algolens/features/
  profile/data/models/
  rating_graph_model.dart';
import 'package:algolens/features/
  profile/data/models/
  submission_stats_model.dart';
import 'package:algolens/features/
  profile/data/models/
  contest_history_model.dart';

// ─────────────────────────────────
// PROVIDER
// ─────────────────────────────────

final profileRepositoryProvider =
  Provider<ProfileRepository>((ref) {
    return ProfileRepository(
      ref.watch(dioClientProvider),
    );
  });

// ─────────────────────────────────
// REPOSITORY
// ─────────────────────────────────

class ProfileRepository {

  ProfileRepository(this._client);
  final DioClient _client;

  // ───────────────────────────────
  // GET PROFILE
  // Checks Hive cache first (5 min)
  // Falls back to API
  // ───────────────────────────────

  Future<ProfileModel> getProfile(
    String handle,
  ) async {
    final box =
      HiveService.cachedProfiles;

    // Check cache first
    final raw =
      box.get(handle) as String?;
    if (raw != null) {
      try {
        final map = jsonDecode(raw)
          as Map<String, dynamic>;
        final cachedAt =
          DateTime.parse(
            map['cachedAt'] as String,
          );
        final isValid = DateTime.now()
          .difference(cachedAt)
          .inMinutes < 5;
        if (isValid) {
          return ProfileModel
            .fromJson(map);
        }
      } catch (_) {
        // Cache corrupted
        // Fall through to API
      }
    }

    // Fetch from API
    try {
      final data = await _client.get(
        ApiEndpoints.profile(handle),
      );
      final profile =
        ProfileModel.fromJson(data);

      // Save to cache
      await box.put(
        handle,
        jsonEncode({
          ...profile.toJson(),
          'cachedAt': DateTime.now()
            .toIso8601String(),
        }),
      );

      return profile;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException.unknown(
        e.toString(),
      );
    }
  }

  // ───────────────────────────────
  // GET RATING GRAPH
  // No cache — always fresh
  // ───────────────────────────────

  Future<List<RatingGraphModel>>
    getRatingGraph(
      String handle,
    ) async {
    try {
      final data = await _client.get(
        ApiEndpoints.ratingGraph(handle),
      );
      final list = data['data']
        as List<dynamic>?
        ?? (data is List ? data : []);
      return (list)
        .map(
          (e) => RatingGraphModel
            .fromJson(
              e as Map<String, dynamic>,
            ),
        )
        .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException.unknown(
        e.toString(),
      );
    }
  }

  // ───────────────────────────────
  // GET SUBMISSION STATS
  // No cache — always fresh
  // ───────────────────────────────

  Future<SubmissionStatsModel>
    getSubmissionStats(
      String handle,
    ) async {
    try {
      final data = await _client.get(
        ApiEndpoints
          .submissionStats(handle),
      );
      return SubmissionStatsModel
        .fromJson(data);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException.unknown(
        e.toString(),
      );
    }
  }

  // ───────────────────────────────
  // GET CONTEST HISTORY
  // No cache — always fresh
  // ───────────────────────────────

  Future<List<ContestHistoryModel>>
    getContestHistory(
      String handle,
    ) async {
    try {
      final data = await _client.get(
        ApiEndpoints
          .contestHistory(handle),
      );
      final list = data['data']
        as List<dynamic>?
        ?? (data is List ? data : []);
      return (list)
        .map(
          (e) => ContestHistoryModel
            .fromJson(
              e as Map<String, dynamic>,
            ),
        )
        .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException.unknown(
        e.toString(),
      );
    }
  }

  // ───────────────────────────────
  // CLEAR PROFILE CACHE
  // Called on logout
  // ───────────────────────────────

  Future<void> clearCache(
    String handle,
  ) async {
    await HiveService
      .cachedProfiles
      .delete(handle);
  }
}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
VERIFY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

□ profile_repository.dart
  created/updated ✓
□ profileRepositoryProvider
  Provider<ProfileRepository> ✓
□ Takes DioClient only ✓
□ getProfile() checks
  Hive cache first ✓
□ Cache valid: 5 minutes ✓
□ Cache corrupted →
  falls through to API ✓
□ Profile saved to Hive
  with cachedAt timestamp ✓
□ getRatingGraph() no cache ✓
□ getSubmissionStats() no cache ✓
□ getContestHistory() no cache ✓
□ All methods handle
  List response safely ✓
□ All catch ApiException
  + rethrow ✓
□ All catch generic
  + wrap unknown ✓
□ clearCache() deletes
  handle from box ✓
□ dart:convert imported ✓
□ HiveService imported ✓
□ No Isar imports ✓
□ flutter analyze 0 errors ✓

PROMPT 40 DONE. WAIT FOR PROMPT 41.