import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../models/daily_check_in.dart' as models;
import '../../database/app_database.dart';
import '../../../main.dart';

class TrackingNotifier extends Notifier<List<models.DailyCheckIn>> {
  @override
  List<models.DailyCheckIn> build() {
    _loadEntries();
    return [];
  }

  Future<void> _loadEntries() async {
    try {
      final db = ref.read(appDatabaseProvider);
      final results = await (db.select(db.dailyCheckInsTable)
        ..orderBy([(t) => drift.OrderingTerm.desc(t.date)])).get();
      
      state = results.map((row) => models.DailyCheckIn(
        id: row.id,
        date: row.date,
        moodScore: row.moodGood ? 8 : 5,
        energyLevel: row.energyLevel,
        sleepHours: 7.0,
        waterIntake: 8,
        weight: row.weight,
        exerciseCompleted: false,
        followedMealPlan: false,
        mealPlanNotes: row.notes ?? '',
      )).toList();
    } catch (e) {
      debugPrint("Error loading tracking entries: $e");
    }
  }

  Future<void> addEntry(models.DailyCheckIn entry) async {
    try {
      final db = ref.read(appDatabaseProvider);
      await db.into(db.dailyCheckInsTable).insert(
        DailyCheckInsTableCompanion.insert(
          id: entry.id,
          date: entry.date,
          moodGood: drift.Value(entry.moodScore >= 7),
          energyLevel: drift.Value(entry.energyLevel),
          weight: drift.Value(entry.weight),
          notes: drift.Value(entry.mealPlanNotes),
        ),
        mode: drift.InsertMode.insertOrReplace,
      );
      state = [entry, ...state];
    } catch (e) {
      debugPrint("Error adding tracking entry: $e");
    }
  }

  int calculateStreak() {
    if (state.isEmpty) return 0;
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    int streak = 0;
    
    for (int i = 0; i < state.length; i++) {
      final entryDate = state[i].date;
      final normalizedEntry = DateTime(entryDate.year, entryDate.month, entryDate.day);
      final expectedDate = today.subtract(Duration(days: streak));
      
      if (normalizedEntry.isAtSameMomentAs(expectedDate)) {
        streak++;
      } else {
        break;
      }
    }
    
    return streak;
  }

  Future<void> _syncStreakToProfile() async {
    final streak = calculateStreak();
    // Update user profile - handled by user provider
    debugPrint("Current streak: $streak");
  }

  Future<void> freezeToday() async {
    // Freeze day logic - create a placeholder entry for today
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    final freezeEntry = models.DailyCheckIn(
      id: 'freeze_${now.millisecondsSinceEpoch}',
      date: today,
      moodScore: 5,
      energyLevel: 5,
      sleepHours: 7.0,
      waterIntake: 8,
      weight: null,
      exerciseCompleted: true, // Mark as completed to maintain streak
      followedMealPlan: true,
      mealPlanNotes: 'Freeze day',
    );
    
    await addEntry(freezeEntry);
  }
}

final trackingProvider = NotifierProvider<TrackingNotifier, List<models.DailyCheckIn>>(() {
  return TrackingNotifier();
});
