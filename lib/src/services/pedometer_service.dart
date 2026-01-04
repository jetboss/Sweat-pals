import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:pedometer_2/pedometer_2.dart';
import 'package:permission_handler/permission_handler.dart';

/// Service for counting steps using phone's accelerometer sensor
class PedometerService {
  static PedometerService? _instance;
  static PedometerService get instance => _instance ??= PedometerService._();
  
  PedometerService._();
  
  final Pedometer _pedometer = Pedometer();
  Timer? _refreshTimer;
  final _stepController = StreamController<int>.broadcast();
  
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
    if (_refreshTimer != null) return; // Already listening
    
    final granted = await requestPermission();
    if (!granted) {
      debugPrint('Step counting permission denied');
      _stepController.addError('Permission denied');
      return;
    }
    
    // Get today's step count immediately
    await _refreshTodaySteps();
    
    // Poll every 10 seconds for updated step count
    // Using getStepCount with date range gives accurate "today" count
    _refreshTimer = Timer.periodic(const Duration(seconds: 10), (_) async {
      await _refreshTodaySteps();
    });
    
    debugPrint('Pedometer started listening (polling every 10s)');
  }
  
  /// Refresh today's step count
  Future<void> _refreshTodaySteps() async {
    try {
      final steps = await getTodaySteps();
      _stepController.add(steps);
      debugPrint('Today steps: $steps');
    } catch (e) {
      debugPrint('Error refreshing steps: $e');
    }
  }
  
  /// Get steps for today only (midnight to now)
  Future<int> getTodaySteps() async {
    try {
      final now = DateTime.now();
      final midnight = DateTime(now.year, now.month, now.day);
      final steps = await _pedometer.getStepCount(from: midnight, to: now);
      return steps;
    } catch (e) {
      debugPrint('Error getting today steps: $e');
      return 0;
    }
  }
  
  /// Stop listening to step events
  void stopListening() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
    debugPrint('Pedometer stopped listening');
  }
  
  /// Dispose resources
  void dispose() {
    stopListening();
    _stepController.close();
  }
}
