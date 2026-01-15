import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_profile.dart';
import '../utils/constants.dart';

final initializationProvider = StateProvider<bool>((ref) => false);

final onboardingCompleteProvider = StateProvider<bool>((ref) => false);

final userProvider = StateNotifierProvider<UserNotifier, UserProfile?>((ref) {
  return UserNotifier(ref);
});

class UserNotifier extends StateNotifier<UserProfile?> {
  final Ref _ref;
  UserNotifier(this._ref) : super(null) {
    debugPrint('UserNotifier: Created instance ${hashCode}');
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      // 1. Check local storage first
      await loadProfile();
      
      // 2. Check Supabase Auth
      final authUser = Supabase.instance.client.auth.currentUser;
      if (authUser != null && state == null) {
        // We have a session but no local profile. Fetch from DB.
        await _fetchProfileFromSupabase(authUser.id);
      }

      final isComplete = await isOnboardingComplete();
      
      // If we have a user state, we should probably consider onboarding complete
      if (state != null && !isComplete) {
         final prefs = await SharedPreferences.getInstance();
         await prefs.setBool('onboarding_complete', true);
         _ref.read(onboardingCompleteProvider.notifier).state = true;
      } else {
         _ref.read(onboardingCompleteProvider.notifier).state = isComplete;
      }
      
    } catch (e) {
      debugPrint("Auth Init Error: $e");
    } finally {
      _ref.read(initializationProvider.notifier).state = true;
    }
  }

  Future<void> loadProfile() async {
    try {
      final box = Hive.box<UserProfile>(AppConstants.userBox);
      if (box.isNotEmpty) {
        state = box.getAt(0);
      }
    } catch (e) {
      debugPrint('Error loading profile: $e');
    }
  }

  Future<void> _fetchProfileFromSupabase(String userId) async {
    try {
      final data = await Supabase.instance.client
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();
      
      if (data != null) {
        // Convert to UserProfile logic needed here.
        // Since UserProfile structure might not match DB 1:1 perfectly or 
        // we might not have a fromJson yet for the Hive object, 
        // we might need to reconstruct it.
        
        // Quick Hack: For now, if we find a profile, creates a minimal local profile
        final profile = UserProfile(
          name: data['name'] ?? 'Pal',
          startingWeight: 70.0,
          targetWeight: 70.0, 
          height: 175.0,
          age: 25,
          sex: 'F', // Default
          foodsToAvoid: '', 
          startDate: DateTime.now(),
        );
        
        // Determine Onboarding Complete
        await saveProfile(profile);
      }
    } catch (e) {
      debugPrint("Error syncing profile from Supabase: $e");
    }
  }

  Future<void> saveProfile(UserProfile profile) async {
    try {
      final box = Hive.box<UserProfile>(AppConstants.userBox);
      await box.clear();
      await box.add(profile);
      state = profile;
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding_complete', true);
      _ref.read(onboardingCompleteProvider.notifier).state = true;
    } catch (e) {
      debugPrint('Error saving profile: $e');
    }
  }

  Future<bool> isOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarding_complete') ?? false;
  }
  
  String generate12WeekPlanSummary(UserProfile profile) {
    return "Pals 12-Week Plan:\n\n"
           "Phase 1: Foundation (Weeks 1-4)\n"
           "- Focus on consistency and cleaning up your diet.\n"
           "- Avoid: ${profile.foodsToAvoid}\n\n"
           "Phase 2: Intensity (Weeks 5-8)\n"
           "- Increasing activity levels and tracking progress closer.\n"
           "- Your TDEE is ${profile.tdee.toStringAsFixed(0)} kcal.\n\n"
           "Phase 3: Optimization (Weeks 9-12)\n"
           "- Fine-tuning your habits for long-term success.\n"
           "- Let's crush this as sweat pals!";
  }
}
