import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/health_service.dart';

class HealthState {
  final int stepCount;
  final bool isLoading;
  final String? error;
  final bool isConnected;
  final int steps;
  final int calories;

  HealthState({
    this.stepCount = 0,
    this.isLoading = false,
    this.error,
    this.isConnected = false,
    this.steps = 0,
    this.calories = 0,
  });

  HealthState copyWith({
    int? stepCount,
    bool? isLoading,
    String? error,
    bool? isConnected,
    int? steps,
    int? calories,
  }) {
    return HealthState(
      stepCount: stepCount ?? this.stepCount,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isConnected: isConnected ?? this.isConnected,
      steps: steps ?? this.steps,
      calories: calories ?? this.calories,
    );
  }
}

class HealthNotifier extends Notifier<HealthState> {
  final HealthService _healthService = HealthService();

  @override
  HealthState build() {
    // Defer side effect to avoid modifying state during build
    Future.microtask(() => _loadSteps());
    return HealthState();
  }

  Future<void> _loadSteps() async {
    state = state.copyWith(isLoading: true);
    
    try {
      final steps = await HealthService.getTodaySteps();
      int calories = await HealthService.getTodayCalories();
      
      // Fallback calorie calculation if Health API returns suspiciously low values
      if (calories < steps * 0.02) {
        calories = (steps * 0.04).round();  // ~0.04 cal/step average
      }
      
      state = state.copyWith(
        stepCount: steps,
        steps: steps,
        calories: calories,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    await _loadSteps();
  }

  Future<void> requestSync() async {
    state = state.copyWith(isLoading: true);
    try {
      final steps = await HealthService.getTodaySteps();
      int calories = await HealthService.getTodayCalories();
      
      // Fallback: If Health API returns 0 or suspiciously low calories, calculate from steps
      // Average person burns ~0.04-0.05 calories per step (varies by weight)
      // Using 0.04 as conservative estimate
      if (calories < steps * 0.02) {  // If less than 2 cal per 100 steps, it's wrong
        calories = (steps * 0.04).round();  // ~280 cal for 7000 steps
      }
      
      state = state.copyWith(
        stepCount: steps,
        steps: steps,
        calories: calories,
        isLoading: false,
        isConnected: true,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

final healthProvider = NotifierProvider<HealthNotifier, HealthState>(() {
  return HealthNotifier();
});
