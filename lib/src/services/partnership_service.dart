import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_service.dart';

class PartnershipService {
  static final PartnershipService _instance = PartnershipService._internal();
  factory PartnershipService() => _instance;
  PartnershipService._internal() : _mockClient = null, _mockAuth = null;

  @visibleForTesting
  PartnershipService.test({SupabaseClient? client, AuthService? auth}) 
      : _mockClient = client, _mockAuth = auth;

  final SupabaseClient? _mockClient;
  final AuthService? _mockAuth;

  SupabaseClient get _client => _mockClient ?? Supabase.instance.client;
  AuthService get _auth => _mockAuth ?? AuthService();

  final String _table = 'partnerships';

  // Generate a simple 6-char code from User ID for sharing
  // (In a real app, store this in a 'profiles' table to map back to UUID)
  // For MVP, we might just require sharing the email/ID, but 
  // let's assume we have a 'profiles' table with 'invite_code'.
  
  /// Create a link between current user and the target code
  Future<void> matchWithPartner(String partnerCode) async {
    final myId = _auth.currentUserId;
    if (myId == null) throw Exception("Not logged in");

    // 1. Find partner by code
    final response = await _client
        .from('profiles')
        .select('id')
        .eq('invite_code', partnerCode)
        .single();
    
    final partnerId = response['id'] as String;

    if (partnerId == myId) throw Exception("You cannot partner with yourself!");

    // 2. Create Partnership Row
    await _client.from(_table).insert({
      'user_1': myId,
      'user_2': partnerId,
      'status': 'active',
      'created_at': DateTime.now().toIso8601String(),
    });

    debugPrint("Partnership created between $myId and $partnerId");
  }

  Stream<List<Map<String, dynamic>>> getMyPartnership() {
    final myId = _auth.currentUserId;
    if (myId == null) return const Stream.empty();

    // Query for any row where I am user_1 OR user_2
    return _client.from(_table).stream(primaryKey: ['id']).map((rows) {
      return rows.where((row) => 
        row['user_1'] == myId || row['user_2'] == myId
      ).toList();
    });
  }
}
