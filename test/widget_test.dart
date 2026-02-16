import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweat_pals/src/features/tracking/tracking_screen.dart';
import 'package:sweat_pals/src/features/tracking/tracking_provider.dart';
import 'package:sweat_pals/src/models/daily_check_in.dart';
import 'package:sweat_pals/src/providers/user_provider.dart';
import 'package:sweat_pals/src/models/user_profile.dart';

class MockUserNotifier extends StateNotifier<UserProfile?> implements UserNotifier {
  MockUserNotifier() : super(null);

  @override
  Future<void> loadProfile() async {}
  
  @override
  Future<void> saveProfile(UserProfile profile) async {}

  @override
  Future<bool> isOnboardingComplete() async => true;

  @override
  String generate12WeekPlanSummary(UserProfile profile) => '';
}

// Clean Mock Notifiers with correct generic types
class MockTrackingNotifier extends StateNotifier<List<DailyCheckIn>> implements TrackingNotifier {
  MockTrackingNotifier() : super([]);
  
  @override
  late final Ref ref; // Needed for interface implementation

  @override
  int calculateStreak() => 5;
  
  @override
  Future<void> addEntry(DailyCheckIn entry) async {}

  @override
  Future<bool> freezeToday() async => true;

  @override
  bool isSameDay(DateTime a, DateTime b) => 
      a.year == b.year && a.month == b.month && a.day == b.day;
      
  // Implementing private methods isn't possible/needed for mocks usually, 
  // but if interface requires it or we need to access it, we can't easily.
  // However, TrackingNotifier doesn't expose private methods in its public interface.
  // The 'implements' keyword forces us to implement public members.
}

void main() {

  testWidgets('Tracking Screen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          trackingProvider.overrideWith((ref) => MockTrackingNotifier()),
          userProvider.overrideWith((ref) => MockUserNotifier()),
        ],
        child: const MaterialApp(
          home: TrackingScreen(),
        ),
      ),
    );

    await tester.pump();
    expect(find.text('Progress Tracking'), findsOneWidget);
  });
}
