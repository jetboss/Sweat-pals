import 'package:hive/hive.dart';

part 'workout.g.dart';

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
  final String? videoUrl;

  const Exercise({
    required this.name,
    this.durationSeconds = 0,
    this.reps = 0,
    required this.instructions,
    this.imageUrl,
    this.videoUrl,
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
  final String category; // Strength, Fat Loss, Mobility

  @HiveField(5)
  final String? imageUrl;

  const Workout({
    required this.id,
    required this.title,
    required this.description,
    required this.exercises,
    required this.category,
    this.imageUrl,
  });

  int get totalDurationMinutes {
    int totalSeconds = exercises.fold(0, (sum, ex) => sum + (ex.durationSeconds > 0 ? ex.durationSeconds : 30)); // 30s avg for rep-based
    return (totalSeconds / 60).ceil();
  }
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
