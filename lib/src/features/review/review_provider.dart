import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/weekly_review.dart';
import '../../utils/constants.dart';

final reviewProvider = StateNotifierProvider<ReviewNotifier, List<WeeklyReview>>((ref) {
  return ReviewNotifier();
});

class ReviewNotifier extends StateNotifier<List<WeeklyReview>> {
  ReviewNotifier() : super([]) {
    _loadEntries();
  }

  late Box<WeeklyReview> _box;

  void _loadEntries() {
    try {
      _box = Hive.box<WeeklyReview>(AppConstants.weeklyReviewBox);
      state = _box.values.toList()..sort((a, b) => b.date.compareTo(a.date));
    } catch (e) {
      debugPrint('Error loading weekly reviews: $e');
      state = [];
    }
  }

  Future<void> addEntry(WeeklyReview entry) async {
    try {
      await _box.put(entry.id, entry);
      state = [entry, ...state]..sort((a, b) => b.date.compareTo(a.date));
    } catch (e) {
      debugPrint('Error adding weekly review: $e');
    }
  }

  String getSuggestion(WeeklyReview current) {
    if (state.length < 2) return "Great start! Keep tracking to see trends.";

    final previous = state[1]; // Since it's sorted b.date.compareTo(a.date)
    final weightDiff = current.weight - previous.weight;
    
    if (current.consistencyScore < 7) {
      return "Focus on consistency this week, pal. Small wins add up!";
    }

    if (weightDiff > 0.5) {
      return "Weight is up slightly. Let's tighten up the meal plan portion sizes.";
    } else if (weightDiff < -1.0) {
      return "Fast progress! Make sure you're eating enough protein, pal.";
    } else if (weightDiff <= 0 && weightDiff >= -0.5) {
      return "Steady progress. Let's add 15 mins of walking to boost results!";
    } else {
      return "You're on the right track! Keep doing what you're doing.";
    }
  }
}
