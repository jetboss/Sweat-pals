import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/step_data.dart';
import '../services/health_service.dart';

/// Provider for today's health data
final todayHealthProvider = FutureProvider<StepData>((ref) async {
  return await HealthService.getTodayData();
});

/// Provider for weekly step data (for charts)
final weeklyStepsProvider = FutureProvider<List<StepData>>((ref) async {
  return await HealthService.getWeeklySteps();
});

/// Provider for checking if health permissions are granted
final healthPermissionsProvider = FutureProvider<bool>((ref) async {
  return await HealthService.hasPermissions();
});

/// State notifier for managing health data with refresh capability
class HealthDataNotifier extends StateNotifier<AsyncValue<StepData>> {
  HealthDataNotifier() : super(const AsyncValue.loading()) {
    refresh();
  }

  /// Refresh today's health data
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final data = await HealthService.getTodayData();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Request permissions and then refresh
  Future<bool> requestAndRefresh() async {
    final granted = await HealthService.requestPermissions();
    // Always refresh - user may have granted permissions manually
    await refresh();
    return granted;
  }
}

/// Provider for health data with refresh capability
final healthDataProvider = StateNotifierProvider<HealthDataNotifier, AsyncValue<StepData>>((ref) {
  return HealthDataNotifier();
});

/// Simple provider for step goal (default 10K)
final stepGoalProvider = StateProvider<int>((ref) => 10000);
