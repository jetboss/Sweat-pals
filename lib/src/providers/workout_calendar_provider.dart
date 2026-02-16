import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';
import '../models/scheduled_workout.dart';
import '../models/workout.dart';
import '../database/app_database.dart';
import 'workouts_provider.dart';
import '../../main.dart';

class WorkoutCalendarNotifier extends Notifier<List<ScheduledWorkout>> {
  @override
  List<ScheduledWorkout> build() {
    _loadScheduledWorkouts();
    return [];
  }

  Future<void> _loadScheduledWorkouts() async {
    try {
      final db = ref.read(appDatabaseProvider);
      final results = await db.select(db.scheduledWorkoutsTable).get();
      
      state = results.map((row) => ScheduledWorkout(
        id: row.id,
        workoutId: row.workoutId,
        scheduledDate: row.scheduledDate,
        isCompleted: row.isCompleted,
        completedAt: row.completedAt,
      )).toList();
    } catch (e) {
      print("Error loading scheduled workouts: $e");
    }
  }

  Future<void> _saveScheduledWorkouts() async {
    // Save handled by individual operations
  }

  Future<void> scheduleWorkout(String workoutId, DateTime date) async{
    try {
      final normalizedDate = DateTime(date.year, date.month, date.day);
      final db = ref.read(appDatabaseProvider);
      
      final id = const Uuid().v4();
      await db.into(db.scheduledWorkoutsTable).insert(
        ScheduledWorkoutsTableCompanion.insert(
          id: id,
          userId: 'current_user', // TODO: Get from user provider
          workoutId: workoutId,
          scheduledDate: normalizedDate,
        ),
      );
      
      final newSchedule = ScheduledWorkout(
        id: id,
        workoutId: workoutId,
        scheduledDate: normalizedDate,
      );
      
      state = [...state, newSchedule];
    } catch (e) {
      print("Error scheduling workout: $e");
    }
  }

  Future<void> removeScheduledWorkout(String scheduledId) async {
    try {
      final db = ref.read(appDatabaseProvider);
      await (db.delete(db.scheduledWorkoutsTable)..where((t) => t.id.equals(scheduledId))).go();
      state = state.where((s) => s.id != scheduledId).toList();
    } catch (e) {
      print("Error removing scheduled workout: $e");
    }
  }

  Future<void> markComplete(String scheduledId) async {
    try {
      final db = ref.read(appDatabaseProvider);
      await (db.update(db.scheduledWorkoutsTable)..where((t) => t.id.equals(scheduledId)))
        .write(ScheduledWorkoutsTableCompanion(
          isCompleted: const drift.Value(true),
          completedAt: drift.Value(DateTime.now()),
        ));
      
      state = state.map((s) {
        if (s.id == scheduledId) {
          return s.copyWith(isCompleted: true, completedAt: DateTime.now());
        }
        return s;
      }).toList();
    } catch (e) {
      print("Error marking workout complete: $e");
    }
  }

  List<ScheduledWorkout> getForDate(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);
    return state.where((ScheduledWorkout s) => 
      s.scheduledDate.year == normalized.year &&
      s.scheduledDate.month == normalized.month &&
      s.scheduledDate.day == normalized.day
    ).toList();
  }

  List<ScheduledWorkout> get todaysWorkouts {
    return getForDate(DateTime.now());
  }

  Map<DateTime, List<ScheduledWorkout>> getWeekSchedule(DateTime startDate) {
    final result = <DateTime, List<ScheduledWorkout>>{};
    for (int i = 0; i < 7; i++) {
      final day = DateTime(startDate.year, startDate.month, startDate.day + i);
      result[day] = getForDate(day);
    }
    return result;
  }

  Workout? getWorkoutForSchedule(ScheduledWorkout schedule) {
    final workouts = ref.read(workoutsProvider);
    try {
      return workouts.firstWhere((w) => w.id == schedule.workoutId);
    } catch (e) {
      return null;
    }
  }
}

final workoutCalendarProvider = NotifierProvider<WorkoutCalendarNotifier, List<ScheduledWorkout>>(() {
  return WorkoutCalendarNotifier();
});
