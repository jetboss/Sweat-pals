import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'tracking_provider.dart';
import 'daily_check_in_form.dart';
import '../../utils/page_routes.dart';

class TrackingScreen extends ConsumerWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(trackingProvider);
    final streak = ref.read(trackingProvider.notifier).calculateStreak();

    return Scaffold(
      appBar: AppBar(title: const Text('Progress Tracking')),
      body: Column(
        children: [
          _buildStreakCard(context, streak),
          Expanded(
            child: entries.isEmpty
                ? const Center(child: Text('No check-ins yet. Start today!'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      return _buildEntryCard(context, entry);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushAnimated(const DailyCheckInForm()),
        label: const Text('Check-in'),
        icon: const Icon(Icons.add_rounded),
      ),
    );
  }

  Widget _buildStreakCard(BuildContext context, int streak) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          const Icon(Icons.local_fire_department_rounded, size: 64, color: Colors.orange),
          const SizedBox(height: 8),
          Text(
            '$streak Day Streak!',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Keep it up, pal!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildEntryCard(BuildContext context, dynamic entry) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(DateFormat('EEEE, MMM d').format(entry.date)),
        subtitle: Row(
          children: [
            _buildSmallTag(context, entry.followedMealPlan ? 'Meal Plan' : 'No Meal', entry.followedMealPlan),
            const SizedBox(width: 8),
            _buildSmallTag(context, entry.exerciseCompleted ? 'Exercise' : 'No Exercise', entry.exerciseCompleted),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (entry.mealPlanNotes.isNotEmpty) ...[
                  Text('Notes: ${entry.mealPlanNotes}'),
                  const SizedBox(height: 8),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sleep: ${entry.sleepHours.toStringAsFixed(1)}h'),
                    Text('Water: ${entry.drankWater ? '✅' : '❌'}'),
                    Text('Mood: ${'⭐' * entry.mood}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallTag(BuildContext context, String text, bool success) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: success ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: success ? Colors.green : Colors.red, width: 0.5),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: success ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
