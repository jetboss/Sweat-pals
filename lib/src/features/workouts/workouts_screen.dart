import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/workout.dart';
import '../../providers/workouts_provider.dart';
import '../../theme/app_colors.dart';
import 'workout_timer_screen.dart';

class WorkoutsScreen extends ConsumerWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workouts = ref.watch(workoutsProvider);
    final history = ref.watch(workoutsProvider.notifier).getHistory();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Pals'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Weekly Plan",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...workouts.map((w) => _buildWorkoutCard(context, w)),
            const SizedBox(height: 32),
            const Text(
              "Recent Progress",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (history.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text("No sessions yet. Let's start together!", style: TextStyle(color: AppColors.textSecondary)),
                ),
              )
            else
              ...history.take(3).map((s) => _buildHistoryItem(s, workouts)),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutCard(BuildContext context, Workout workout) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(workout.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(workout.description),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildChip(workout.category),
                const SizedBox(width: 8),
                _buildChip("${workout.totalDurationMinutes} mins", icon: Icons.timer_outlined),
              ],
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => WorkoutTimerScreen(workout: workout)),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.pinkPastel,
            foregroundColor: Colors.pink[700],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text("Start"),
        ),
      ),
    );
  }

  Widget _buildChip(String label, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.pinkPastel),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: AppColors.textSecondary),
            const SizedBox(width: 4),
          ],
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(WorkoutSession session, List<Workout> workouts) {
    final workout = workouts.firstWhere((w) => w.id == session.workoutId, orElse: () => workouts.first);
    return ListTile(
      leading: const Icon(Icons.check_circle, color: Colors.teal),
      title: Text(workout.title),
      subtitle: Text("${session.completedAt.day}/${session.completedAt.month} • ${(session.totalDurationSeconds/60).ceil()} mins"),
    );
  }
}
