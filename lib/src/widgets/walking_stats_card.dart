import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/health_provider.dart';
import '../services/health_service.dart';
import '../theme/app_colors.dart';

/// Card widget displaying today's walking stats with a progress ring
class WalkingStatsCard extends ConsumerWidget {
  const WalkingStatsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthData = ref.watch(healthDataProvider);
    final stepGoal = ref.watch(stepGoalProvider);
    final hasPermissions = ref.watch(healthPermissionsProvider);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showDetailsSheet(context, ref),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: healthData.when(
            loading: () => const _LoadingState(),
            error: (e, _) => _ErrorState(onRetry: () => ref.read(healthDataProvider.notifier).requestAndRefresh()),
            data: (data) {
              // Show connect prompt only if permissions not granted
              final permGranted = hasPermissions.valueOrNull ?? false;
              if (!permGranted) {
                return _PromptConnectState(
                  onConnect: () => ref.read(healthDataProvider.notifier).requestAndRefresh(),
                );
              }
              // Show actual step data (even if 0 - they may just not have walked yet)
              return _DataState(
                steps: data.steps,
                distanceKm: data.distanceKm,
                goal: stepGoal,
                progress: data.progressToGoal(goal: stepGoal),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showDetailsSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _DebugInfoSheet(ref: ref),
    );
  }
}

/// Debug sheet showing Health Connect diagnostic info
class _DebugInfoSheet extends ConsumerStatefulWidget {
  final WidgetRef ref;
  const _DebugInfoSheet({required this.ref});

  @override
  ConsumerState<_DebugInfoSheet> createState() => _DebugInfoSheetState();
}

class _DebugInfoSheetState extends ConsumerState<_DebugInfoSheet> {
  String _debugInfo = 'Loading...';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _runDiagnostics();
  }

  Future<void> _runDiagnostics() async {
    final buffer = StringBuffer();
    
    try {
      buffer.writeln('=== Health Connect Diagnostics ===\n');
      
      // Check availability
      final health = await HealthService.isHealthConnectAvailable();
      buffer.writeln('1. Health Connect Available: $health');
      
      // Check permissions
      final perms = await HealthService.hasPermissions();
      buffer.writeln('2. Permissions Granted: $perms');
      
      // Try to get steps
      final steps = await HealthService.getTodaySteps();
      buffer.writeln('3. Today\'s Steps: $steps');
      
      // Try to get distance
      final distance = await HealthService.getTodayDistance();
      buffer.writeln('4. Today\'s Distance: ${distance.toStringAsFixed(2)} m');
      
      buffer.writeln('\n--- If steps=0, Samsung Health may not be syncing to Health Connect ---');
      
    } catch (e) {
      buffer.writeln('ERROR: $e');
    }
    
    setState(() {
      _debugInfo = buffer.toString();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bug_report, color: Colors.orange),
              const SizedBox(width: 8),
              const Text(
                'Health Connect Debug',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              if (_isLoading)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _debugInfo,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _debugInfo = 'Re-running...';
                });
                _runDiagnostics();
              },
              child: const Text('Run Diagnostics Again'),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(strokeWidth: 3),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Loading steps...', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Syncing with Health', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}

class _ErrorState extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorState({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.directions_walk, color: Colors.grey),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Connect Health', style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('Tap to sync your steps', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
        TextButton(
          onPressed: onRetry,
          child: const Text('Connect'),
        ),
      ],
    );
  }
}

class _PromptConnectState extends StatelessWidget {
  final VoidCallback onConnect;

  const _PromptConnectState({required this.onConnect});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.directions_walk, color: AppColors.primary, size: 32),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Track Your Steps', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              Text('Connect to Health to sync your walking data', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: onConnect,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text('Connect'),
        ),
      ],
    );
  }
}

class _DataState extends StatelessWidget {
  final int steps;
  final double distanceKm;
  final int goal;
  final double progress;

  const _DataState({
    required this.steps,
    required this.distanceKm,
    required this.goal,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final isGoalReached = steps >= goal;

    return Row(
      children: [
        // Progress Ring
        SizedBox(
          width: 70,
          height: 70,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 6,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isGoalReached ? Colors.green : AppColors.primary,
                  ),
                ),
              ),
              Icon(
                isGoalReached ? Icons.check : Icons.directions_walk,
                color: isGoalReached ? Colors.green : AppColors.primary,
                size: 28,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // Stats
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    _formatSteps(steps),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '/ ${_formatSteps(goal)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  if (isGoalReached) ...[
                    const SizedBox(width: 8),
                    const Icon(Icons.celebration, color: Colors.amber, size: 20),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.straighten, size: 14, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    '${distanceKm.toStringAsFixed(1)} km',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                  const SizedBox(width: 12),
                  Icon(Icons.local_fire_department, size: 14, color: Colors.orange[400]),
                  const SizedBox(width: 4),
                  Text(
                    '${(steps * 0.04).toInt()} cal',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Chevron
        Icon(Icons.chevron_right, color: Colors.grey[400]),
      ],
    );
  }

  String _formatSteps(int steps) {
    if (steps >= 1000) {
      return '${(steps / 1000).toStringAsFixed(1)}K';
    }
    return steps.toString();
  }
}

class _WeeklyChartSheet extends ConsumerWidget {
  const _WeeklyChartSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyData = ref.watch(weeklyStepsProvider);
    final stepGoal = ref.watch(stepGoalProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.directions_walk, color: AppColors.primary),
              const SizedBox(width: 8),
              const Text(
                'Weekly Steps',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => ref.refresh(weeklyStepsProvider),
              ),
            ],
          ),
          const SizedBox(height: 20),
          weeklyData.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (data) => _WeeklyBarChart(data: data, goal: stepGoal),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _WeeklyBarChart extends StatelessWidget {
  final List<dynamic> data;
  final int goal;

  const _WeeklyBarChart({required this.data, required this.goal});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    final maxSteps = data.fold<int>(goal, (max, d) => d.steps > max ? d.steps : max);
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return SizedBox(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(data.length, (index) {
          final d = data[index];
          final double heightPercent = maxSteps > 0 ? (d.steps.toDouble() / maxSteps.toDouble()) : 0.0;
          final isGoalReached = d.steps >= goal;
          final dayIndex = d.date.weekday - 1;

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                _formatStepsShort(d.steps),
                style: TextStyle(
                  fontSize: 10,
                  color: isGoalReached ? Colors.green : Colors.grey[600],
                  fontWeight: isGoalReached ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 30,
                height: 100 * heightPercent,
                decoration: BoxDecoration(
                  color: isGoalReached ? Colors.green : AppColors.primary.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                days[dayIndex],
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
            ],
          );
        }),
      ),
    );
  }

  String _formatStepsShort(int steps) {
    if (steps >= 1000) {
      return '${(steps / 1000).toStringAsFixed(0)}K';
    }
    return steps.toString();
  }
}
