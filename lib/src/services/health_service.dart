import 'package:flutter/foundation.dart';
import 'package:health/health.dart';
import '../models/step_data.dart';

/// Service for reading health data from HealthKit (iOS) and Health Connect (Android)
class HealthService {
  static final Health _health = Health();
  static bool _isConfigured = false;

  /// Data types we want to access
  static final List<HealthDataType> _readTypes = [
    HealthDataType.STEPS,
    HealthDataType.DISTANCE_DELTA,
    HealthDataType.ACTIVE_ENERGY_BURNED,
  ];

  static final List<HealthDataType> _writeTypes = [
    HealthDataType.STEPS,
    HealthDataType.DISTANCE_DELTA,
  ];

  /// Configure the health plugin (call once at startup)
  static Future<void> configure() async {
    if (_isConfigured) return;
    await _health.configure();
    _isConfigured = true;
    debugPrint('HealthService configured.');
  }

  /// Check if Health Connect is available
  static Future<bool> isHealthConnectAvailable() async {
    try {
      await configure();
      return await _health.isHealthConnectAvailable();
    } catch (e) {
      debugPrint('Error checking Health Connect availability: $e');
      return false;
    }
  }

  /// Request permissions for reading health data
  /// Returns true if all permissions granted
  static Future<bool> requestPermissions() async {
    try {
      await configure();
      
      // Check if Health Connect is available (Android) or HealthKit (iOS)
      final isAvailable = await _health.isHealthConnectAvailable();
      debugPrint('Health Connect available: $isAvailable');
      
      // If Health Connect is not available on Android, try to install it
      if (!isAvailable) {
        debugPrint('Health Connect not available, attempting to install...');
        await _health.installHealthConnect();
        return false; // User needs to install Health Connect first
      }
      
      // Request authorization - this opens the system permission dialog
      debugPrint('Requesting health permissions...');
      final granted = await _health.requestAuthorization(
        _readTypes,
        permissions: _readTypes.map((_) => HealthDataAccess.READ).toList(),
      );
      
      debugPrint('Health permissions granted: $granted');
      return granted;
    } catch (e, st) {
      debugPrint('Error requesting health permissions: $e');
      debugPrint('Stack trace: $st');
      return false;
    }
  }

  /// Check if permissions have been granted
  static Future<bool> hasPermissions() async {
    try {
      await configure();
      final status = await _health.hasPermissions(_readTypes);
      return status ?? false;
    } catch (e) {
      debugPrint('Error checking health permissions: $e');
      return false;
    }
  }

  /// Get today's total step count
  static Future<int> getTodaySteps() async {
    try {
      await configure();
      
      final now = DateTime.now();
      final midnight = DateTime(now.year, now.month, now.day);
      
      final steps = await _health.getTotalStepsInInterval(midnight, now);
      return steps ?? 0;
    } catch (e) {
      debugPrint('Error getting today steps: $e');
      return 0;
    }
  }

  /// Get today's walking distance in meters
  static Future<double> getTodayDistance() async {
    try {
      await configure();
      
      final now = DateTime.now();
      final midnight = DateTime(now.year, now.month, now.day);
      
      final data = await _health.getHealthDataFromTypes(
        types: [HealthDataType.DISTANCE_DELTA],
        startTime: midnight,
        endTime: now,
      );
      
      double total = 0.0;
      for (final point in data) {
        if (point.value is NumericHealthValue) {
          total += (point.value as NumericHealthValue).numericValue.toDouble();
        }
      }
      
      return total;
    } catch (e) {
      debugPrint('Error getting today distance: $e');
      return 0.0;
    }
  }

  /// Get step data for the past 7 days
  static Future<List<StepData>> getWeeklySteps() async {
    try {
      await configure();
      
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final weeklyData = <StepData>[];
      
      for (int i = 6; i >= 0; i--) {
        final date = today.subtract(Duration(days: i));
        final endOfDay = date.add(const Duration(days: 1));
        
        final steps = await _health.getTotalStepsInInterval(date, endOfDay);
        
        // Get distance for this day
        final distanceData = await _health.getHealthDataFromTypes(
          types: [HealthDataType.DISTANCE_DELTA],
          startTime: date,
          endTime: endOfDay,
        );
        
        double distance = 0.0;
        for (final point in distanceData) {
          if (point.value is NumericHealthValue) {
            distance += (point.value as NumericHealthValue).numericValue.toDouble();
          }
        }
        
        weeklyData.add(StepData(
          date: date,
          steps: steps ?? 0,
          distanceMeters: distance,
        ));
      }
      
      return weeklyData;
    } catch (e) {
      debugPrint('Error getting weekly steps: $e');
      return [];
    }
  }

  /// Get today's data as a StepData object
  static Future<StepData> getTodayData() async {
    final steps = await getTodaySteps();
    final distance = await getTodayDistance();
    
    return StepData(
      date: DateTime.now(),
      steps: steps,
      distanceMeters: distance,
    );
  }
}
