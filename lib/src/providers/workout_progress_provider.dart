import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';
import '../models/workout.dart';
import '../models/workout_progress.dart';
import '../database/app_database.dart';
import 'workouts_provider.dart';
import '../../main.dart';

class WorkoutProgressNotifier extends Notifier<WorkoutProgress> {
  @override
  WorkoutProgress build() {
    _loadProgress();
    return const WorkoutProgress(
      unlockedWorkoutIds: ['B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'KF1', 'KF2', 'KF3'],
      completionCounts: {},
    );
  }

  Future<void> _loadProgress() async {
    try {
      final db = ref.read(appDatabaseProvider);
      final sessions = await db.select(db.workoutSessionsTable).get();
      
      // Calculate completion counts
      final Map<String, int> completionCounts = {};
      for (final session in sessions) {
        completionCounts[session.workoutId] = (completionCounts[session.workoutId] ?? 0) + 1;
      }
      
      // Calculate total
      final totalCompleted = sessions.length;
      
      // Determine unlocked workouts (all starter workouts + those earned through completion)
      final unlocked = [
        'B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', // Beginner workouts
        'KF1', 'KF2', 'KF3', // Kickstart Fat Loss
      ];
      
      // Unlock advanced workouts based on total completion count
      if (totalCompleted >= 5) unlocked.add(' BBG1');
      if (totalCompleted >= 10) unlocked.addAll(['BBG2', 'AG1']);
      if (totalCompleted >= 20) unlocked.addAll(['BBG3', 'AG2', 'FS1']);
      if (totalCompleted >= 30) unlocked.addAll(['AG3', 'FS2']);
      
      state = WorkoutProgress(
        completionCounts: completionCounts,
        unlockedWorkoutIds: unlocked,
        lastWorkoutDate: sessions.isNotEmpty ? sessions.first.completedAt : null,
        totalWorkoutsCompleted: totalCompleted,
      );
    } catch (e) {
      print("Error loading workout progress: $e");
    }
  }

  Future<void> _saveProgress() async {
    // Progress is derived from workout sessions, no separate save needed
  }

  Future<List<String>> completeWorkout(String workoutId, {int? durationMinutes, String? notes}) async {
    try {
      final db = ref.read(appDatabaseProvider);
      
      // Insert workout session
      await db.into(db.workoutSessionsTable).insert(
        WorkoutSessionsTableCompanion.insert(
          id: const Uuid().v4(),
          userId: 'current_user', // TODO: Get from user provider
          workoutId: workoutId,
          completedAt: DateTime.now(),
          durationMinutes: drift.Value(durationMinutes),
          notes: drift.Value(notes),
        ),
      );
      
      // Reload progress to recalculate
      await _loadProgress();
      
      // Return newly unlocked IDs (compare before/after)
      return []; // TODO: Track previous state to detect new unlocks
    } catch (e) {
      print("Error completing workout: $e");
      return [];
    }
  }

  bool isUnlocked(String workoutId) {
    return state.isUnlocked(workoutId);
  }

  int getCompletionCount(String workoutId) {
    return state.getCompletionCount(workoutId);
  }

  List<Workout> getRecommendedWorkouts() {
    final allWorkouts = ref.read(workoutsProvider);
    return allWorkouts.where((w) => state.isUnlocked(w.id)).take(3).toList();
  }

  double getUnlockProgress(Workout workout) {
    if (isUnlocked(workout.id)) return 1.0;
    return (state.totalWorkoutsCompleted / workout.unlockRequirement).clamp(0.0, 1.0);
  }

  String getUnlockText(Workout workout) {
    if (isUnlocked(workout.id)) return 'Unlocked';
    final remaining = workout.unlockRequirement - state.totalWorkoutsCompleted;
    return 'Complete $remaining more workout${remaining == 1 ? '' : 's'} to unlock';
  }
}

final workoutProgressProvider = NotifierProvider<WorkoutProgressNotifier, WorkoutProgress>(() {
  return WorkoutProgressNotifier();
});
