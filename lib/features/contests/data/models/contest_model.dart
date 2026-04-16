class Contest {
  final int contestId;
  final String name;
  final String type;
  final int durationSeconds;
  final int startTimeSeconds;
  final int relativeTimeSeconds;

  const Contest({
    required this.contestId,
    required this.name,
    required this.type,
    required this.durationSeconds,
    required this.startTimeSeconds,
    required this.relativeTimeSeconds,
  });

  factory Contest.fromJson(Map<String, dynamic> json) {
    return Contest(
      contestId: json['contestId'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      durationSeconds: json['durationSeconds'] as int,
      startTimeSeconds: json['startTimeSeconds'] as int,
      relativeTimeSeconds: json['relativeTimeSeconds'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contestId': contestId,
      'name': name,
      'type': type,
      'durationSeconds': durationSeconds,
      'startTimeSeconds': startTimeSeconds,
      'relativeTimeSeconds': relativeTimeSeconds,
    };
  }

  bool get isUpcoming => relativeTimeSeconds < 0;

  bool get isLive =>
      relativeTimeSeconds >= 0 && relativeTimeSeconds < durationSeconds;

  bool get isFinished => relativeTimeSeconds >= durationSeconds;

  String get formattedDuration {
    final hours = durationSeconds ~/ 3600;
    final minutes = (durationSeconds % 3600) ~/ 60;
    if (minutes == 0) return '${hours}h';
    return '${hours}h ${minutes}m';
  }

  DateTime get startDateTime => DateTime.fromMillisecondsSinceEpoch(
        startTimeSeconds * 1000,
      );

  String get suitabilityLabel {
    final lower = name.toLowerCase();
    if (lower.contains('div. 1') && !lower.contains('div. 2')) {
      return 'Too Hard';
    }
    if (lower.contains('div. 2') ||
        lower.contains('div. 3') ||
        lower.contains('div. 4') ||
        lower.contains('educational')) {
      return 'Good Match';
    }
    if (lower.contains('div. 1') && lower.contains('div. 2')) {
      return 'Moderate';
    }
    return 'Moderate';
  }

  String get formattedStartTime {
    final dt = startDateTime;
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    final day = dt.day.toString().padLeft(2, '0');
    final month = dt.month.toString().padLeft(2, '0');
    return '$day/$month $hour:$minute';
  }
}
