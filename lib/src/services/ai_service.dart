import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/daily_check_in.dart';
import '../models/user_profile.dart';

class AiService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String> sendMessage({
    required String message,
    required UserProfile user,
    DailyCheckIn? todayCheckIn,
  }) async {
    try {
      final systemPrompt = _buildSystemPrompt(user.aiTrainerMode);
      final contextJson = _buildContextJson(user, todayCheckIn);

      debugPrint('Sending AI Message: $message');
      debugPrint('Context: $contextJson');
      debugPrint('Mode: ${user.aiTrainerMode}');

      // In a real implementation, we'd call the Edge Function.
      // For now, we can simulate the response OR try to call a function if one exists.
      // Assuming 'ai-trainer' function exists.
      
      try {
        final response = await _supabase.functions.invoke(
          'ai-trainer',
          body: {
            'message': message,
            'systemPrompt': systemPrompt,
            'context': contextJson,
          },
        );
        
        final data = response.data;
        if (data != null && data is Map && data.containsKey('reply')) {
          return data['reply'] as String;
        }
      } catch (e) {
        debugPrint('Edge function failed (expected in dev without deploy): $e');
        // Fallback simulation for testing UI flow
        return _simulateResponse(user.aiTrainerMode, message, todayCheckIn);
      }

      return "I'm having trouble connecting to the gym mainframe. Try again later!";
    } catch (e) {
      debugPrint('AI Service Error: $e');
      return "Error: $e";
    }
  }

  String _buildSystemPrompt(String mode) {
    switch (mode) {
      case 'sergeant':
        return "You are a ruthless Drill Sergeant. Call the user 'Recruit'. Keep sentences short, punchy, and aggressive. No excuses. Value discipline above all. If energy is low, tell them to push through.";
      case 'pro':
        return "You are a elite Sports Scientist and Coach. Be data-driven, balanced, and smart. Explain the 'why' behind advice. Prioritize recovery if energy is low. Use terminology like 'progressive overload' or 'active recovery'.";
      case 'friend':
      default:
        return "You are a supportive Fitness Best Friend. Be high energy, empathetic, and use lots of emojis 🌟. Prioritize mental health and fun. If they are tired, tell them it's okay to rest.";
    }
  }

  Map<String, dynamic> _buildContextJson(UserProfile user, DailyCheckIn? checkIn) {
    return {
      'user_name': user.name,
      'streak_count': user.currentStreak,
      'fitness_level': user.fitnessLevel,
      'today_energy': checkIn?.energyLevel ?? 'unknown',
      'today_mood': checkIn?.moodScore ?? 'unknown',
      'workout_completed': checkIn?.exerciseCompleted ?? false,
      'subscription_tier': user.subscriptionTier,
    };
  }

  String _simulateResponse(String mode, String message, DailyCheckIn? checkIn) {
    // Temporary simulation to verify UI personas
    final energy = checkIn?.energyLevel ?? 5;
    
    if (mode == 'sergeant') {
      if (energy < 4) return "TIRED? I DON'T CARE! DROP AND GIVE ME 20, RECRUIT! PAIN IS WEAKNESS LEAVING THE BODY!";
      return "GOOD. NOW GET MOVING. THE ONLY EASY DAY WAS YESTERDAY.";
    } else if (mode == 'pro') {
      if (energy < 4) return "Based on your low energy and HRV data, I recommend active recovery today. A light walk will stimulate blood flow without CNS fatigue.";
      return "Optimal. Let's focus on hypertrophy today. Remember: time under tension is key.";
    } else {
      if (energy < 4) return "Aww bestie, take it easy! 🛁 A bubble bath counts as self-care. You got this tomorrow! 💖";
      return "YAAAS! You're crushing it! 🔥 Let's get that glow! ✨";
    }
  }
}
