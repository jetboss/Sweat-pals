class ScheduledWorkout {
  final String id;
  final String workoutId;
  final DateTime scheduledDate;
  final bool isCompleted;
  final DateTime? completedAt;

  const ScheduledWorkout({
    required this.id,
    required this.workoutId,
    required this.scheduledDate,
    this.isCompleted = false,
    this.completedAt,
  });

  /// Create a copy with updated values
  ScheduledWorkout copyWith({
    String? id,
    String? workoutId,
    DateTime? scheduledDate,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return ScheduledWorkout(
      id: id ?? this.id,
      workoutId: workoutId ?? this.workoutId,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  /// Check if this scheduled workout is for today
  bool get isToday {
    final now = DateTime.now();
    return scheduledDate.year == now.year &&
        scheduledDate.month == now.month &&
        scheduledDate.day == now.day;
  }

  /// Check if this scheduled workout was missed (in the past and not completed)
  bool get isMissed {
    if (isCompleted) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final scheduled = DateTime(scheduledDate.year, scheduledDate.month, scheduledDate.day);
    return scheduled.isBefore(today);
  }
}
