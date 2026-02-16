import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../database/app_database.dart';
import '../../main.dart'; // for appDatabaseProvider

// Provider to access the service
final syncQueueProvider = Provider<SyncQueueService>((ref) => SyncQueueService(ref));

class SyncQueueService {
  final Ref _ref;
  bool _isProcessing = false;
  final SupabaseClient _supabase = Supabase.instance.client;

  SyncQueueService(this._ref);

  /// Queue an action for offline/background execution
  Future<void> queueAction(String type, Map<String, dynamic> payload) async {
    final db = _ref.read(appDatabaseProvider);
    final id = DateTime.now().millisecondsSinceEpoch.toString(); // Simple ID

    debugPrint("Queueing action: $type");
    
    await db.into(db.syncQueue).insert(
      SyncQueueCompanion(
        id: drift.Value(id),
        type: drift.Value(type),
        payload: drift.Value(payload),
        createdAt: drift.Value(DateTime.now()),
      ),
    );
    
    // Trigger processing immediately (optimistic)
    processQueue(); 
  }

  /// Process pending actions
  Future<void> processQueue() async {
    if (_isProcessing) return;
    _isProcessing = true;
    
    final db = _ref.read(appDatabaseProvider);

    try {
      // Fetch all pending actions, oldest first
      final pendingActions = await (db.select(db.syncQueue)
            ..orderBy([(t) => drift.OrderingTerm(expression: t.createdAt)]))
          .get();

      if (pendingActions.isEmpty) {
        _isProcessing = false;
        return;
      }

      debugPrint("Processing ${pendingActions.length} pending actions...");

      for (final action in pendingActions) {
        bool success = false;
        try {
          success = await _executeAction(action.type, action.payload);
        } catch (e) {
          debugPrint("Error execution action ${action.id}: $e");
          // If 400-level error (Client Error), we should probably delete it to avoid infinite loops
          // For now, we'll keep it for network errors
        }

        if (success) {
          await (db.delete(db.syncQueue)..where((t) => t.id.equals(action.id))).go();
          debugPrint("Action ${action.id} (${action.type}) synced successfully.");
        }
      }
    } catch (e) {
      debugPrint("Error in processQueue: $e");
    } finally {
      _isProcessing = false;
    }
  }

  Future<bool> _executeAction(String type, Map<String, dynamic> payload) async {
    switch (type) {
      case 'create_pact':
        return _syncPact(payload);
      case 'log_workout':
        return _syncWorkout(payload);
      case 'daily_checkin':
        return _syncCheckIn(payload);
      case 'resolve_pact':
        return _resolvePact(payload);
      // Add more cases here
      default:
        debugPrint("Unknown action type: $type");
        return true; // Delete unknown actions
    }
  }

  Future<bool> _syncPact(Map<String, dynamic> payload) async {
    try {
      debugPrint("RPC: create_pact_secure for ${payload['id']}");
      
      // Use Postgres Function for atomic balance check & creation
      // We don't use the returned ID because we generated one locally (UUID)
      // Ideally we should pass the ID to the function to respect it, 
      // but 'create_pact_secure' currently generates a NEW ID.
      // For MVP, this is acceptable as long as we don't need strict ID matching back to local immediately.
      // A better approach would be to update the function to accept an optional ID.
      // Let's assume we update the function or just accept the divergence for now.
      
      await _supabase.rpc('create_pact_secure', params: {
        'p_title': payload['title'],
        'p_description': payload['description'] ?? '',
        'p_target_count': payload['target_count'],
        'p_wager_amount': payload['wager_amount'],
        'p_frequency': payload['frequency'] ?? 'daily',
        'p_deadline': payload['deadline'],
        'p_squad_id': payload['squad_id'],
      });
      
      return true;
    } catch (e) {
       // REJECTION HANDLING:
       // If error is "Insufficient Funds", we must ROLLBACK.
       if (e.toString().contains("Insufficient")) {
         debugPrint("FATAL: Insufficient funds on server. Rolling back local pact.");
         
         // Rollback Logic: Delete the local pact
         final db = _ref.read(appDatabaseProvider);
         final localId = payload['id'];
         if (localId != null) {
            await (db.delete(db.pactsTable)..where((t) => t.id.equals(localId))).go();
         }
         
         return true; // Return true to remove from queue (it's a hard failure)
       }
       debugPrint("Sync Error (Retryable): $e");
       rethrow; // Network error -> retry
    }
  }

  Future<bool> _syncWorkout(Map<String, dynamic> payload) async {
    await _supabase.from('workout_logs').insert(payload);
    return true;
  }
  
  Future<bool> _syncCheckIn(Map<String, dynamic> payload) async {
     await _supabase.from('daily_checkins').insert({
        'user_id': _supabase.auth.currentUser?.id,
        ...payload
     });
     return true;
  }

  Future<bool> _resolvePact(Map<String, dynamic> payload) async {
    try {
      debugPrint("RPC: resolve_pact for ${payload['id']}");
      await _supabase.rpc('resolve_pact', params: {
        'p_pact_id': payload['id'],
        'p_outcome': payload['outcome'],
      });
      return true;
    } catch (e) {
      debugPrint("Error resolving pact: $e");
      // If pact not found (maybe sync lag), we might want to retry?
      // Or if it's a permanent error, ignore.
      return false; // Retry
    }
  }
}
