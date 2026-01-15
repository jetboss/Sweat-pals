import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal() : _mockClient = null;

  @visibleForTesting
  AuthService.test(this._mockClient);

  final SupabaseClient? _mockClient;

  SupabaseClient get _supabase => _mockClient ?? Supabase.instance.client;

  User? get currentUser => _supabase.auth.currentUser;
  String? get currentUserId => _supabase.auth.currentUser?.id;
  String? get currentUserEmail => _supabase.auth.currentUser?.email;

  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  /// Sign in anonymously first to get them into the system
  /// Then they can link an email later if needed? 
  /// Or just standard Email/Password for "Partnership" requires identity.
  /// Let's stick to simple Sign Up for now.
  Future<AuthResponse> signUp(String email, String password) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      debugPrint('Sign Up Error: $e');
      rethrow;
    }
  }

  Future<AuthResponse> signIn(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      debugPrint('Sign In Error: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}
