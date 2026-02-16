class WorkoutEntry {
  final String id;
  final String type;
  final int durationMinutes;
  final int caloriesBurned;
  final DateTime dateTime;
  final String? notes;

  WorkoutEntry({
    required this.id,
    required this.type,
    required this.durationMinutes,
    required this.caloriesBurned,
    required this.dateTime,
    this.notes,
  });
}
