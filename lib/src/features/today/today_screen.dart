import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../providers/user_provider.dart';
import '../../providers/workout_calendar_provider.dart';
import '../../providers/avatar_provider.dart';
import '../../providers/pedometer_provider.dart';
import '../../theme/app_colors.dart';
import '../../utils/page_routes.dart';
import '../tracking/tracking_provider.dart';
import '../workouts/workout_timer_screen.dart';
import '../journal/journal_provider.dart';
import '../journal/morning_prompt_screen.dart';
import '../journal/journal_screen.dart';
import '../gamification/sweat_pal_avatar.dart';
import '../gamification/achievements_screen.dart';
import '../review/progress_timeline_screen.dart';

/// Provider to track water intake (glasses per day, resets daily)
final waterIntakeProvider = StateProvider<int>((ref) => 0);

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final userName = user?.name ?? 'Sweat Pal';
    final now = DateTime.now();
    final greeting = _getGreeting(now.hour);
    
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Greeting
              _buildHeroGreeting(context, ref, greeting, userName),
              const SizedBox(height: 24),
              
              // Daily Checklist
              _buildDailyChecklist(context, ref),
              const SizedBox(height: 24),
              
              // Today's Workout
              _buildTodaysWorkout(context, ref),
              const SizedBox(height: 24),
              
              // Water Tracker
              _buildWaterTracker(context, ref),
              const SizedBox(height: 24),
              
              // Quick Actions
              _buildQuickActions(context),
              const SizedBox(height: 24),
              
              // Quick Stats
              _buildQuickStats(context, ref),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  String _getGreeting(int hour) {
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  Widget _buildHeroGreeting(BuildContext context, WidgetRef ref, String greeting, String name) {
    final avatarState = ref.watch(avatarProvider);
    final streak = ref.watch(trackingProvider.notifier).calculateStreak();
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.brandGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          SweatPalAvatar(state: avatarState, size: 70),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$greeting!',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
                Text(
                  name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.local_fire_department, color: Colors.orange, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '$streak day streak',
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            DateFormat('EEE\nMMM d').format(DateTime.now()),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyChecklist(BuildContext context, WidgetRef ref) {
    final journalEntries = ref.watch(journalProvider);
    final hasJournaled = journalEntries.any((e) => 
      e.date.year == DateTime.now().year && 
      e.date.month == DateTime.now().month && 
      e.date.day == DateTime.now().day
    );
    
    final steps = ref.watch(pedometerProvider).valueOrNull ?? 0;
    final stepGoal = ref.watch(stepGoalProvider);
    final stepsComplete = steps >= stepGoal;
    
    final todaysWorkouts = ref.watch(workoutCalendarProvider.notifier).todaysWorkouts;
    final workoutComplete = todaysWorkouts.isNotEmpty && todaysWorkouts.every((w) => w.isCompleted);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.checklist_rounded, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              "Today's Tasks",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _ChecklistItem(
          icon: Icons.edit_note_rounded,
          label: 'Complete morning journal',
          isComplete: hasJournaled,
          onTap: () => context.pushAnimated(const MorningPromptScreen()),
        ),
        _ChecklistItem(
          icon: Icons.directions_walk,
          label: 'Hit step goal (${steps.toString()}/$stepGoal)',
          isComplete: stepsComplete,
        ),
        _ChecklistItem(
          icon: Icons.fitness_center,
          label: 'Complete workout',
          isComplete: workoutComplete,
        ),
      ],
    );
  }

  Widget _buildTodaysWorkout(BuildContext context, WidgetRef ref) {
    final calendarNotifier = ref.watch(workoutCalendarProvider.notifier);
    final todaysWorkouts = calendarNotifier.todaysWorkouts;
    final incompleteWorkouts = todaysWorkouts.where((w) => !w.isCompleted).toList();

    if (incompleteWorkouts.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.calendar_today, color: Colors.grey),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('No workout scheduled', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Enjoy your rest day!', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    final scheduled = incompleteWorkouts.first;
    final workout = calendarNotifier.getWorkoutForSchedule(scheduled);
    
    if (workout == null) return const SizedBox.shrink();

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary.withValues(alpha: 0.1), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.fitness_center, color: AppColors.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('TODAY\'S WORKOUT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary, letterSpacing: 1)),
                        Text(workout.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _WorkoutStat(icon: Icons.timer, label: '${workout.durationMinutes} min'),
                  const SizedBox(width: 16),
                  _WorkoutStat(icon: Icons.signal_cellular_alt, label: workout.levelDisplayName),
                  const SizedBox(width: 16),
                  _WorkoutStat(icon: Icons.fitness_center, label: '${workout.exercises.length} exercises'),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    context.pushAnimated(WorkoutTimerScreen(workout: workout)).then((_) {
                      ref.read(workoutCalendarProvider.notifier).markComplete(scheduled.id);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Start Workout 💪', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWaterTracker(BuildContext context, WidgetRef ref) {
    final glasses = ref.watch(waterIntakeProvider);
    const goal = 8;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.water_drop, color: Colors.blue),
            const SizedBox(width: 8),
            Text(
              'Water Intake',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              '$glasses / $goal glasses',
              style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(goal, (index) {
            final isFilled = index < glasses;
            return GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                if (isFilled && index == glasses - 1) {
                  ref.read(waterIntakeProvider.notifier).state = glasses - 1;
                } else if (!isFilled) {
                  ref.read(waterIntakeProvider.notifier).state = index + 1;
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 36,
                height: 48,
                decoration: BoxDecoration(
                  color: isFilled ? Colors.blue : Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isFilled ? Colors.blue : Colors.blue.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.water_drop,
                  color: isFilled ? Colors.white : Colors.blue.withValues(alpha: 0.3),
                  size: 20,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildQuickStats(BuildContext context, WidgetRef ref) {
    final steps = ref.watch(pedometerProvider).valueOrNull ?? 0;
    final streak = ref.watch(trackingProvider.notifier).calculateStreak();
    final avatarLevel = ref.watch(avatarProvider).level;

    return Row(
      children: [
        Expanded(child: _QuickStatCard(icon: Icons.directions_walk, value: steps.toString(), label: 'Steps')),
        const SizedBox(width: 12),
        Expanded(child: _QuickStatCard(icon: Icons.local_fire_department, value: '$streak', label: 'Day Streak', color: Colors.orange)),
        const SizedBox(width: 12),
        Expanded(child: _QuickStatCard(icon: Icons.star, value: 'Lv $avatarLevel', label: 'Level', color: Colors.amber)),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.bolt_rounded, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _QuickActionButton(
                icon: Icons.emoji_events_rounded,
                label: 'Trophies',
                color: Colors.purple,
                onTap: () => context.pushAnimated(const AchievementsScreen()),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickActionButton(
                icon: Icons.book_rounded,
                label: 'Journal',
                color: Colors.teal,
                onTap: () => context.pushAnimated(const JournalScreen()),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickActionButton(
                icon: Icons.timeline_rounded,
                label: 'Progress',
                color: Colors.blue,
                onTap: () => context.pushAnimated(const ProgressTimelineScreen()),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ChecklistItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isComplete;
  final VoidCallback? onTap;

  const _ChecklistItem({
    required this.icon,
    required this.label,
    required this.isComplete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: isComplete ? null : onTap,
        leading: Icon(
          isComplete ? Icons.check_circle_rounded : icon,
          color: isComplete ? Colors.green : AppColors.primary,
        ),
        title: Text(
          label,
          style: TextStyle(
            decoration: isComplete ? TextDecoration.lineThrough : null,
            color: isComplete ? Colors.grey : null,
          ),
        ),
        trailing: isComplete 
            ? const Icon(Icons.done, color: Colors.green)
            : const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }
}

class _WorkoutStat extends StatelessWidget {
  final IconData icon;
  final String label;

  const _WorkoutStat({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }
}

class _QuickStatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color? color;

  const _QuickStatCard({
    required this.icon,
    required this.value,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.primary;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: c, size: 28),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: c)),
            Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
