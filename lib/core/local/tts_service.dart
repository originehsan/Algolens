import 'package:flutter_tts/flutter_tts.dart';
import 'package:algolens/core/local/hive_service.dart';

/// Singleton TTS service — static methods only.
/// Must call init() in main() before runApp().
/// Only speaks when app is in foreground.
class TtsService {
  TtsService._();

  static final FlutterTts _tts = FlutterTts();
  static bool _initialized = false;

  /// Sets up TTS engine with default settings.
  /// Safe to call multiple times — guarded by _initialized flag.
  static Future<void> init() async {
    if (_initialized) return;

    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.5);
    await _tts.setPitch(1.0);
    await _tts.setVolume(1.0);

    // Silent handlers — avoid unhandled callback crashes
    _tts.setCompletionHandler(() {});
    _tts.setErrorHandler((msg) {});

    _initialized = true;
  }

  /// Speaks text only if TTS is enabled in user settings.
  /// Applies user's saved language and volume from Hive before speaking.
  static Future<void> speak(String text) async {
    final enabled =
        HiveService.userSettings.get('te') as bool? ?? false;
    if (!enabled) return;

    final lang =
        HiveService.userSettings.get('tl') as String? ?? 'en-US';
    final volume =
        (HiveService.userSettings.get('tv') as double?) ?? 1.0;

    await _tts.setLanguage(lang);
    await _tts.setVolume(volume);

    // Stop any ongoing speech before starting new one
    await _tts.stop();
    await _tts.speak(text);
  }

  /// Speaks a pre-formatted contest reminder message.
  /// Message text changes based on how soon the contest starts.
  static Future<void> speakContestReminder({
    required String contestName,
    required int minutesBefore,
  }) async {
    final message = minutesBefore == 0
        ? '$contestName has started. Open AlgoLens to join!'
        : '$contestName starts in $minutesBefore minutes. Get ready!';

    await speak(message);
  }

  /// Stops any currently playing TTS speech.
  static Future<void> stop() async {
    await _tts.stop();
  }

  /// Returns false — flutter_tts does not expose isSpeaking on all platforms.
  static Future<bool> isSpeaking() async => false;

  /// Updates TTS language and persists to Hive.
  static Future<void> setLanguage(String lang) async {
    await _tts.setLanguage(lang);
    await HiveService.userSettings.put('tl', lang);
  }

  /// Updates TTS volume (clamped 0.0–1.0) and persists to Hive.
  static Future<void> setVolume(double volume) async {
    final clamped = volume.clamp(0.0, 1.0);
    await _tts.setVolume(clamped);
    await HiveService.userSettings.put('tv', clamped);
  }

  /// Returns list of languages supported by the device TTS engine.
  /// Falls back to ['en-US'] if the engine call fails.
  static Future<List<String>> getLanguages() async {
    try {
      final langs = await _tts.getLanguages;
      if (langs is List) {
        return langs.map((l) => l.toString()).toList();
      }
      return ['en-US'];
    } catch (_) {
      return ['en-US'];
    }
  }

  /// Stops TTS and releases resources.
  static Future<void> dispose() async {
    await _tts.stop();
  }
}