import 'package:hive/hive.dart';

part 'user_profile.g.dart';

@HiveType(typeId: 0)
class UserProfile extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final double startingWeight;

  @HiveField(2)
  final double targetWeight;

  @HiveField(3)
  final double height;

  @HiveField(4)
  final int age;

  @HiveField(5)
  final String sex; // 'M' or 'F'

  @HiveField(6)
  final String foodsToAvoid;

  @HiveField(7)
  final DateTime startDate;

  @HiveField(8)
  final int? preferredWorkoutHour; // 0-23

  @HiveField(9)
  final String? fitnessLevel; // beginner/intermediate/advanced

  @HiveField(10)
  final String? bio;

  @HiveField(11)
  final int? restTokens; // Default 3

  @HiveField(12)
  final int? sweatCoins; // Default 100

  UserProfile({
    required this.name,
    required this.startingWeight,
    required this.targetWeight,
    required this.height,
    required this.age,
    required this.sex,
    required this.foodsToAvoid,
    required this.startDate,
    this.preferredWorkoutHour,
    this.fitnessLevel,
    this.bio,
    this.restTokens = 3,
    this.sweatCoins = 100,
  });

  double get bmi => startingWeight / ((height / 100) * (height / 100));

  double get bmr {
    if (sex == 'F') {
      return 655 + (9.6 * startingWeight) + (1.8 * height) - (4.7 * age);
    } else {
      return 66.5 + (13.7 * startingWeight) + (5 * height) - (6.7 * age);
    }
  }

  double get tdee => bmr * 1.375; // Moderate active average multiplier
}
