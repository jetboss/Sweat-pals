import 'package:hive/hive.dart';

part 'workout.g.dart';

/// Difficulty levels for workouts
@HiveType(typeId: 13)
enum WorkoutLevel {
  @HiveField(0)
  beginner,
  @HiveField(1)
  intermediate,
  @HiveField(2)
  advanced,
}

/// Equipment requirements
@HiveType(typeId: 14)
enum Equipment {
  @HiveField(0)
  none,
  @HiveField(1)
  dumbbells,
  @HiveField(2)
  resistanceBands,
  @HiveField(3)
  gym,
}

/// Workout categories
@HiveType(typeId: 15)
enum WorkoutCategory {
  @HiveField(0)
  fullBody,
  @HiveField(1)
  upper,
  @HiveField(2)
  lower,
  @HiveField(3)
  core,
  @HiveField(4)
  hiit,
  @HiveField(5)
  mobility,
  @HiveField(6)
  challenge,
  @HiveField(7)
  lowImpact, // Knee-friendly, seated, floor exercises
}

@HiveType(typeId: 10)
class Exercise {
  @HiveField(0)
  final String name;
  
  @HiveField(1)
  final int durationSeconds; // 0 if rep-based
  
  @HiveField(2)
  final int reps; // 0 if duration-based
  
  @HiveField(3)
  final String instructions;

  @HiveField(4)
  final String? imageUrl;
  
  @HiveField(5)
  final String? lottieUrl;

  @HiveField(6)
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

@HiveType(typeId: 11)
class Workout {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final String description;
  
  @HiveField(3)
  final List<Exercise> exercises;
  
  @HiveField(4)
  final String category; // Legacy - keep for compatibility
  
  @HiveField(5)
  final String? imageUrl;

  @HiveField(6)
  final WorkoutLevel level;

  @HiveField(7)
  final int durationMinutes;

  @HiveField(8)
  final Equipment equipment;

  @HiveField(9)
  final WorkoutCategory workoutCategory;

  @HiveField(10)
  final int unlockRequirement; // Number of completions needed to unlock (0 = always unlocked)

  @HiveField(11)
  final String? unlockWorkoutId; // If set, must complete this workout X times to unlock

  @HiveField(12)
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

@HiveType(typeId: 12)
class WorkoutSession {
  @HiveField(0)
  final String workoutId;
  
  @HiveField(1)
  final DateTime completedAt;
  
  @HiveField(2)
  final int totalDurationSeconds;
  
  @HiveField(3)
  final String notes;

  const WorkoutSession({
    required this.workoutId,
    required this.completedAt,
    required this.totalDurationSeconds,
    this.notes = '',
  });
}
