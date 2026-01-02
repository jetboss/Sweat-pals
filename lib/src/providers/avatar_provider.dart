import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/workout_progress.dart';
import 'workout_progress_provider.dart';

enum AvatarMood { neutral, happy, energetic, tired }

class AvatarState {
  final AvatarMood mood;
  final int level;
  final Color primaryColor;

  const AvatarState({
    this.mood = AvatarMood.neutral,
    this.level = 1,
    this.primaryColor = Colors.blueAccent, // Default, will change based on level
  });

  AvatarState copyWith({
    AvatarMood? mood,
    int? level,
    Color? primaryColor,
  }) {
    return AvatarState(
      mood: mood ?? this.mood,
      level: level ?? this.level,
      primaryColor: primaryColor ?? this.primaryColor,
    );
  }
}

final avatarProvider = StateNotifierProvider<AvatarNotifier, AvatarState>((ref) {
  final progress = ref.watch(workoutProgressProvider);
  return AvatarNotifier(progress);
});

class AvatarNotifier extends StateNotifier<AvatarState> {
  final WorkoutProgress progress;

  AvatarNotifier(this.progress) : super(const AvatarState()) {
    _updateState();
  }

  void _updateState() {
    // 1. Determine Level based on Total Workouts (or Streak)
    // Level 1: 0-5 workouts
    // Level 2: 6-15 workouts
    // Level 3: 16+ workouts
    int newLevel = 1;
    if (progress.totalWorkoutsCompleted > 15) {
      newLevel = 3;
    } else if (progress.totalWorkoutsCompleted > 5) {
      newLevel = 2;
    }

    // 2. Determine Color Theme based on Level
    Color newColor = const Color(0xFF64B5F6); // Blue 300 (Level 1)
    if (newLevel == 2) {
      newColor = const Color(0xFFFFB74D); // Orange 300 (Level 2)
    } else if (newLevel == 3) {
      newColor = const Color(0xFFE57373); // Red 300 (Level 3 - "Fire")
    }

    // 3. Determine Mood based on recent activity
    AvatarMood newMood = AvatarMood.neutral;
    
    // Check if worked out today
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (progress.lastWorkoutDate != null) {
      final last = progress.lastWorkoutDate!;
      final lastDate = DateTime(last.year, last.month, last.day);
      
      if (lastDate.isAtSameMomentAs(today)) {
        newMood = AvatarMood.happy; 
        if (progress.currentStreak > 3) {
          newMood = AvatarMood.energetic; // On a streak!
        }
      }
    }

    state = state.copyWith(
      level: newLevel,
      primaryColor: newColor,
      mood: newMood,
    );
  }
}
