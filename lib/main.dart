import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'src/app.dart';
import 'src/models/user_profile.dart';
import 'src/models/meal_plan.dart';
import 'src/models/workout.dart';
import 'src/models/workout_progress.dart';
import 'src/models/scheduled_workout.dart';
import 'src/models/meal_entry.dart';
import 'src/models/workout_entry.dart';
import 'src/models/weight_entry.dart';
import 'src/models/journal_entry.dart';
import 'src/models/habit_check_in.dart';
import 'src/models/morning_prompt.dart';
import 'src/models/weekly_review.dart';
import 'src/models/progress_photo.dart';
import 'src/models/achievement.dart';
import 'src/utils/constants.dart';

import 'src/services/notifications_service.dart';
import 'src/providers/achievements_provider.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    debugPrint('Sweat Pals starting up...');

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
    
    runApp(
      ProviderScope(
        overrides: [
          achievementsBoxProvider.overrideWithValue(Hive.box<Achievement>('achievements')),
        ],
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
  Hive.registerAdapter(MealAdapter());
  Hive.registerAdapter(DailyPlanAdapter());
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(WorkoutSessionAdapter());
  Hive.registerAdapter(WorkoutLevelAdapter());
  Hive.registerAdapter(EquipmentAdapter());
  Hive.registerAdapter(WorkoutCategoryAdapter());
  Hive.registerAdapter(WorkoutProgressAdapter());
  Hive.registerAdapter(ScheduledWorkoutAdapter());
  Hive.registerAdapter(MealEntryAdapter());
  Hive.registerAdapter(WorkoutEntryAdapter());
  Hive.registerAdapter(WeightEntryAdapter());
  Hive.registerAdapter(JournalEntryAdapter());
  Hive.registerAdapter(HabitCheckInAdapter());
  Hive.registerAdapter(MorningPromptAdapter());
  Hive.registerAdapter(WeeklyReviewAdapter());
  Hive.registerAdapter(ProgressPhotoAdapter());
  Hive.registerAdapter(AchievementAdapter());
  Hive.registerAdapter(AchievementCategoryAdapter());
}

Future<void> _openBoxes() async {
  await Hive.openBox<UserProfile>(AppConstants.userBox);
  await Hive.openBox<DailyPlan>('meal_plans');
  await Hive.openBox<WorkoutSession>('workout_sessions');
  await Hive.openBox<WorkoutProgress>('workout_progress');
  await Hive.openBox<ScheduledWorkout>('scheduled_workouts');
  await Hive.openBox<MealEntry>(AppConstants.mealsBox);
  await Hive.openBox<WorkoutEntry>(AppConstants.workoutsBox);
  await Hive.openBox<WeightEntry>(AppConstants.trackingBox);
  await Hive.openBox<JournalEntry>(AppConstants.journalBox);
  await Hive.openBox<HabitCheckIn>(AppConstants.habitTrackingBox);
  await Hive.openBox<MorningPrompt>(AppConstants.morningPromptBox);
  await Hive.openBox<WeeklyReview>(AppConstants.weeklyReviewBox);
  await Hive.openBox<ProgressPhoto>(AppConstants.progressPhotosBox);
  await Hive.openBox<Workout>('custom_workouts');
  await Hive.openBox<Achievement>('achievements');
}
