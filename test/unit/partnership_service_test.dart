import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sweat_pals/src/services/auth_service.dart';
import 'package:sweat_pals/src/services/partnership_service.dart';

// Mocks
class MockSupabaseClient extends Mock implements SupabaseClient {}
class MockSupabaseQueryBuilder extends Mock implements SupabaseQueryBuilder {}
class MockPostgrestFilterBuilder extends Mock implements PostgrestFilterBuilder<List<Map<String, dynamic>>> {}
class MockAuthService extends Mock implements AuthService {}

// Fake Transformer for awaitable queries
class FakePostgrestTransformBuilder extends Fake implements PostgrestTransformBuilder<Map<String, dynamic>> {
  final Map<String, dynamic> _result;
  FakePostgrestTransformBuilder(this._result);

  @override
  Future<U> then<U>(FutureOr<U> Function(Map<String, dynamic> value) onValue, {Function? onError}) {
    return Future.value(_result).then(onValue, onError: onError);
  }
}

void main() {
  late PartnershipService partnershipService;
  late MockSupabaseClient mockClient;
  late MockSupabaseQueryBuilder mockQueryBuilder;
  late MockPostgrestFilterBuilder mockFilterBuilder;
  late MockAuthService mockAuth;

  setUp(() {
    mockClient = MockSupabaseClient();
    mockQueryBuilder = MockSupabaseQueryBuilder();
    mockFilterBuilder = MockPostgrestFilterBuilder();
    mockAuth = MockAuthService();

    // Mock chaining: client.from() -> queryBuilder.select() -> filterBuilder.eq() -> filterBuilder
    when(() => mockClient.from(any())).thenReturn(mockQueryBuilder);
    when(() => mockQueryBuilder.select(any())).thenReturn(mockFilterBuilder);
    when(() => mockFilterBuilder.eq(any(), any())).thenReturn(mockFilterBuilder);

    partnershipService = PartnershipService.test(
      client: mockClient,
      auth: mockAuth,
    );
  });

  group('PartnershipService', () {
    test('matchWithPartner throws Exception if not logged in', () async {
      when(() => mockAuth.currentUserId).thenReturn(null);

      expect(
        () => partnershipService.matchWithPartner('CODE123'),
        throwsException,
      );
    });

    test('matchWithPartner throws Exception if trying to partner with self', () async {
      const myId = 'user_abc';
      when(() => mockAuth.currentUserId).thenReturn(myId);

      // Mock getting the partner ID from the code
      // When .single() is called, return our Fake that resolves to {'id': myId}
      when(() => mockFilterBuilder.single())
          .thenReturn(FakePostgrestTransformBuilder({'id': myId}));

      expect(
        () => partnershipService.matchWithPartner('MYCODE'),
        throwsException,
      );
    });

    test('matchWithPartner succeeds for valid partner', () async {
      const myId = 'me';
      const partnerId = 'them';
      when(() => mockAuth.currentUserId).thenReturn(myId);

       // 1. Find partner Mock
      when(() => mockFilterBuilder.single())
          .thenReturn(FakePostgrestTransformBuilder({'id': partnerId}));
      
      // 2. Insert Mock (.insert() returns a builder too, often awaited)
      // We need to see what .insert() returns. It typically returns PostgrestFilterBuilder or Transform.
      // In the service code: `await _client.from(_table).insert({...})`
      // `from` returns mockQueryBuilder.
      // `insert` lives on `SupabaseQueryBuilder`.
      // Let's mock insert.
      
      when(() => mockQueryBuilder.insert(any())).thenReturn(mockFilterBuilder); 
      // Insert is usually awaited. PostgrestFilterBuilder is awaitable? It extends PostgrestBuilder.
      // We need to make mockFilterBuilder behave like a Future or return a Fake for it too?
      // Or just assume `await mockFilterBuilder` works if we mock `then`.
      // Mocktail mocks don't implement `then` by default.
      
      // Let's use a Fake for the insert result as well.
      // `insert` returns `PostgrestFilterBuilder` which is awaitable.
      // So we need `mockQueryBuilder.insert` to return a `FakePostgrestFilterBuilder`.
      
      when(() => mockQueryBuilder.insert(any())).thenReturn(FakePostgrestFilterBuilder());

      await partnershipService.matchWithPartner('VALID_CODE');
      
      verify(() => mockQueryBuilder.insert(any(that: isA<Map>()))).called(1);
    });
  });
}

// Fake Filter Builder for Insert (void/null result usually when not selecting)
class FakePostgrestFilterBuilder extends Fake implements PostgrestFilterBuilder<List<Map<String, dynamic>>> {
  @override
  Future<U> then<U>(FutureOr<U> Function(List<Map<String, dynamic>> value) onValue, {Function? onError}) {
    return Future.value(<Map<String, dynamic>>[]).then(onValue, onError: onError);
  }
}
