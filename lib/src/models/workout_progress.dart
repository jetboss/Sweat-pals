/// Tracks user's workout completion progress and unlocks
class WorkoutProgress {
  final Map<String, int> completionCounts; // workoutId -> times completed
  final List<String> unlockedWorkoutIds;
  final DateTime? lastWorkoutDate;
  final int currentStreak;
  final int longestStreak;
  final int totalWorkoutsCompleted;

  const WorkoutProgress({
    this.completionCounts = const {},
    this.unlockedWorkoutIds = const [],
    this.lastWorkoutDate,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.totalWorkoutsCompleted = 0,
  });

  /// Get number of times a workout has been completed
  int getCompletionCount(String workoutId) {
    return completionCounts[workoutId] ?? 0;
  }

  /// Check if a workout is unlocked
  bool isUnlocked(String workoutId) {
    return unlockedWorkoutIds.contains(workoutId);
  }

  /// Create a copy with updated values
  WorkoutProgress copyWith({
    Map<String, int>? completionCounts,
    List<String>? unlockedWorkoutIds,
    DateTime? lastWorkoutDate,
    int? currentStreak,
    int? longestStreak,
    int? totalWorkoutsCompleted,
  }) {
    return WorkoutProgress(
      completionCounts: completionCounts ?? this.completionCounts,
      unlockedWorkoutIds: unlockedWorkoutIds ?? this.unlockedWorkoutIds,
      lastWorkoutDate: lastWorkoutDate ?? this.lastWorkoutDate,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      totalWorkoutsCompleted: totalWorkoutsCompleted ?? this.totalWorkoutsCompleted,
    );
  }
}
