import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/pedometer_service.dart';

/// Provider for today's step count (live updates from phone pedometer)
final pedometerProvider = StreamProvider<int>((ref) {
  final pedometer = PedometerService.instance;
  
  // Start listening when provider is first accessed
  pedometer.startListening();
  
  // Return the step count stream
  return pedometer.stepCountStream;
});

/// Provider for checking pedometer permission
final pedometerPermissionProvider = FutureProvider<bool>((ref) async {
  return await PedometerService.instance.hasPermission();
});

/// Simple provider for step goal (default 10K)
final stepGoalProvider = StateProvider<int>((ref) => 10000);
