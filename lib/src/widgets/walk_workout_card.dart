import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/pedometer_provider.dart';
import '../services/pedometer_service.dart';
import '../features/walks/track_walk_screen.dart';
import '../theme/app_colors.dart';

/// Workout-style card for walking that shows live step count and GPS tracking option
class WalkWorkoutCard extends ConsumerWidget {
  const WalkWorkoutCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepsAsync = ref.watch(pedometerProvider);
    final stepGoal = ref.watch(stepGoalProvider);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withValues(alpha: 0.15),
              AppColors.primary.withValues(alpha: 0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.directions_walk,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Outdoor Walk',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'GPS • Track your route',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Step count badge
                  stepsAsync.when(
                    loading: () => const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (steps) => _StepBadge(steps: steps, goal: stepGoal),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Today's progress
              stepsAsync.when(
                loading: () => const Text(
                  'Connecting to pedometer...',
                  style: TextStyle(color: Colors.grey),
                ),
                error: (e, _) => InkWell(
                  onTap: () async {
                    await PedometerService.instance.requestPermission();
                    ref.invalidate(pedometerProvider);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.warning_amber, color: Colors.orange, size: 16),
                      const SizedBox(width: 8),
                      const Text(
                        'Tap to enable step counting',
                        style: TextStyle(color: Colors.orange),
                      ),
                    ],
                  ),
                ),
                data: (steps) => _StepProgress(steps: steps, goal: stepGoal),
              ),
              
              const SizedBox(height: 16),
              
              // Start tracking button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TrackWalkScreen()),
                    );
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Start Walk'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepBadge extends StatelessWidget {
  final int steps;
  final int goal;

  const _StepBadge({required this.steps, required this.goal});

  @override
  Widget build(BuildContext context) {
    final progress = (steps / goal).clamp(0.0, 1.0);
    final isComplete = steps >= goal;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isComplete ? Colors.green : AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isComplete ? Icons.check : Icons.directions_walk,
            color: Colors.white,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            _formatSteps(steps),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  String _formatSteps(int steps) {
    if (steps >= 1000) {
      return '${(steps / 1000).toStringAsFixed(1)}K';
    }
    return steps.toString();
  }
}

class _StepProgress extends StatelessWidget {
  final int steps;
  final int goal;

  const _StepProgress({required this.steps, required this.goal});

  @override
  Widget build(BuildContext context) {
    final progress = (steps / goal).clamp(0.0, 1.0);
    final isComplete = steps >= goal;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Today: ${_formatSteps(steps)} steps',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              '${(progress * 100).toInt()}% of ${_formatSteps(goal)}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              isComplete ? Colors.green : AppColors.primary,
            ),
            minHeight: 6,
          ),
        ),
        if (isComplete) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.celebration, color: Colors.amber, size: 14),
              const SizedBox(width: 4),
              Text(
                'Goal reached! 🎉',
                style: TextStyle(color: Colors.green[700], fontSize: 12),
              ),
            ],
          ),
        ],
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
