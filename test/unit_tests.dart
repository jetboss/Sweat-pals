import 'package:flutter_test/flutter_test.dart';
import 'package:sweat_pals/src/models/user_profile.dart';
import 'package:sweat_pals/src/models/habit_check_in.dart';

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
    test('HabitCheckIn constructor', () {
      final entry = HabitCheckIn(
        id: '1',
        date: DateTime.now(),
        followedMealPlan: true,
        mealPlanNotes: 'Good day',
        sleepHours: 8,
        drankWater: true,
        mood: 5,
        exerciseCompleted: true,
      );
      expect(entry.id, '1');
      expect(entry.mood, 5);
    });
  });
}
