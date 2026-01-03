import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/walk_session.dart';
import '../services/walk_tracker_service.dart';

/// Provider for walk tracker service instance
final walkTrackerServiceProvider = Provider<WalkTrackerService>((ref) {
  return WalkTrackerService.instance;
});

/// Provider for current walk session updates
final walkSessionProvider = StreamProvider<WalkSession?>((ref) {
  final tracker = ref.watch(walkTrackerServiceProvider);
  return tracker.sessionStream;
});

/// Provider for tracking state
final isTrackingProvider = Provider<bool>((ref) {
  return WalkTrackerService.instance.isTracking;
});

/// State notifier for walk tracking control
class WalkTrackerNotifier extends StateNotifier<WalkTrackerState> {
  final WalkTrackerService _tracker;
  
  WalkTrackerNotifier(this._tracker) : super(WalkTrackerState.idle());
  
  /// Start a new walk
  Future<void> startWalk() async {
    state = WalkTrackerState.starting();
    final success = await _tracker.startWalk();
    if (success) {
      state = WalkTrackerState.tracking(_tracker.currentSession);
    } else {
      state = WalkTrackerState.error('Failed to start walk tracking');
    }
  }
  
  /// Stop the walk and return session
  WalkSession? stopWalk() {
    final session = _tracker.stopWalk();
    state = WalkTrackerState.completed(session);
    return session;
  }
  
  /// Pause tracking
  void pauseWalk() {
    _tracker.pauseWalk();
    state = WalkTrackerState.paused(_tracker.currentSession);
  }
  
  /// Resume tracking
  void resumeWalk() {
    _tracker.resumeWalk();
    state = WalkTrackerState.tracking(_tracker.currentSession);
  }
  
  /// Reset to idle state
  void reset() {
    state = WalkTrackerState.idle();
  }
}

/// State for walk tracking
class WalkTrackerState {
  final WalkTrackerStatus status;
  final WalkSession? session;
  final String? error;
  
  WalkTrackerState._({
    required this.status,
    this.session,
    this.error,
  });
  
  factory WalkTrackerState.idle() => WalkTrackerState._(status: WalkTrackerStatus.idle);
  factory WalkTrackerState.starting() => WalkTrackerState._(status: WalkTrackerStatus.starting);
  factory WalkTrackerState.tracking(WalkSession? session) => 
      WalkTrackerState._(status: WalkTrackerStatus.tracking, session: session);
  factory WalkTrackerState.paused(WalkSession? session) => 
      WalkTrackerState._(status: WalkTrackerStatus.paused, session: session);
  factory WalkTrackerState.completed(WalkSession? session) => 
      WalkTrackerState._(status: WalkTrackerStatus.completed, session: session);
  factory WalkTrackerState.error(String message) => 
      WalkTrackerState._(status: WalkTrackerStatus.error, error: message);
  
  bool get isIdle => status == WalkTrackerStatus.idle;
  bool get isTracking => status == WalkTrackerStatus.tracking;
  bool get isPaused => status == WalkTrackerStatus.paused;
  bool get isCompleted => status == WalkTrackerStatus.completed;
}

enum WalkTrackerStatus {
  idle,
  starting,
  tracking,
  paused,
  completed,
  error,
}

/// Provider for walk tracker control
final walkTrackerProvider = StateNotifierProvider<WalkTrackerNotifier, WalkTrackerState>((ref) {
  return WalkTrackerNotifier(WalkTrackerService.instance);
});
