import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/habit_check_in.dart';
import '../../utils/constants.dart';

final trackingProvider = StateNotifierProvider<TrackingNotifier, List<HabitCheckIn>>((ref) {
  return TrackingNotifier();
});

class TrackingNotifier extends StateNotifier<List<HabitCheckIn>> {
  TrackingNotifier() : super([]) {
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

    // Sort to be safe (should already be sorted)
    final sortedEntries = [...state]..sort((a, b) => b.date.compareTo(a.date));

    for (var entry in sortedEntries) {
      DateTime entryDate = DateTime(entry.date.year, entry.date.month, entry.date.day);
      
      if (entryDate.isAtSameMomentAs(checkDate)) {
        streak++;
        checkDate = checkDate.subtract(const Duration(days: 1));
      } else if (entryDate.isBefore(checkDate)) {
        // Gap in streak
        break;
      }
    }

    return streak;
  }
}
