// Pure Dart — no annotations
// Difficulty calculated locally
// from contest name string

class ContestModel {
  const ContestModel({
    required this.contestId,
    required this.name,
    required this.type,
    required this.durationSeconds,
    required this.startTimeSeconds,
    required this.relativeTimeSeconds,
  });

  final int contestId;
  final String name;
  final String type;
  final int durationSeconds;
  final int startTimeSeconds;

  /// Negative = upcoming
  /// Positive = past
  final int relativeTimeSeconds;

  factory ContestModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      ContestModel(
        contestId: json['contestId'] as int,
        name: json['name'] as String,
        type: (json['type'] as String?) ?? 'CF',
        durationSeconds: json['durationSeconds'] as int,
        startTimeSeconds: json['startTimeSeconds'] as int,
        relativeTimeSeconds: json['relativeTimeSeconds'] as int,
      );

  Map<String, dynamic> toJson() => {
        'contestId': contestId,
        'name': name,
        'type': type,
        'durationSeconds': durationSeconds,
        'startTimeSeconds': startTimeSeconds,
        'relativeTimeSeconds': relativeTimeSeconds,
      };

  // ───────────────────────────────
  // COMPUTED PROPERTIES
  // ───────────────────────────────

  /// Contest start as DateTime
  DateTime get startDateTime => DateTime.fromMillisecondsSinceEpoch(
        startTimeSeconds * 1000,
      );

  /// Duration formatted: "2h 0m"
  String get durationFormatted {
    final hours = durationSeconds ~/ 3600;
    final minutes = (durationSeconds % 3600) ~/ 60;
    if (minutes == 0) {
      return '${hours}h';
    }
    return '${hours}h ${minutes}m';
  }

  /// True if contest not started yet
  bool get isUpcoming => relativeTimeSeconds < 0;

  /// True if contest in progress
  bool get isLive =>
      relativeTimeSeconds >= 0 && relativeTimeSeconds < durationSeconds;

  /// True if contest finished
  bool get isFinished => relativeTimeSeconds >= durationSeconds;

  /// Difficulty from name string
  /// Calculated locally — no API
  String get difficulty {
    if (name.contains('Div. 1 +')) {
      return 'Hard';
    }
    if (name.contains('Div. 1')) {
      return 'Hard';
    }
    if (name.contains('Div. 2')) {
      return 'Moderate';
    }
    if (name.contains('Div. 3')) {
      return 'Easy';
    }
    if (name.contains('Div. 4')) {
      return 'Easy';
    }
    if (name.toLowerCase().contains('educational')) {
      return 'Moderate';
    }
    return 'Moderate';
  }

  /// Format contest start time for display
  String get formattedStartTime {
    try {
      final dt = startDateTime;
      return '${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return 'Time not available';
    }
  }

  /// Duration formatted: "2h 0m"
  String get formattedDuration {
    final hours = durationSeconds ~/ 3600;
    final minutes = (durationSeconds % 3600) ~/ 60;
    if (minutes == 0) {
      return '${hours}h';
    }
    return '${hours}h ${minutes}m';
  }

  /// Suitability label based on difficulty
  String get suitabilityLabel {
    switch (difficulty) {
      case 'Hard':
        return 'Advanced Coders';
      case 'Moderate':
        return 'Intermediate';
      case 'Easy':
        return 'Beginners';
      default:
        return 'For Everyone';
    }
  }
}
