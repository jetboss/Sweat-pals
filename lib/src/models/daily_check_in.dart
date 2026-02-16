class DailyCheckIn {
  final String id;
  final DateTime date;
  final bool followedMealPlan;
  final String mealPlanNotes;
  final double sleepHours;
  final int waterIntake; // in ml or cups, unified field
  final int moodScore; // 1-5
  final bool exerciseCompleted;
  final bool isFrozen;
  final int energyLevel; // 1-10
  final double? weight;

  DailyCheckIn({
    required this.id,
    required this.date,
    required this.followedMealPlan,
    required this.mealPlanNotes,
    required this.sleepHours,
    required this.waterIntake,
    required this.moodScore,
    required this.exerciseCompleted,
    this.isFrozen = false,
    required this.energyLevel,
    this.weight,
  });
}
