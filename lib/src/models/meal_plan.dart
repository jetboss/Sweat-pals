import 'package:hive/hive.dart';

part 'meal_plan.g.dart';

@HiveType(typeId: 5)
class Meal {
  @HiveField(0)
  final String name;
  
  @HiveField(1)
  final int calories;
  
  @HiveField(2)
  final int protein; // grams
  
  @HiveField(3)
  final int carbs; // grams
  
  @HiveField(4)
  final int fats; // grams
  
  @HiveField(5)
  final List<String> ingredients;
  
  @HiveField(6)
  final String type; // Breakfast, Lunch, Dinner, Snack

  const Meal({
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.ingredients,
    required this.type,
  });
}

@HiveType(typeId: 6)
class DailyPlan {
  @HiveField(0)
  final int dayNumber; // 1-7
  
  @HiveField(1)
  final List<Meal> meals;

  const DailyPlan({
    required this.dayNumber,
    required this.meals,
  });

  int get totalCalories => meals.fold(0, (sum, meal) => sum + meal.calories);
  int get totalProtein => meals.fold(0, (sum, meal) => sum + meal.protein);
  int get totalCarbs => meals.fold(0, (sum, meal) => sum + meal.carbs);
  int get totalFats => meals.fold(0, (sum, meal) => sum + meal.fats);
}
