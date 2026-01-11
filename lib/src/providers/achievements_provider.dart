import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/achievement.dart';

part 'achievements_provider.g.dart';

final achievementsBoxProvider = Provider<Box<Achievement>>((ref) {
  throw UnimplementedError('achievementsBox must be overridden');
});

@riverpod
class AchievementsNotifier extends _$AchievementsNotifier {
  @override
  List<Achievement> build() {
    final box = ref.watch(achievementsBoxProvider);
    if (box.isEmpty) {
      _seedDefaultAchievements(box);
    }
    return box.values.toList();
  }

  Future<void> _seedDefaultAchievements(Box<Achievement> box) async {
    final defaults = [
      const Achievement(
        id: 'first_workout',
        title: 'First Steps',
        description: 'Complete your first workout',
        iconCodePoint: 0xe267, // fitness_center
        category: AchievementCategory.strength,
      ),
      const Achievement(
        id: 'week_warrior',
        title: 'Week Warrior',
        description: 'Reach a 7-day streak',
        iconCodePoint: 0xe52f, // local_fire_department
        category: AchievementCategory.consistency,
        xpReward: 200,
      ),
       const Achievement(
        id: 'early_bird',
        title: 'Early Bird',
        description: 'Complete a workout before 8 AM',
        iconCodePoint: 0xe5d6, // wb_sunny
        category: AchievementCategory.mindfulness,
        xpReward: 150,
      ),
      const Achievement(
        id: 'marathon_walker',
        title: 'Marathon Walker',
        description: 'Track a walk longer than 30 mins',
        iconCodePoint: 0xe566, // directions_walk
        category: AchievementCategory.walking,
        xpReward: 300,
      ),
      const Achievement(
        id: 'meal_master',
        title: 'Meal Master',
        description: 'Follow your meal plan for 3 days',
        iconCodePoint: 0xe56c, // restaurant
        category: AchievementCategory.nutrition,
        xpReward: 250,
      ),
    ];
    
    for (final achievement in defaults) {
      await box.put(achievement.id, achievement);
    }
    state = box.values.toList();
  }

  Future<void> unlock(String id) async {
    final box = ref.read(achievementsBoxProvider);
    final achievement = box.get(id);
    
    if (achievement != null && !achievement.isUnlocked) {
      final unlocked = achievement.copyWith(
        isUnlocked: true,
        unlockedAt: DateTime.now(),
      );
      await box.put(id, unlocked);
      
      // Update state
      state = box.values.toList();
    }
  }
  
  // Method to check unlocked status
  bool isUnlocked(String id) {
    return state.firstWhere((a) => a.id == id, orElse: () => const Achievement(
        id: 'temp', 
        title: '', 
        description: '', 
        iconCodePoint: 0, 
        category: AchievementCategory.consistency)
    ).isUnlocked;
  }
}
