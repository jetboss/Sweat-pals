import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'src/app.dart';
import 'src/models/user_profile.dart';
import 'src/models/workout.dart';
import 'src/models/workout_progress.dart';
import 'src/models/scheduled_workout.dart';
import 'src/models/workout_entry.dart';
import 'src/models/weight_entry.dart';
import 'src/models/journal_entry.dart';
import 'src/models/habit_check_in.dart';
import 'src/models/morning_prompt.dart';
import 'src/models/weekly_review.dart';
import 'src/models/progress_photo.dart';
import 'src/utils/constants.dart';

import 'src/services/notifications_service.dart';
import 'src/models/pending_action.dart';
import 'src/services/sync_queue_service.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    debugPrint('Sweat Pals starting up...');

    // Initialize Supabase
    await Supabase.initialize(
      url: 'https://ymvnavmvipzpuynlqode.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inltdm5hdm12aXB6cHV5bmxxb2RlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjczNzg3NzksImV4cCI6MjA4Mjk1NDc3OX0.QoF6_H_hjZnFLQvNVnE9nYqNsIM3gf5QrNUbFQrbfgE',
    );
    debugPrint('Supabase initialized.');

    // Initialize Notifications
    await NotificationsService.init();
    debugPrint('Notifications initialized.');
    
    // Initialize Hive
    await Hive.initFlutter();
    debugPrint('Hive initialized.');
    
    // Register Adapters
    _registerAdapters();
    
    // Open Boxes
    await _openBoxes();
    debugPrint('Hive boxes opened.');

    // Initialize Sync Queue
    final syncQueue = SyncQueueService();
    await syncQueue.init();
    debugPrint('Sync Queue initialized.');
    
    runApp(
      ProviderScope(
        child: const MyApp(),
      ),
    );
  } catch (e, stack) {
    debugPrint('FATAL ERROR DURING STARTUP: $e');
    debugPrint(stack.toString());
    runApp(MaterialApp(home: Scaffold(body: Center(child: Text('Pal, we had a major snag! Check logs: $e')))));
  }
}

void _registerAdapters() {
  Hive.registerAdapter(UserProfileAdapter());
  // Hive.registerAdapter(DailyPlanAdapter()); // REMOVED
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(WorkoutSessionAdapter());
  Hive.registerAdapter(WorkoutLevelAdapter());
  Hive.registerAdapter(EquipmentAdapter());
  Hive.registerAdapter(WorkoutCategoryAdapter());
  Hive.registerAdapter(WorkoutProgressAdapter());
  Hive.registerAdapter(ScheduledWorkoutAdapter());
  // Hive.registerAdapter(MealEntryAdapter()); // REMOVED
  Hive.registerAdapter(WorkoutEntryAdapter());
  Hive.registerAdapter(WeightEntryAdapter());
  Hive.registerAdapter(JournalEntryAdapter());
  Hive.registerAdapter(HabitCheckInAdapter());
  Hive.registerAdapter(MorningPromptAdapter());
  Hive.registerAdapter(WeeklyReviewAdapter());
  Hive.registerAdapter(ProgressPhotoAdapter());
  Hive.registerAdapter(PendingActionAdapter());
  // Hive.registerAdapter(AchievementAdapter()); // REMOVED
  // Hive.registerAdapter(AchievementCategoryAdapter()); // REMOVED
}

Future<void> _openBoxes() async {
    // Open Boxes
    await Hive.openBox<UserProfile>(AppConstants.userBox);
    await Hive.openBox<WorkoutSession>('workout_sessions');
    await Hive.openBox<WorkoutProgress>('workout_progress');
    await Hive.openBox<ScheduledWorkout>('scheduled_workouts');
    await Hive.openBox<WorkoutEntry>(AppConstants.workoutsBox);
    await Hive.openBox<WeightEntry>(AppConstants.trackingBox);
    await Hive.openBox<JournalEntry>(AppConstants.journalBox);
    await Hive.openBox<HabitCheckIn>(AppConstants.habitTrackingBox);
    await Hive.openBox<MorningPrompt>(AppConstants.morningPromptBox);
    await Hive.openBox<WeeklyReview>(AppConstants.weeklyReviewBox);
    await Hive.openBox<ProgressPhoto>(AppConstants.progressPhotosBox);
    await Hive.openBox<Workout>('custom_workouts');

}
