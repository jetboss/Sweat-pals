import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweat_pals/src/features/dashboard/dashboard_screen.dart';
import 'package:sweat_pals/src/features/tracking/tracking_screen.dart';
import 'package:sweat_pals/src/features/tracking/tracking_provider.dart';
import 'package:sweat_pals/src/features/review/review_provider.dart';
import 'package:sweat_pals/src/features/dashboard/photos_provider.dart';
import 'package:sweat_pals/src/providers/user_provider.dart';
import 'package:sweat_pals/src/models/user_profile.dart';
import 'package:sweat_pals/src/models/habit_check_in.dart';
import 'package:sweat_pals/src/models/weekly_review.dart';
import 'package:sweat_pals/src/models/progress_photo.dart';

// Clean Mock Notifiers with correct generic types
class MockTrackingNotifier extends StateNotifier<List<HabitCheckIn>> implements TrackingNotifier {
  MockTrackingNotifier() : super([]);
  @override
  int calculateStreak() => 5;
  @override
  Future<void> addEntry(HabitCheckIn entry) async {}
}

class MockReviewNotifier extends StateNotifier<List<WeeklyReview>> implements ReviewNotifier {
  MockReviewNotifier() : super([]);
  @override
  Future<void> addEntry(WeeklyReview entry) async {}
  @override
  String getSuggestion(WeeklyReview current) => "Keep it up!";
}

class MockPhotosNotifier extends StateNotifier<List<ProgressPhoto>> implements PhotosNotifier {
  MockPhotosNotifier() : super([]);
  @override
  Future<void> pickAndAddPhoto(dynamic source) async {}
  @override
  Future<void> deletePhoto(ProgressPhoto photo) async {}
}

class MockUserNotifier extends StateNotifier<UserProfile?> implements UserNotifier {
  MockUserNotifier(UserProfile? initial) : super(initial);
  @override
  Future<void> loadProfile() async {}
  @override
  Future<void> saveProfile(UserProfile profile) async {}
  @override
  Future<bool> isOnboardingComplete() async => true;
  @override
  String generate12WeekPlanSummary(UserProfile profile) => "Mock Summary";
}

void main() {
  final mockUser = UserProfile(
    name: 'Sarah',
    startingWeight: 70,
    targetWeight: 65,
    height: 175,
    age: 25,
    sex: 'F',
    foodsToAvoid: '',
    startDate: DateTime.now(),
  );

  testWidgets('Dashboard Screen renders', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userProvider.overrideWith((ref) => MockUserNotifier(mockUser)),
          trackingProvider.overrideWith((ref) => MockTrackingNotifier()),
          reviewProvider.overrideWith((ref) => MockReviewNotifier()),
          photosProvider.overrideWith((ref) => MockPhotosNotifier()),
        ],
        child: const MaterialApp(
          home: DashboardScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Sweat Pals'), findsOneWidget);
    expect(find.text('Hi Sarah!'), findsOneWidget);
  });

  testWidgets('Tracking Screen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          trackingProvider.overrideWith((ref) => MockTrackingNotifier()),
        ],
        child: const MaterialApp(
          home: TrackingScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Progress Tracking'), findsOneWidget);
  });
}
