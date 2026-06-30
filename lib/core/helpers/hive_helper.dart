import 'dart:convert';
import 'package:algolens/core/local/hive_service.dart';

/// Hive cache read/write helpers
/// with TTL (time-to-live) support.
///
/// All cache entries stored as JSON:
/// { "data": ..., "cachedAt": epoch }
abstract class HiveHelper {
  HiveHelper._();

  // ── Write ────────────────────────────────────────

  /// Write JSON-encodable [data]
  /// to [box] under [key]
  /// Records cachedAt timestamp
  static Future<void> write({
    required dynamic box,
    required String key,
    required dynamic data,
  }) async {
    final entry = jsonEncode({
      'data': data,
      'cachedAt': DateTime.now().millisecondsSinceEpoch,
    });
    await box.put(key, entry);
  }

  // ── Read ─────────────────────────────────────────

  /// Read from [box] under [key]
  /// Returns null if missing,
  /// expired (ttlSeconds), or corrupt
  static dynamic read({
    required dynamic box,
    required String key,
    required int ttlSeconds,
  }) {
    final raw = box.get(key);
    if (raw == null) return null;
    try {
      final map = jsonDecode(raw as String) as Map<String, dynamic>;
      final cachedAt = map['cachedAt'] as int;
      final age = DateTime.now().millisecondsSinceEpoch - cachedAt;
      if (age > ttlSeconds * 1000) return null;
      return map['data'];
    } catch (_) {
      return null;
    }
  }

  // ── Delete ───────────────────────────────────────

  /// Delete single key from box
  static Future<void> delete({
    required dynamic box,
    required String key,
  }) async {
    await box.delete(key);
  }

  // ── Is expired? ──────────────────────────────────

  /// Check if cache entry expired
  /// without reading full data
  static bool isExpired({
    required dynamic box,
    required String key,
    required int ttlSeconds,
  }) {
    final raw = box.get(key);
    if (raw == null) return true;
    try {
      final map = jsonDecode(raw as String) as Map<String, dynamic>;
      final cachedAt = map['cachedAt'] as int;
      final age = DateTime.now().millisecondsSinceEpoch - cachedAt;
      return age > ttlSeconds * 1000;
    } catch (_) {
      return true;
    }
  }

  // ── Reminder helpers ─────────────────────────────

  /// Save contest reminder config to Hive
  static Future<void> saveReminder({
    required int contestId,
    required int minutesBefore,
    required bool pushEnabled,
    required bool ttsEnabled,
  }) async {
    final box = HiveService.contestReminders;
    await box.put(
        '$contestId',
        jsonEncode({
          'contestId': contestId,
          'minutesBefore': minutesBefore,
          'pushEnabled': pushEnabled,
          'ttsEnabled': ttsEnabled,
          'savedAt': DateTime.now().millisecondsSinceEpoch,
        }));
  }

  /// Read reminder config for contestId
  /// Returns null if not set
  static Map<String, dynamic>? readReminder(int contestId) {
    final box = HiveService.contestReminders;
    final raw = box.get('$contestId');
    if (raw == null) return null;
    try {
      return jsonDecode(raw as String) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  /// Has reminder been set for contestId?
  static bool hasReminder(int contestId) =>
      HiveService.contestReminders.containsKey('$contestId');

  /// Delete reminder for contestId
  static Future<void> deleteReminder(int contestId) async =>
      HiveService.contestReminders.delete('$contestId');
}
