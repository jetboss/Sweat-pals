import 'package:flutter/services.dart';

class SensoryService {
  
  // Singleton pattern for easy access or just keep it simple
  static final SensoryService _instance = SensoryService._internal();
  factory SensoryService() => _instance;
  SensoryService._internal();

  /// Light feedback for countdowns (3-2-1)
  Future<void> tick() async {
    await HapticFeedback.selectionClick(); // Light vibration
  }

  /// Medium feedback for successful completions (Exercise done)
  Future<void> success() async {
    await HapticFeedback.mediumImpact();
  }

  /// Heavy feedback for starting new intervals (Go!)
  Future<void> engage() async {
    await HapticFeedback.heavyImpact();
  }
}
