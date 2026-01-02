import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/scheduled_workout.dart';
import '../models/workout.dart';
import 'workouts_provider.dart';

final workoutCalendarProvider = StateNotifierProvider<WorkoutCalendarNotifier, List<ScheduledWorkout>>((ref) {
  return WorkoutCalendarNotifier(ref);
});

class WorkoutCalendarNotifier extends StateNotifier<List<ScheduledWorkout>> {
  final Ref _ref;
  int _idCounter = 0;

  WorkoutCalendarNotifier(this._ref) : super([]) {
    _loadScheduledWorkouts();
  }

  /// Load scheduled workouts from Hive
  void _loadScheduledWorkouts() {
    final box = Hive.box<ScheduledWorkout>('scheduled_workouts');
    state = box.values.toList();
    if (state.isNotEmpty) {
      // Find highest ID to continue counter
      final maxId = state
          .map((s) => int.tryParse(s.id.replaceAll('scheduled_', '')) ?? 0)
          .reduce((a, b) => a > b ? a : b);
      _idCounter = maxId + 1;
    }
  }

  /// Save scheduled workouts to Hive
  Future<void> _saveScheduledWorkouts() async {
    final box = Hive.box<ScheduledWorkout>('scheduled_workouts');
    await box.clear();
    for (final scheduled in state) {
      await box.add(scheduled);
    }
  }

  /// Schedule a workout for a specific date
  Future<void> scheduleWorkout(String workoutId, DateTime date) async {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    
    // Check if already scheduled for this day
    final existing = state.where((s) => 
      s.workoutId == workoutId &&
      s.scheduledDate.year == normalizedDate.year &&
      s.scheduledDate.month == normalizedDate.month &&
      s.scheduledDate.day == normalizedDate.day
    ).toList();
    
    if (existing.isNotEmpty) return; // Already scheduled

    final newSchedule = ScheduledWorkout(
      id: 'scheduled_${_idCounter++}',
      workoutId: workoutId,
      scheduledDate: normalizedDate,
    );

    state = [...state, newSchedule];
    await _saveScheduledWorkouts();
  }

  /// Remove a scheduled workout
  Future<void> removeScheduledWorkout(String scheduledId) async {
    state = state.where((s) => s.id != scheduledId).toList();
    await _saveScheduledWorkouts();
  }

  /// Mark a scheduled workout as complete
  Future<void> markComplete(String scheduledId) async {
    state = state.map((s) {
      if (s.id == scheduledId) {
        return s.copyWith(isCompleted: true, completedAt: DateTime.now());
      }
      return s;
    }).toList();
    await _saveScheduledWorkouts();
  }

  /// Get scheduled workouts for a specific date
  List<ScheduledWorkout> getForDate(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);
    return state.where((s) => 
      s.scheduledDate.year == normalized.year &&
      s.scheduledDate.month == normalized.month &&
      s.scheduledDate.day == normalized.day
    ).toList();
  }

  /// Get scheduled workouts for a week starting from date
  Map<DateTime, List<ScheduledWorkout>> getWeekSchedule(DateTime startDate) {
    final result = <DateTime, List<ScheduledWorkout>>{};
    
    for (int i = 0; i < 7; i++) {
      final day = DateTime(startDate.year, startDate.month, startDate.day + i);
      result[day] = getForDate(day);
    }
    
    return result;
  }

  /// Get today's scheduled workouts
  List<ScheduledWorkout> get todaysWorkouts {
    return getForDate(DateTime.now());
  }

  /// Get upcoming scheduled workouts (next 7 days)
  List<ScheduledWorkout> get upcomingWorkouts {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final nextWeek = today.add(const Duration(days: 7));
    
    return state.where((s) => 
      !s.isCompleted &&
      s.scheduledDate.isAfter(today.subtract(const Duration(days: 1))) &&
      s.scheduledDate.isBefore(nextWeek)
    ).toList()
      ..sort((a, b) => a.scheduledDate.compareTo(b.scheduledDate));
  }

  /// Get the Workout object for a scheduled workout
  Workout? getWorkoutForSchedule(ScheduledWorkout scheduled) {
    return _ref.read(workoutsProvider.notifier).getById(scheduled.workoutId);
  }
}
