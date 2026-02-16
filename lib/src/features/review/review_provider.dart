import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../database/app_database.dart';
import '../../models/weekly_review.dart' as models;
import '../../../main.dart';

class ReviewNotifier extends Notifier<List<models.WeeklyReview>> {
  @override
  List<models.WeeklyReview> build() {
    _loadReviews();
    return [];
  }

  Future<void> _loadReviews() async {
    try {
      final db = ref.read(appDatabaseProvider);
      final results = await (db.select(db.weeklyReviewsTable)
        ..orderBy([(t) => drift.OrderingTerm.desc(t.date)])).get();
      
      state = results.map((row) => models.WeeklyReview(
        id: row.id,
        date: row.date,
        weight: row.weight,
        waist: row.waist,
        consistencyScore: row.consistencyScore,
        notes: row.notes,
      )).toList();
    } catch (e) {
      print("Error loading reviews: $e");
    }
  }

  Future<void> addReview(models.WeeklyReview review) async {
    try {
      final db = ref.read(appDatabaseProvider);
      await db.into(db.weeklyReviewsTable).insert(
        WeeklyReviewsTableCompanion.insert(
          id: review.id,
          userId: 'current_user', // TODO: Get from user provider
          date: review.date,
          weight: review.weight,
          waist: review.waist,
          consistencyScore: review.consistencyScore,
          notes: drift.Value(review.notes),
        ),
      );
      state = [review, ...state];
    } catch (e) {
      print("Error adding review: $e");
    }
  }

  // Alias for addEntry to match weekly_review_form usage  
  Future<void> addEntry(models.WeeklyReview review) => addReview(review);

  // Generate a suggestion based on review data
  String getSuggestion(models.WeeklyReview review) {
    if (review.consistencyScore >= 8) {
      return "You're crushing it! 🔥 Keep up the amazing work!";
    } else if (review.consistencyScore >= 5) {
      return "Good job this week! Let's aim for even more consistency next week! 💪";
    } else {
      return "Every week is a fresh start! Let's get back on track together! 🚀";
    }
  }
}

final reviewProvider = NotifierProvider<ReviewNotifier, List<models.WeeklyReview>>(() {
  return ReviewNotifier();
});
