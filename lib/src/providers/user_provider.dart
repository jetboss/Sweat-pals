import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_profile.dart';
import '../../main.dart';
import 'package:drift/drift.dart' as drift;
import '../database/app_database.dart';

final initializationProvider = Provider<bool>((ref) {
  final userState = ref.watch(userProvider);
  return !userState.isLoading;
});
final onboardingCompleteProvider = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('onboarding_complete') ?? false;
});


class UserNotifier extends AsyncNotifier<UserProfile?> {
  @override
  Future<UserProfile?> build() async {
    try {
      debugPrint("UserProvider: Initializing...");
      
      final currentUser = Supabase.instance.client.auth.currentUser;
      if (currentUser == null) {
        debugPrint("UserProvider: No current user");
        return null;
      }

      final db = ref.read(appDatabaseProvider);
      final userRow = await (db.select(db.users)..where((u) => u.id.equals(currentUser.id))).getSingleOrNull();

      if (userRow != null) {
        return UserProfile(
          name: userRow.name,
          startingWeight: userRow.startingWeight,
          targetWeight: userRow.targetWeight,
          height: userRow.height,
          age: userRow.age,
          sex: userRow.gender == 'F' ? 'F' : 'M',
          foodsToAvoid: userRow.foodsToAvoid,
          startDate: userRow.startDate, // nullable in DB, but UserProfile expects non-null? 
          // Wait, UserProfile.startDate is required. DB definition I added used withDefault(currentDateAndTime) so it's non-null.
          preferredWorkoutHour: int.tryParse(userRow.preferredWorkoutHour.split(':')[0]) ?? 8,
          fitnessLevel: userRow.fitnessLevel,
          bio: userRow.bio,
          restTokens: userRow.restTokens,
          sweatCoins: userRow.sweatCoins, // from DB
          avatarUrl: userRow.avatarUrl,
          subscriptionTier: userRow.subscriptionTier,
          currentStreak: userRow.dailyStreak,
          consistencyScore: userRow.consistencyScore,
          timezone: userRow.timezone,
          aiTrainerMode: userRow.aiTrainerMode,
          inviteCode: userRow.inviteCode,
          partnerId: userRow.partnerId,
        );
      }
      
      // Fallback: Return default profile
      return UserProfile(
        name: currentUser.userMetadata?['name'] ?? 'Sweat Pal',
        startingWeight: 70.0,
        targetWeight: 70.0,
        height: 170.0,
        age: 25,
        sex: 'M',
        foodsToAvoid: '',
        startDate: DateTime.now(),
        partnerId: null,
      );
    } catch (e) {
      debugPrint("Auth Init Error: $e");
      return null;
    }
  }

  Future<void> saveProfile(UserProfile profile) async {
    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser == null) return;
    
    final db = ref.read(appDatabaseProvider);
    final userCompanion = UsersCompanion(
      id: drift.Value(currentUser.id),
      email: drift.Value(currentUser.email),
      name: drift.Value(profile.name),
      startingWeight: drift.Value(profile.startingWeight),
      targetWeight: drift.Value(profile.targetWeight),
      height: drift.Value(profile.height),
      age: drift.Value(profile.age),
      gender: drift.Value(profile.sex),
      foodsToAvoid: drift.Value(profile.foodsToAvoid),
      startDate: drift.Value(profile.startDate),
      preferredWorkoutHour: drift.Value("${profile.preferredWorkoutHour ?? 8}:00"),
      fitnessLevel: drift.Value(profile.fitnessLevel ?? 'beginner'),
      bio: drift.Value(profile.bio),
      restTokens: drift.Value(profile.restTokens ?? 3),
      sweatCoins: drift.Value(profile.sweatCoins ?? 100),
      avatarUrl: drift.Value(profile.avatarUrl),
      subscriptionTier: drift.Value(profile.subscriptionTier),
      dailyStreak: drift.Value(profile.currentStreak),
      consistencyScore: drift.Value(profile.consistencyScore),
      timezone: drift.Value(profile.timezone),
      aiTrainerMode: drift.Value(profile.aiTrainerMode),
      inviteCode: drift.Value(profile.inviteCode),
      partnerId: drift.Value(profile.partnerId),
    );
    
    await db.into(db.users).insertOnConflictUpdate(userCompanion);
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);
    ref.invalidate(onboardingCompleteProvider); // Refresh this provider specifically
    
    state = AsyncValue.data(profile);
  }

  Future<bool> isOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarding_complete') ?? false;
  }
}

final userProvider = AsyncNotifierProvider<UserNotifier, UserProfile?>(() {
  return UserNotifier();
});
