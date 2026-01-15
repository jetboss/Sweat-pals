import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pending_action.dart';
import 'database_service.dart';

// Provider to access the service
final syncQueueProvider = Provider((ref) => SyncQueueService());

class SyncQueueService {
  late Box<PendingAction> _box;
  // removed _db field to prevent circular dependency
  bool _isProcessing = false;

  Future<void> init() async {
    _box = await Hive.openBox<PendingAction>('pending_actions');
    
    // Listen to network changes
    Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        processQueue(); // Try to sync when network returns
      }
    });

    // Check initial connection and queue
    processQueue();
  }

  Future<void> queueAction(String type, Map<String, dynamic> payload) async {
    final action = PendingAction(
      id: DateTime.now().toIso8601String(),
      type: type,
      payload: payload,
      createdAt: DateTime.now(),
    );
    
    await _box.put(action.id, action);
    debugPrint("Offline Action Queued: $type");
    
    // Try to process immediately just in case (e.g. flaky connection)
    processQueue();
  }

  Future<void> processQueue() async {
    if (_isProcessing) return;
    
    print("Checking connection for sync...");
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      print("No internet. Queue paused.");
      return;
    }
    
    if (_box.isEmpty) return;

    _isProcessing = true;
    print("Processing Sync Queue (${_box.length} items)...");

    try {
      // Create a list copy to iterate safely while modifying
      final actions = _box.values.toList()..sort((a, b) => a.createdAt.compareTo(b.createdAt));

      final db = DatabaseService(); // Instantiate lazily to avoid circular dependency

      for (var action in actions) {
        bool success = false;
        try {
          print("Syncing action: ${action.type}");
          switch (action.type) {
            case 'log_workout':
              await db.logWorkout(
                action.payload['workout_id'], 
                action.payload['duration_seconds'],
                completedAt: DateTime.parse(action.payload['completed_at']) 
              );
              success = true;
              break;
            case 'sync_profile':
              await db.syncProfileToSupabase(
                name: action.payload['name'],
                avatarUrl: action.payload['avatar_url'],
                preferredWorkoutHour: action.payload['preferred_workout_hour'],
                fitnessLevel: action.payload['fitness_level'],
                bio: action.payload['bio'],
                sweatCoins: action.payload['sweat_coins'],
              );
              success = true;
              break;
            case 'create_pact':
              await db.createPact(
                title: action.payload['title'],
                targetCount: action.payload['target_count'],
                wagerAmount: action.payload['wager_amount'],
                deadline: DateTime.parse(action.payload['deadline']),
                squadId: action.payload['squad_id'],
              );
              success = true;
              break;
            default:
              print("Unknown action type: ${action.type}");
              await action.delete(); // Discard unknown actions to prevent blocking
              break;
          }

          if (success) {
            await action.delete();
            print("Action synced and removed from queue.");
          }
        } catch (e) {
          print("Failed to sync action ${action.id}: $e");
          // Keep in queue to retry later
          // Optionally implement max retries here to avoid poison pill
        }
      }
    } finally {
      _isProcessing = false;
    }
  }
}
