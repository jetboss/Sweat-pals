import 'package:hive/hive.dart';

part 'habit_check_in.g.dart';

@HiveType(typeId: 23)
class HabitCheckIn extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final bool followedMealPlan;

  @HiveField(3)
  final String mealPlanNotes;

  @HiveField(4)
  final double sleepHours;

  @HiveField(5)
  final bool drankWater;

  @HiveField(6)
  final int mood; // 1-5

  @HiveField(7)
  final bool exerciseCompleted;

  HabitCheckIn({
    required this.id,
    required this.date,
    required this.followedMealPlan,
    required this.mealPlanNotes,
    required this.sleepHours,
    required this.drankWater,
    required this.mood,
    required this.exerciseCompleted,
  });
}
