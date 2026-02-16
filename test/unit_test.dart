import 'package:flutter_test/flutter_test.dart';
import 'package:sweat_pals/src/models/user_profile.dart';
import 'package:sweat_pals/src/models/daily_check_in.dart';

void main() {
  group('UserProfile Tests', () {
    test('BMI Calculation', () {
      final user = UserProfile(
        name: 'Test Pal',
        startingWeight: 70,
        targetWeight: 65,
        height: 175,
        age: 25,
        sex: 'M',
        foodsToAvoid: '',
        startDate: DateTime.now(),
      );
      expect(user.bmi, closeTo(22.86, 0.01));
    });

    test('TDEE Calculation (Male)', () {
      final user = UserProfile(
        name: 'Test Pal',
        startingWeight: 70,
        targetWeight: 65,
        height: 175,
        age: 25,
        sex: 'M',
        foodsToAvoid: '',
        startDate: DateTime.now(),
      );
      // BMR = 66.5 + (13.7 * 70) + (5 * 175) - (6.7 * 25) = 1733
      // TDEE = 1733 * 1.375 = 2382.875
      expect(user.tdee, closeTo(2382.875, 0.1));
    });
  });

  group('Model Validity Tests', () {
    test('DailyCheckIn constructor', () {
      final entry = DailyCheckIn(
        id: '1',
        date: DateTime.now(),
        followedMealPlan: true,
        mealPlanNotes: 'Good day',
        sleepHours: 8,
        waterIntake: 2500,
        moodScore: 5,
        exerciseCompleted: true,
        energyLevel: 8,
        weight: 70.5,
      );
      expect(entry.id, '1');
      expect(entry.moodScore, 5);
      expect(entry.energyLevel, 8);
    });
  });
}
