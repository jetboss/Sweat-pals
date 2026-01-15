import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/habit_check_in.dart';
import '../../models/user_profile.dart';
import '../../providers/user_provider.dart';
import '../../utils/constants.dart';

final trackingProvider = StateNotifierProvider<TrackingNotifier, List<HabitCheckIn>>((ref) {
  return TrackingNotifier(ref);
});

class TrackingNotifier extends StateNotifier<List<HabitCheckIn>> {
  final Ref ref;

  TrackingNotifier(this.ref) : super([]) {
    _loadEntries();
  }

  late Box<HabitCheckIn> _box;

  void _loadEntries() {
    try {
      _box = Hive.box<HabitCheckIn>(AppConstants.habitTrackingBox);
      state = _box.values.toList()..sort((a, b) => b.date.compareTo(a.date));
    } catch (e) {
      debugPrint('Error loading tracking entries: $e');
      state = [];
    }
  }

  Future<void> addEntry(HabitCheckIn entry) async {
    try {
      await _box.put(entry.id, entry);
      state = [entry, ...state]..sort((a, b) => b.date.compareTo(a.date));
    } catch (e) {
      debugPrint('Error adding tracking entry: $e');
    }
  }

  int calculateStreak() {
    if (state.isEmpty) return 0;

    int streak = 0;
    DateTime today = DateTime.now();
    DateTime checkDate = DateTime(today.year, today.month, today.day);

    final sortedEntries = [...state]..sort((a, b) => b.date.compareTo(a.date));

    for (var entry in sortedEntries) {
      DateTime entryDate = DateTime(entry.date.year, entry.date.month, entry.date.day);
      
      if (entryDate.isAtSameMomentAs(checkDate)) {
        if (entry.exerciseCompleted || entry.isFrozen) {
           streak++;
           checkDate = checkDate.subtract(const Duration(days: 1));
        } else {
           // Entry exists but not completed/frozen -> Streak broken if it's not today (today doesn't break streak yet)
           if (!entryDate.isAtSameMomentAs(DateTime(today.year, today.month, today.day))) {
              break;
           }
        }
      } else if (entryDate.isBefore(checkDate)) {
        // Gap in streak
        break;
      }
    }
    return streak;
  }

  Future<bool> freezeToday() async {
    final user = ref.read(userProvider);
    if (user == null || (user.restTokens ?? 0) <= 0) return false;

    // Check if check-in already exists
    final today = DateTime.now();
    final todayCheckIn = state.firstWhere(
      (e) => isSameDay(e.date, today),
      orElse: () => HabitCheckIn(
        id: DateTime.now().toIso8601String(),
        date: today,
        followedMealPlan: false,
        mealPlanNotes: '',
        sleepHours: 0,
        drankWater: false,
        mood: 3,
        exerciseCompleted: false,
      ),
    );

    // If already completed exercise, no need to freeze
    if (todayCheckIn.exerciseCompleted) return false;

    // Utilize token
    final updatedProfile = UserProfile(
      name: user.name,
      startingWeight: user.startingWeight,
      targetWeight: user.targetWeight,
      height: user.height,
      age: user.age,
      sex: user.sex,
      foodsToAvoid: user.foodsToAvoid,
      startDate: user.startDate,
      preferredWorkoutHour: user.preferredWorkoutHour,
      fitnessLevel: user.fitnessLevel,
      bio: user.bio,
      restTokens: (user.restTokens ?? 3) - 1,
    );
    await ref.read(userProvider.notifier).saveProfile(updatedProfile);

    // Create/Update Check-in as Frozen
    final frozenCheckIn = HabitCheckIn(
      id: todayCheckIn.id,
      date: today,
      followedMealPlan: todayCheckIn.followedMealPlan,
      mealPlanNotes: todayCheckIn.mealPlanNotes,
      sleepHours: todayCheckIn.sleepHours,
      drankWater: todayCheckIn.drankWater,
      mood: todayCheckIn.mood,
      exerciseCompleted: false,
      isFrozen: true,
    );

    await addEntry(frozenCheckIn);
    return true;
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
