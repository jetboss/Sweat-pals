import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/health_service.dart';

class HealthState {
  final int steps;
  final int calories;
  final bool isConnected;
  final bool isLoading;

  HealthState({
    this.steps = 0,
    this.calories = 0,
    this.isConnected = false,
    this.isLoading = false,
  });

  HealthState copyWith({
    int? steps,
    int? calories,
    bool? isConnected,
    bool? isLoading,
  }) {
    return HealthState(
      steps: steps ?? this.steps,
      calories: calories ?? this.calories,
      isConnected: isConnected ?? this.isConnected,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class HealthNotifier extends StateNotifier<HealthState> {
  HealthNotifier() : super(HealthState()) {
    init();
  }

  Future<void> init() async {
    state = state.copyWith(isLoading: true);
    
    // Check if we have permissions already
    final hasPerms = await HealthService.hasPermissions();
    if (hasPerms) {
      await fetchDailyData();
    } else {
      // Don't auto-request, wait for user action or just set loading false
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> requestSync() async {
    state = state.copyWith(isLoading: true);
    
    final granted = await HealthService.requestPermissions();
    if (granted) {
      await fetchDailyData();
    } else {
      state = state.copyWith(isLoading: false, isConnected: false);
    }
  }

  Future<void> fetchDailyData() async {
    try {
      // Run fetches in parallel
      final results = await Future.wait([
        HealthService.getTodaySteps(),
        HealthService.getTodayCalories(),
      ]);
      
      state = state.copyWith(
        steps: results[0] as int,
        calories: results[1] as int,
        isConnected: true,
        isLoading: false,
      );
    } catch (e) {
      debugPrint('Error fetching specific health data: $e');
      state = state.copyWith(isLoading: false);
    }
  }
}

final healthProvider = StateNotifierProvider<HealthNotifier, HealthState>((ref) {
  return HealthNotifier();
});
