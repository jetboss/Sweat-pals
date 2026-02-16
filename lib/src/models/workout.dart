/// Difficulty levels for workouts
enum WorkoutLevel {
  beginner,
  intermediate,
  advanced,
}

/// Equipment requirements
enum Equipment {
  none,
  dumbbells,
  resistanceBands,
  gym,
}

/// Workout categories
enum WorkoutCategory {
  fullBody,
  upper,
  lower,
  core,
  hiit,
  mobility,
  challenge,
  lowImpact, // Knee-friendly, seated, floor exercises
}

class Exercise {
  final String name;
  final int durationSeconds; // 0 if rep-based
  final int reps; // 0 if duration-based
  final String instructions;
  final String? imageUrl;
  final String? lottieUrl;
  final bool isLowImpact; // True = no jumping, minimal knee stress

  const Exercise({
    required this.name,
    this.durationSeconds = 0,
    this.reps = 0,
    required this.instructions,
    this.imageUrl,
    this.lottieUrl,
    this.isLowImpact = false,
  });
}

class Workout {
  final String id;
  final String title;
  final String description;
  final List<Exercise> exercises;
  final String category; // Legacy - keep for compatibility
  final String? imageUrl;
  final WorkoutLevel level;
  final int durationMinutes;
  final Equipment equipment;
  final WorkoutCategory workoutCategory;
  final int unlockRequirement; // Number of completions needed to unlock (0 = always unlocked)
  final String? unlockWorkoutId; // If set, must complete this workout X times to unlock
  final bool isChallenge;

  const Workout({
    required this.id,
    required this.title,
    required this.description,
    required this.exercises,
    required this.category,
    this.imageUrl,
    this.level = WorkoutLevel.beginner,
    this.durationMinutes = 15,
    this.equipment = Equipment.none,
    this.workoutCategory = WorkoutCategory.fullBody,
    this.unlockRequirement = 0,
    this.unlockWorkoutId,
    this.isChallenge = false,
  });

  int get totalDurationMinutes {
    int totalSeconds = exercises.fold(0, (sum, ex) => sum + (ex.durationSeconds > 0 ? ex.durationSeconds : 30)); // 30s avg for rep-based
    return (totalSeconds / 60).ceil();
  }

  String get levelDisplayName {
    switch (level) {
      case WorkoutLevel.beginner:
        return 'Beginner';
      case WorkoutLevel.intermediate:
        return 'Intermediate';
      case WorkoutLevel.advanced:
        return 'Advanced';
    }
  }

  String get categoryDisplayName {
    switch (workoutCategory) {
      case WorkoutCategory.fullBody:
        return 'Full Body';
      case WorkoutCategory.upper:
        return 'Upper Body';
      case WorkoutCategory.lower:
        return 'Lower Body';
      case WorkoutCategory.core:
        return 'Core';
      case WorkoutCategory.hiit:
        return 'HIIT';
      case WorkoutCategory.mobility:
        return 'Mobility';
      case WorkoutCategory.challenge:
        return 'Challenge';
      case WorkoutCategory.lowImpact:
        return '🦵 Low Impact';
    }
  }

  /// Returns true if all exercises in the workout are low-impact (knee-friendly)
  bool get isKneeFriendly => exercises.every((e) => e.isLowImpact);

  bool get isCustom => id.length > 10; // UUIDs are 36 chars, built-in IDs are short (e.g., "B1")
}

class WorkoutSession {
  final String workoutId;
  final DateTime completedAt;
  final int totalDurationSeconds;
  final String notes;

  const WorkoutSession({
    required this.workoutId,
    required this.completedAt,
    required this.totalDurationSeconds,
    this.notes = '',
  });
}
