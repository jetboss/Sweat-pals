import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';
import '../models/daily_check_in.dart' as models;
import '../services/database_service.dart';
import '../database/app_database.dart';
import '../../main.dart';

class DailyCheckInState {
  final models.DailyCheckIn? todayEntry;
  final bool isTodayDone;
  final bool isLoading;

  DailyCheckInState({
    this.todayEntry,
    this.isTodayDone = false,
    this.isLoading = false,
  });
}

class DailyCheckInNotifier extends Notifier<DailyCheckInState> {
  @override
  DailyCheckInState build() {
    _loadToday();
    return DailyCheckInState(isLoading: true);
  }

  Future<void> _loadToday() async {
    try {
      final db = ref.read(appDatabaseProvider);
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      
      final entry = await (db.select(db.dailyCheckInsTable)
        ..where((t) => t.date.equals(startOfDay))).getSingleOrNull();
      
      if (entry != null) {
        state = DailyCheckInState(
          todayEntry: models.DailyCheckIn(
            id: entry.id,
            date: entry.date,
            followedMealPlan: true, // Placeholder
            mealPlanNotes: entry.notes ?? '',
            sleepHours: 7.0, // Placeholder
            waterIntake: 8, // Placeholder
            moodScore: entry.moodGood ? 5 : 3, // mapped
            exerciseCompleted: false, // placeholder
            energyLevel: entry.energyLevel,
            weight: entry.weight,
          ),
          isTodayDone: true,
          isLoading: false,
        );
      } else {
        state = DailyCheckInState(isLoading: false, isTodayDone: false);
      }
    } catch (e) {
      debugPrint("Error loading today's checkin: $e");
      state = DailyCheckInState(isLoading: false, isTodayDone: false);
    }
  }

  Future<void> submitCheckIn({
    required int moodScore,
    required int energyLevel,
    required double sleepHours,
    required int waterIntake,
    double? weight,
    String? notes,
  }) async {
    state = DailyCheckInState(isLoading: true);
    
    try {
      final db = ref.read(appDatabaseProvider);
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final id = const Uuid().v4();

      final entry = models.DailyCheckIn(
        id: id,
        date: startOfDay,
        moodScore: moodScore,
        energyLevel: energyLevel,
        sleepHours: sleepHours,
        waterIntake: waterIntake,
        weight: weight,
        mealPlanNotes: notes ?? '',
        followedMealPlan: true,
        exerciseCompleted: false,
      );

      // Save locally
      await db.into(db.dailyCheckInsTable).insertOnConflictUpdate(
        DailyCheckInsTableCompanion.insert(
          id: id,
          date: startOfDay,
          moodGood: drift.Value(moodScore >= 4),
          energyLevel: drift.Value(energyLevel),
          weight: drift.Value(weight),
          notes: drift.Value(notes),
        ),
      );

      // Sync to Supabase
      final dbService = ref.read(databaseServiceProvider);
      await dbService.syncDailyCheckIn({
        'date': startOfDay.toIso8601String(),
        'mood_score': moodScore,
        'energy_level': energyLevel,
        'sleep_hours': sleepHours,
        'water_intake': waterIntake,
        'weight': weight,
        'notes': notes,
      });

      state = DailyCheckInState(
        todayEntry: entry,
        isTodayDone: true,
        isLoading: false,
      );
    } catch (e) {
      debugPrint("Error submitting checkin: $e");
      state = DailyCheckInState(isLoading: false, isTodayDone: false);
      rethrow;
    }
  }
}

final dailyCheckInProvider = NotifierProvider<DailyCheckInNotifier, DailyCheckInState>(() {
  return DailyCheckInNotifier();
});
