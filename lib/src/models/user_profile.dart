class UserProfile {
  final String name;
  final double startingWeight;
  final double targetWeight;
  final double height;
  final int age;
  final String sex; // 'M' or 'F'
  final String foodsToAvoid;
  final DateTime startDate;
  final int? preferredWorkoutHour; // 0-23
  final String? fitnessLevel; // beginner/intermediate/advanced
  final String? bio;
  final int? restTokens; // Default 3
  final int? sweatCoins; // Default 100
  final String? avatarUrl;
  final String subscriptionTier; // 'free', 'pro', 'squad'
  final int currentStreak;
  final double consistencyScore;
  final String? timezone;
  final String aiTrainerMode; // 'friend', 'sergeant', 'pro'
  final String? inviteCode;
  final String? partnerId;

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
    this.avatarUrl,
    this.subscriptionTier = 'free',
    this.currentStreak = 0,
    this.consistencyScore = 0.0,
    this.timezone,
    this.aiTrainerMode = 'friend',
    this.inviteCode,
    this.partnerId,
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
