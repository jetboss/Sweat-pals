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
      // Initialize with beginner and knee-friendly workouts unlocked
      state = const WorkoutProgress(
        unlockedWorkoutIds: ['B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'KF1', 'KF2', 'KF3'],
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

  /// Record a walk completion (counts toward streak like workouts)
  Future<void> completeWalk({
    required double distanceKm,
    required Duration duration,
  }) async {
    // Update streak (same logic as workouts)
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

    // Track walk completions with special ID "WALK"
    final newCompletionCounts = Map<String, int>.from(state.completionCounts);
    newCompletionCounts['WALK'] = (newCompletionCounts['WALK'] ?? 0) + 1;

    state = WorkoutProgress(
      completionCounts: newCompletionCounts,
      unlockedWorkoutIds: state.unlockedWorkoutIds,
      lastWorkoutDate: now,
      currentStreak: newStreak,
      longestStreak: newStreak > state.longestStreak ? newStreak : state.longestStreak,
      totalWorkoutsCompleted: state.totalWorkoutsCompleted + 1,
    );

    await _saveProgress();
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
    
    if (unlocked.isEmpty) return [];
    
    // Get the last completed workout to avoid repeating
    final lastCompletedId = _getLastCompletedWorkoutId();
    
    // Score each workout
    final scored = unlocked.map((workout) {
      double score = 0;
      
      // Prioritize unfinished workouts
      final count = getCompletionCount(workout.id);
      if (count == 0) {
        score += 30; // Never done? Try it!
      } else {
        score -= count * 5; // Reduce score for over-done workouts
      }
      
      // Avoid repeating last workout's category
      if (lastCompletedId != null) {
        final lastWorkout = _ref.read(workoutsProvider.notifier).getById(lastCompletedId);
        if (lastWorkout != null && lastWorkout.workoutCategory != workout.workoutCategory) {
          score += 15; // Different muscle group = higher priority
        }
      }
      
      // Boost challenge workouts if user has completed many normal ones
      if (workout.isChallenge && state.totalWorkoutsCompleted >= 5) {
        score += 20;
      }
      
      // Slight boost for workouts at user's current level
      final mostCompletedLevel = _getMostActiveLevel();
      if (workout.level == mostCompletedLevel) {
        score += 10;
      }
      
      return MapEntry(workout, score);
    }).toList();
    
    // Sort by score descending
    scored.sort((a, b) => b.value.compareTo(a.value));
    
    return scored.take(3).map((e) => e.key).toList();
  }
  
  /// Get the most recently completed workout ID
  String? _getLastCompletedWorkoutId() {
    if (state.completionCounts.isEmpty) return null;
    // This is a simplification - ideally we'd track order
    return state.completionCounts.entries.first.key;
  }
  
  /// Get the level where user has completed most workouts
  WorkoutLevel _getMostActiveLevel() {
    final beginner = state.completionCounts.entries
        .where((e) => e.key.startsWith('B'))
        .fold(0, (sum, e) => sum + e.value);
    final intermediate = state.completionCounts.entries
        .where((e) => e.key.startsWith('I'))
        .fold(0, (sum, e) => sum + e.value);
    final advanced = state.completionCounts.entries
        .where((e) => e.key.startsWith('A'))
        .fold(0, (sum, e) => sum + e.value);
    
    if (advanced >= intermediate && advanced >= beginner) {
      return WorkoutLevel.advanced;
    } else if (intermediate >= beginner) {
      return WorkoutLevel.intermediate;
    }
    return WorkoutLevel.beginner;
  }
}
