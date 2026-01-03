/// Data model for daily step tracking
class StepData {
  final DateTime date;
  final int steps;
  final double distanceMeters;
  final int activeMinutes;

  const StepData({
    required this.date,
    required this.steps,
    this.distanceMeters = 0.0,
    this.activeMinutes = 0,
  });

  /// Distance in kilometers
  double get distanceKm => distanceMeters / 1000;

  /// Distance in miles
  double get distanceMiles => distanceMeters / 1609.34;

  /// Check if goal reached (default 10K steps)
  bool isGoalReached({int goal = 10000}) => steps >= goal;

  /// Progress toward goal (0.0 to 1.0)
  double progressToGoal({int goal = 10000}) => (steps / goal).clamp(0.0, 1.0);
}
