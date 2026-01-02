import 'package:flutter_test/flutter_test.dart';
import 'package:sweat_pals/src/models/workout.dart';
import 'package:sweat_pals/src/providers/avatar_provider.dart';
import 'package:sweat_pals/src/models/workout_progress.dart';
import 'package:flutter/material.dart';

void main() {
  group('Workout.isCustom Tests', () {
    test('Built-in workout ID should not be custom', () {
      const workout = Workout(
        id: 'B1',
        title: 'Built-in',
        description: 'Desc',
        exercises: [],
        category: 'Full Body',
      );
      expect(workout.isCustom, isFalse);
    });

    test('UUID-style workout ID should be custom', () {
      const workout = Workout(
        id: '550e8400-e29b-41d4-a716-446655440000',
        title: 'Custom',
        description: 'Desc',
        exercises: [],
        category: 'Full Body',
      );
      expect(workout.isCustom, isTrue);
    });
  });

  group('AvatarNotifier Tests', () {
    test('Initial state is Level 1 Neutral', () {
      final progress = const WorkoutProgress();
      final notifier = AvatarNotifier(progress);
      
      expect(notifier.state.level, 1);
      expect(notifier.state.mood, AvatarMood.neutral);
      expect(notifier.state.primaryColor, const Color(0xFF64B5F6));
    });

    test('Level upgrades based on total workouts', () {
      // Level 2: 6+ workouts
      final progressL2 = const WorkoutProgress(totalWorkoutsCompleted: 6);
      final notifierL2 = AvatarNotifier(progressL2);
      expect(notifierL2.state.level, 2);
      expect(notifierL2.state.primaryColor, const Color(0xFFFFB74D));

      // Level 3: 16+ workouts
      final progressL3 = const WorkoutProgress(totalWorkoutsCompleted: 16);
      final notifierL3 = AvatarNotifier(progressL3);
      expect(notifierL3.state.level, 3);
      expect(notifierL3.state.primaryColor, const Color(0xFFE57373));
    });

    test('Mood becomes Happy if worked out today', () {
      final now = DateTime.now();
      final progress = WorkoutProgress(
        lastWorkoutDate: now,
        totalWorkoutsCompleted: 1,
      );
      final notifier = AvatarNotifier(progress);
      expect(notifier.state.mood, AvatarMood.happy);
    });

    test('Mood becomes Energetic on high streak', () {
      final now = DateTime.now();
      final progress = WorkoutProgress(
        lastWorkoutDate: now,
        currentStreak: 4,
        totalWorkoutsCompleted: 4,
      );
      final notifier = AvatarNotifier(progress);
      expect(notifier.state.mood, AvatarMood.energetic);
    });
  });
}
