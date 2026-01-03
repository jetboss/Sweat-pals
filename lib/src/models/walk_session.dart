/// A recorded walking session with GPS tracking
class WalkSession {
  final String id;
  final DateTime startTime;
  final DateTime? endTime;
  final double distanceMeters;
  final List<GpsPoint> route;
  final int steps;

  WalkSession({
    required this.id,
    required this.startTime,
    this.endTime,
    this.distanceMeters = 0,
    this.route = const [],
    this.steps = 0,
  });

  /// Duration of the walk
  Duration get duration {
    final end = endTime ?? DateTime.now();
    return end.difference(startTime);
  }

  /// Distance in kilometers
  double get distanceKm => distanceMeters / 1000;

  /// Average pace in minutes per kilometer
  double get paceMinPerKm {
    if (distanceKm <= 0) return 0;
    return duration.inSeconds / 60 / distanceKm;
  }

  /// Format duration as "HH:MM:SS" or "MM:SS"
  String get formattedDuration {
    final d = duration;
    if (d.inHours > 0) {
      return '${d.inHours}:${(d.inMinutes % 60).toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '${d.inMinutes}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  /// Format pace as "MM:SS /km"
  String get formattedPace {
    if (paceMinPerKm <= 0 || paceMinPerKm.isInfinite) return '--:-- /km';
    final mins = paceMinPerKm.floor();
    final secs = ((paceMinPerKm - mins) * 60).round();
    return '$mins:${secs.toString().padLeft(2, '0')} /km';
  }

  /// Create a copy with updated fields
  WalkSession copyWith({
    String? id,
    DateTime? startTime,
    DateTime? endTime,
    double? distanceMeters,
    List<GpsPoint>? route,
    int? steps,
  }) {
    return WalkSession(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      distanceMeters: distanceMeters ?? this.distanceMeters,
      route: route ?? this.route,
      steps: steps ?? this.steps,
    );
  }
}

/// A GPS coordinate point with timestamp
class GpsPoint {
  final double latitude;
  final double longitude;
  final DateTime timestamp;

  GpsPoint({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });
}
