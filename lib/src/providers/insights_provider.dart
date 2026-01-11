import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'user_provider.dart';
import '../features/tracking/tracking_provider.dart';

// Simple model for an insight
class DailyInsight {
  final String text;
  final String emoji;
  final String type; // 'motivation', 'streak', 'workout', 'time'

  DailyInsight(this.text, this.emoji, this.type);
}

final insightsProvider = Provider<DailyInsight>((ref) {
  final user = ref.watch(userProvider);
  final streak = ref.watch(trackingProvider.notifier).calculateStreak();
  final now = DateTime.now();
  final hour = now.hour;
  
  // 1. Time-based greeting / nudges
  if (hour < 9) {
    return DailyInsight(
      'Rise and grind, ${user?.name ?? "Pal"}! Early workouts burn more fat.',
      '🌅',
      'time',
    );
  } else if (hour > 20) {
    return DailyInsight(
      'Rest and recover, ${user?.name ?? "Pal"}. Quality sleep = gains.',
      '🌙',
      'time',
    );
  }

  // 2. Streak celebrations
  if (streak > 0 && streak % 5 == 0) {
    return DailyInsight(
      'Wow! $streak days in a row! You are unstoppable! 🔥',
      '🚀',
      'streak',
    );
  }

  // 3. Random motivation if no specific triggers
  final motivations = [
    DailyInsight('Consistency over intensity. Just show up!', '💧', 'motivation'),
    DailyInsight('The only bad workout is the one that didn’t happen.', '💪', 'motivation'),
    DailyInsight('Your future self will thank you.', '🔮', 'motivation'),
    DailyInsight('Small steps every day add up to big results.', '📈', 'motivation'),
    DailyInsight('Don\'t stop when you\'re tired. Stop when you\'re done.', '😤', 'motivation'),
    DailyInsight('Sweat is just your fat crying.', '💦', 'motivation'),
  ];

  return motivations[Random().nextInt(motivations.length)];
});
