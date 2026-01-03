import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:pedometer_2/pedometer_2.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for counting steps using phone's accelerometer sensor
class PedometerService {
  static PedometerService? _instance;
  static PedometerService get instance => _instance ??= PedometerService._();
  
  PedometerService._();
  
  final Pedometer _pedometer = Pedometer();
  StreamSubscription<int>? _stepSubscription;
  final _stepController = StreamController<int>.broadcast();
  
  int _lastStepCount = 0;
  
  /// Stream of today's step count updates
  Stream<int> get stepCountStream => _stepController.stream;
  
  /// Request activity recognition permission
  Future<bool> requestPermission() async {
    final status = Platform.isAndroid 
        ? await Permission.activityRecognition.request()
        : await Permission.sensors.request();
    debugPrint('Pedometer permission: $status');
    return status.isGranted;
  }
  
  /// Check if permission is granted
  Future<bool> hasPermission() async {
    return Platform.isAndroid
        ? await Permission.activityRecognition.isGranted
        : await Permission.sensors.isGranted;
  }
  
  /// Start listening to step events
  Future<void> startListening() async {
    if (_stepSubscription != null) return; // Already listening
    
    final granted = await requestPermission();
    if (!granted) {
      debugPrint('Step counting permission denied');
      _stepController.addError('Permission denied');
      return;
    }
    
    // Get today's step count first
    await _getTodaySteps();
    
    // Listen to real-time step count stream
    _stepSubscription = _pedometer.stepCountStream().listen(
      (int steps) {
        _lastStepCount = steps;
        _stepController.add(steps);
        debugPrint('Steps since boot: $steps');
      },
      onError: (error) {
        debugPrint('Pedometer error: $error');
        _stepController.addError(error);
      },
    );
    
    debugPrint('Pedometer started listening');
  }
  
  /// Get today's step count
  Future<void> _getTodaySteps() async {
    try {
      final now = DateTime.now();
      final midnight = DateTime(now.year, now.month, now.day);
      
      final steps = await _pedometer.getStepCount(from: midnight, to: now);
      _lastStepCount = steps;
      _stepController.add(steps);
      debugPrint('Today steps: $steps');
    } catch (e) {
      debugPrint('Error getting today steps: $e');
    }
  }
  
  /// Get steps for today (call directly)
  Future<int> getTodaySteps() async {
    try {
      final now = DateTime.now();
      final midnight = DateTime(now.year, now.month, now.day);
      return await _pedometer.getStepCount(from: midnight, to: now);
    } catch (e) {
      debugPrint('Error getting today steps: $e');
      return 0;
    }
  }
  
  /// Stop listening to step events
  void stopListening() {
    _stepSubscription?.cancel();
    _stepSubscription = null;
    debugPrint('Pedometer stopped listening');
  }
  
  /// Dispose resources
  void dispose() {
    stopListening();
    _stepController.close();
  }
}
