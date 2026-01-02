import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/workout.dart';
import '../models/workout_progress.dart';
import 'workouts_provider.dart';

final workoutProgressProvider = StateNotifierProvider<WorkoutProgressNotifier, WorkoutProgress>((ref) {
  return WorkoutProgressNotifier(ref);
});

class WorkoutProgressNotifier extends StateNotifier<WorkoutProgress> {
  final Ref _ref;

  WorkoutProgressNotifier(this._ref) : super(const WorkoutProgress()) {
    _loadProgress();
  }

  /// Load progress from Hive
  void _loadProgress() {
    final box = Hive.box<WorkoutProgress>('workout_progress');
    if (box.isNotEmpty) {
      state = box.getAt(0) ?? const WorkoutProgress();
    } else {
      // Initialize with beginner workouts unlocked
      state = const WorkoutProgress(
        unlockedWorkoutIds: ['B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7'],
        completionCounts: {},
      );
      _saveProgress();
    }
  }

  /// Save progress to Hive
  Future<void> _saveProgress() async {
    final box = Hive.box<WorkoutProgress>('workout_progress');
    if (box.isEmpty) {
      await box.add(state);
    } else {
      await box.putAt(0, state);
    }
  }

  /// Record a workout completion
  Future<List<String>> completeWorkout(String workoutId) async {
    final newCompletionCounts = Map<String, int>.from(state.completionCounts);
    newCompletionCounts[workoutId] = (newCompletionCounts[workoutId] ?? 0) + 1;

    // Update streak
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    int newStreak = state.currentStreak;
    
    if (state.lastWorkoutDate != null) {
      final lastDate = DateTime(
        state.lastWorkoutDate!.year,
        state.lastWorkoutDate!.month,
        state.lastWorkoutDate!.day,
      );
      final difference = today.difference(lastDate).inDays;
      
      if (difference == 0) {
        // Same day, no streak change
      } else if (difference == 1) {
        // Consecutive day, increase streak
        newStreak += 1;
      } else {
        // Missed days, reset streak
        newStreak = 1;
      }
    } else {
      newStreak = 1;
    }

    // Check for newly unlocked workouts
    final newlyUnlocked = <String>[];
    final allWorkouts = _ref.read(workoutsProvider);
    final currentUnlocked = List<String>.from(state.unlockedWorkoutIds);

    for (final workout in allWorkouts) {
      if (currentUnlocked.contains(workout.id)) continue;

      bool shouldUnlock = false;

      if (workout.unlockWorkoutId != null) {
        // Specific workout requirement
        final requiredCount = newCompletionCounts[workout.unlockWorkoutId] ?? 0;
        shouldUnlock = requiredCount >= workout.unlockRequirement;
      } else if (workout.level == WorkoutLevel.intermediate) {
        // Intermediate: Complete 3 beginner workouts
        final beginnerCompletions = newCompletionCounts.entries
            .where((e) => e.key.startsWith('B'))
            .fold(0, (sum, e) => sum + e.value);
        shouldUnlock = beginnerCompletions >= workout.unlockRequirement;
      } else if (workout.level == WorkoutLevel.advanced) {
        // Advanced: Complete 3 intermediate workouts or specific unlock
        final intermediateCompletions = newCompletionCounts.entries
            .where((e) => e.key.startsWith('I'))
            .fold(0, (sum, e) => sum + e.value);
        shouldUnlock = intermediateCompletions >= workout.unlockRequirement;
      }

      // Special case for challenge workouts
      if (workout.isChallenge && workout.level == WorkoutLevel.intermediate) {
        // Unlock when all beginner workouts completed at least once
        final allBeginnersCompleted = ['B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7']
            .every((id) => (newCompletionCounts[id] ?? 0) >= 1);
        shouldUnlock = allBeginnersCompleted;
      } else if (workout.isChallenge && workout.level == WorkoutLevel.advanced) {
        // Unlock when all intermediate workouts completed at least once
        final allIntermediatesCompleted = ['I1', 'I2', 'I3', 'I4', 'I5', 'I6', 'I7']
            .every((id) => (newCompletionCounts[id] ?? 0) >= 1);
        shouldUnlock = allIntermediatesCompleted;
      }

      if (shouldUnlock) {
        currentUnlocked.add(workout.id);
        newlyUnlocked.add(workout.id);
      }
    }

    state = WorkoutProgress(
      completionCounts: newCompletionCounts,
      unlockedWorkoutIds: currentUnlocked,
      lastWorkoutDate: now,
      currentStreak: newStreak,
      longestStreak: newStreak > state.longestStreak ? newStreak : state.longestStreak,
      totalWorkoutsCompleted: state.totalWorkoutsCompleted + 1,
    );

    await _saveProgress();
    return newlyUnlocked;
  }

  /// Check if a workout is unlocked
  bool isUnlocked(String workoutId) {
    return state.isUnlocked(workoutId);
  }

  /// Get completion count for a workout
  int getCompletionCount(String workoutId) {
    return state.getCompletionCount(workoutId);
  }

  /// Get unlock progress for a locked workout (returns value 0.0 to 1.0)
  double getUnlockProgress(Workout workout) {
    if (isUnlocked(workout.id)) return 1.0;
    if (workout.unlockRequirement == 0) return 1.0;

    int currentProgress = 0;
    
    if (workout.unlockWorkoutId != null) {
      currentProgress = getCompletionCount(workout.unlockWorkoutId!);
    } else if (workout.level == WorkoutLevel.intermediate) {
      currentProgress = state.completionCounts.entries
          .where((e) => e.key.startsWith('B'))
          .fold(0, (sum, e) => sum + e.value);
    } else if (workout.level == WorkoutLevel.advanced) {
      currentProgress = state.completionCounts.entries
          .where((e) => e.key.startsWith('I'))
          .fold(0, (sum, e) => sum + e.value);
    }

    return (currentProgress / workout.unlockRequirement).clamp(0.0, 1.0);
  }

  /// Get unlock requirements text for display
  String getUnlockText(Workout workout) {
    if (isUnlocked(workout.id)) return 'Unlocked';
    
    if (workout.isChallenge) {
      if (workout.level == WorkoutLevel.intermediate) {
        return 'Complete all Beginner workouts';
      } else if (workout.level == WorkoutLevel.advanced) {
        return 'Complete all Intermediate workouts';
      }
    }

    if (workout.unlockWorkoutId != null) {
      final sourceWorkout = _ref.read(workoutsProvider.notifier).getById(workout.unlockWorkoutId!);
      final sourceName = sourceWorkout?.title ?? workout.unlockWorkoutId!;
      return 'Complete "$sourceName" ${workout.unlockRequirement}x';
    }

    if (workout.level == WorkoutLevel.intermediate) {
      return 'Complete ${workout.unlockRequirement} Beginner workouts';
    } else if (workout.level == WorkoutLevel.advanced) {
      return 'Complete ${workout.unlockRequirement} Intermediate workouts';
    }

    return 'Locked';
  }

  /// Get recommended workouts based on user's progress
  List<Workout> getRecommendedWorkouts() {
    final allWorkouts = _ref.read(workoutsProvider);
    final unlocked = allWorkouts.where((w) => isUnlocked(w.id)).toList();
    
    // Sort by least completed first
    unlocked.sort((a, b) {
      final aCount = getCompletionCount(a.id);
      final bCount = getCompletionCount(b.id);
      return aCount.compareTo(bCount);
    });

    return unlocked.take(3).toList();
  }
}
