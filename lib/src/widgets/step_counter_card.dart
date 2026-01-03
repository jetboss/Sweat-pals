import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/pedometer_provider.dart';
import '../services/pedometer_service.dart';
import '../theme/app_colors.dart';

/// Card widget displaying today's step count using phone's pedometer
class StepCounterCard extends ConsumerWidget {
  const StepCounterCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepsAsync = ref.watch(pedometerProvider);
    final stepGoal = ref.watch(stepGoalProvider);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showDetailsSheet(context, ref),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: stepsAsync.when(
            loading: () => const _LoadingState(),
            error: (e, _) => _ErrorState(
              error: e.toString(),
              onRetry: () async {
                await PedometerService.instance.requestPermission();
                ref.invalidate(pedometerProvider);
              },
            ),
            data: (steps) => _DataState(
              steps: steps,
              goal: stepGoal,
            ),
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
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.directions_walk, color: AppColors.primary),
                const SizedBox(width: 8),
                const Text(
                  'Step Counter',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Steps are counted using your phone\'s motion sensor. '
              'Keep your phone with you while walking for accurate tracking.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  // TODO: Navigate to Track Walk screen
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Track a Walk with GPS'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
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
            Text('Starting step counter...', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Awaiting sensor', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _ErrorState({required this.error, required this.onRetry});

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
              const Text('Enable Step Counting', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Grant activity permission', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: onRetry,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          child: const Text('Enable'),
        ),
      ],
    );
  }
}

class _DataState extends StatelessWidget {
  final int steps;
  final int goal;

  const _DataState({
    required this.steps,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (steps / goal).clamp(0.0, 1.0);
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
                  Icon(Icons.phone_android, size: 14, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    'Phone pedometer',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
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
