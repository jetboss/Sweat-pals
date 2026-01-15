import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_service.dart';
import 'sync_queue_service.dart';

class DatabaseService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final AuthService _auth = AuthService();

  final SyncQueueService _syncQueue = SyncQueueService();

  /// Log a workout completion to Supabase
  Future<void> logWorkout(String workoutId, int durationSeconds, {DateTime? completedAt}) async {
    final userId = _auth.currentUserId;
    if (userId == null) return;

    try {
      await _supabase.from('workout_logs').insert({
        'user_id': userId,
        'workout_id': workoutId,
        'duration_seconds': durationSeconds,
        'completed_at': (completedAt ?? DateTime.now()).toIso8601String(),
      });
    } catch (e) {
      print('Error logWorkout: $e - Queueing offline action');
      await _syncQueue.queueAction('log_workout', {
        'workout_id': workoutId,
        'duration_seconds': durationSeconds,
        'completed_at': (completedAt ?? DateTime.now()).toIso8601String(),
      });
    }
  }

  /// Streaming list of partner's workouts for today
  Stream<List<Map<String, dynamic>>> streamPartnerLogs(String partnerId) {
    // We want logs for today (UTC)
    // Note: This is a simplification. Ideally handle timezones better.
    // For now, let's just stream the last 24 hours or just check locally logic
    
    // Supabase filtering on timestamps in streams can be tricky.
    // We'll stream the latest 10 logs for the partner and filter in Dart if needed.
    return _supabase
        .from('workout_logs')
        .stream(primaryKey: ['id'])
        .eq('user_id', partnerId)
        .order('completed_at', ascending: false)
        .limit(10);
  }
  
  /// Get partner's logs for today (Future)
  Future<List<Map<String, dynamic>>> getPartnerLogsForToday(String partnerId) async {
    final now = DateTime.now().toUtc();
    final startOfDay = DateTime.utc(now.year, now.month, now.day).toIso8601String();
    
    try {
      final response = await _supabase
          .from('workout_logs')
          .select()
          .eq('user_id', partnerId)
          .gte('completed_at', startOfDay);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Error fetching partner logs: $e');
      return [];
    }
  }

  /// Send a "Nudge" to a partner
  Future<void> sendNudge(String partnerId, {String type = 'nudge'}) async {
    final userId = _auth.currentUserId;
    if (userId == null) return;

    try {
      await _supabase.from('notifications').insert({
        'recipient_id': partnerId,
        'sender_id': userId,
        'type': type,
        // created_at auto-generated
      });
    } catch (e) {
      print('Error sending nudge: $e');
      rethrow;
    }
  }

  /// Stream notifications for the current user
  Stream<List<Map<String, dynamic>>> streamNotifications() {
    final userId = _auth.currentUserId;
    if (userId == null) return Stream.value([]);

    return _supabase
        .from('notifications')
        .stream(primaryKey: ['id'])
        .eq('recipient_id', userId)
        .order('created_at', ascending: false)
        .limit(1); // just need the latest one to trigger UI
  }

  // --- SQUADS ---

  Future<String?> createSquad(String name, String tier) async {
    final userId = _auth.currentUserId;
    if (userId == null) return null;

    final inviteCode = DateTime.now().millisecondsSinceEpoch.toString().substring(8) + 
                       (1000 + (name.hashCode % 9000)).toString(); // Simple unique-ish code

    try {
      // 1. Create Squad
      final squadResponse = await _supabase.from('squads').insert({
        'name': name,
        'tier': tier,
        'invite_code': inviteCode,
        'created_by': userId,
      }).select().single();
      
      final squadId = squadResponse['id'];

      // 2. Add creator as Owner
      await _supabase.from('squad_members').insert({
        'squad_id': squadId,
        'user_id': userId,
        'role': 'owner',
        'status': 'active',
      });

      return squadId;
    } catch (e) {
      print('Error creating squad: $e');
      throw e; // Rethrow so UI can show it
    }
  }

  Future<bool> joinSquad(String inviteCode) async {
    final userId = _auth.currentUserId;
    if (userId == null) return false;

    try {
      // 1. Find Squad
      final squad = await _supabase
          .from('squads')
          .select()
          .eq('invite_code', inviteCode)
          .single();
      
      final squadId = squad['id'];

      // 2. Join
      await _supabase.from('squad_members').insert({
        'squad_id': squadId,
        'user_id': userId,
        'role': 'member',
        'status': 'active', // Default active on join
      });
      return true;
    } catch (e) {
      print('Error joining squad: $e');
      return false;
    }
  }

  Stream<Map<String, dynamic>?> streamMySquad() {
    final userId = _auth.currentUserId;
    if (userId == null) return Stream.value(null);

    // This is tricky because we need to join tables.
    // Supabase Stream doesn't support joins well.
    // Hack: Stream `squad_members` for me, then fetch squad.
    // OR: Just fetch `squad_members` and assume one squad for now.
    
    return _supabase
        .from('squad_members')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .limit(1)
        .asyncMap((members) async {
          if (members.isEmpty) return null;
          final squadId = members.first['squad_id'];
          
          // Fetch the squad details (single fetch, could be reactive but keep it simple)
          final squad = await _supabase.from('squads').select().eq('id', squadId).single();
          return squad;
        });
  }

  Stream<List<Map<String, dynamic>>> streamSquadMembers(String squadId) {
    // We want member details + profile info usually.
    // Supabase stream returns the raw table row.
    // We will need to fetch profiles separately or use a view.
    // For MVP, just stream the membership and let UI fetch profiles or combine.
    return _supabase
        .from('squad_members')
        .stream(primaryKey: ['id'])
        .eq('squad_id', squadId);
  }

  Future<Map<String, dynamic>?> getProfile(String userId) async {
    try {
      final res = await _supabase.from('profiles').select().eq('id', userId).single();
      return res;
    } catch (e) {
      return null;
    }
  }

  /// Sync local profile data to Supabase
  Future<void> syncProfileToSupabase({
    required String name,
    String? avatarUrl,
    int? preferredWorkoutHour,
    String? fitnessLevel,
    String? bio,
    int? sweatCoins,
  }) async {
    final userId = _auth.currentUserId;
    if (userId == null) return;

    try {
      await _supabase.from('profiles').upsert({
        'id': userId,
        'name': name,
        if (avatarUrl != null) 'avatar_url': avatarUrl,
        if (preferredWorkoutHour != null) 'preferred_workout_hour': preferredWorkoutHour,
        if (fitnessLevel != null) 'fitness_level': fitnessLevel,
        if (bio != null) 'bio': bio,
        if (sweatCoins != null) 'sweat_coins': sweatCoins,
      });
      print('Profile synced to Supabase');
    } catch (e) {
      print('Error syncing profile: $e - Queueing offline action');
      await _syncQueue.queueAction('sync_profile', {
        'name': name,
        'avatar_url': avatarUrl,
        'preferred_workout_hour': preferredWorkoutHour,
        'fitness_level': fitnessLevel,
        'bio': bio,
        'sweat_coins': sweatCoins,
      });
    }
  }

  /// Get weekly workout count for a user
  Future<int> getWeeklyWorkoutCount(String userId) async {
    try {
      final now = DateTime.now();
      final weekStart = now.subtract(Duration(days: now.weekday - 1));
      final startOfWeek = DateTime(weekStart.year, weekStart.month, weekStart.day);
      
      final res = await _supabase
          .from('workout_logs')
          .select('id')
          .eq('user_id', userId)
          .gte('completed_at', startOfWeek.toIso8601String());
      
      return (res as List).length;
    } catch (e) {
      print('Error getting weekly workout count: $e');
      return 0;
    }
  }

  /// Find matching profiles for the current user (using RPC)
  Future<List<Map<String, dynamic>>> findMatches() async {
    final userId = _auth.currentUserId;
    if (userId == null) return [];

    try {
      final response = await _supabase.rpc(
        'match_profiles',
        params: {'current_user_id': userId},
      );
      
      // The response is a List of Maps
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Error finding matches: $e');
      return [];
    }
  }
  // --- PRESENCE ---

  RealtimeChannel? _presenceChannel;
  final ValueNotifier<Map<String, Map<String, dynamic>>> presenceState = ValueNotifier({});

  Future<void> initializePresence(String squadId) async {
    final userId = _auth.currentUserId;
    if (userId == null) return;

    // Clean up existing
    if (_presenceChannel != null) {
      await _supabase.removeChannel(_presenceChannel!);
    }

    _presenceChannel = _supabase.channel('presence:$squadId');

    _presenceChannel!
        .onPresenceSync((payload) {
          final state = _presenceChannel!.presenceState();
          // Convert to Map<UserId, Data>
          final newState = <String, Map<String, dynamic>>{};
          
          for (final entry in state) { // state is List<PresenceState>
            final presences = entry.presences; // List<Presence>
            if (presences.isNotEmpty) {
               final data = presences.first.payload as Map<String, dynamic>; // payload is Map
               final uid = data['user_id'] as String?;
               if (uid != null) {
                 newState[uid] = data;
               }
            }
          }
          presenceState.value = newState;
        })
        .subscribe((status, error) async {
          if (status == RealtimeSubscribeStatus.subscribed) {
            await updatePresenceStatus('online');
          }
        });
  }

  Future<void> updatePresenceStatus(String status) async {
    final userId = _auth.currentUserId;
    if (userId == null || _presenceChannel == null) return;

    await _presenceChannel!.track({
      'user_id': userId,
      'status': status, // 'online' or 'working_out'
      'last_seen': DateTime.now().toIso8601String(),
    });
  }

  // --- PACTS ---

  Future<void> createPact({
    required String title,
    required int targetCount,
    required int wagerAmount,
    required DateTime deadline,
    String? squadId,
  }) async {
    final userId = _auth.currentUserId;
    if (userId == null) return;

    // 1. Check Balance (Mock check - ideally done via RLS or Function)
    final profile = await _supabase.from('profiles').select('sweat_coins').eq('id', userId).single();
    final currentCoins = profile['sweat_coins'] as int? ?? 0;
    
    if (currentCoins < wagerAmount) {
      throw Exception("Insufficient Sweat Coins! You have $currentCoins.");
    }

    // 2. Create Pact
    try {
      await _supabase.from('pacts').insert({
        'user_id': userId,
        'squad_id': squadId,
        'title': title,
        'target_count': targetCount,
        'wager_amount': wagerAmount,
        'deadline': deadline.toUtc().toIso8601String(),
      });

      // 3. Deduct Coins (Optimistic update - in real app, better to do via Postgres Function transaction)
      await _supabase.from('profiles').update({
        'sweat_coins': currentCoins - wagerAmount,
      }).eq('id', userId);
    } catch (e) {
      print('Error creating pact: $e - Queueing offline action');
      // Note: We don't queue coin deduction separately as logic implies it happens with pact creation
      // Ideally this is atomic. For MVP queue re-attempts the whole pact flow.
      await _syncQueue.queueAction('create_pact', {
        'title': title,
        'target_count': targetCount,
        'wager_amount': wagerAmount,
        'deadline': deadline.toIso8601String(),
        'squad_id': squadId,
      });
    }
  }

  Stream<List<Map<String, dynamic>>> streamMyPacts() {
    final userId = _auth.currentUserId;
    if (userId == null) return Stream.value([]);

    return _supabase
        .from('pacts')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .order('created_at', ascending: false);
  }
}
