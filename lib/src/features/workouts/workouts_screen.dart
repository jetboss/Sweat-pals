import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/workout.dart';
import '../../models/workout_progress.dart';
import '../../providers/workouts_provider.dart';
import '../../providers/workout_progress_provider.dart';
import '../../providers/avatar_provider.dart';
import '../../theme/app_colors.dart';
import '../../utils/page_routes.dart';
import 'workout_timer_screen.dart';
import '../gamification/sweat_pal_avatar.dart';
import '../../widgets/walk_workout_card.dart';

import 'create_workout_screen.dart';

class WorkoutsScreen extends ConsumerStatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  ConsumerState<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends ConsumerState<WorkoutsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  WorkoutLevel? _selectedLevel;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    setState(() {
      switch (_tabController.index) {
        case 0:
          _selectedLevel = null;
          break;
        case 1:
          _selectedLevel = WorkoutLevel.beginner;
          break;
        case 2:
          _selectedLevel = WorkoutLevel.intermediate;
          break;
        case 3:
          _selectedLevel = WorkoutLevel.advanced;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final allWorkouts = ref.watch(workoutsProvider);
    final progressNotifier = ref.watch(workoutProgressProvider.notifier);
    final progress = ref.watch(workoutProgressProvider);
    final history = ref.watch(workoutsProvider.notifier).getHistory();

    // Filter workouts by selected level
    final workouts = _selectedLevel == null
        ? allWorkouts
        : allWorkouts.where((w) => w.level == _selectedLevel).toList();

    // Get recommended workouts
    final recommended = progressNotifier.getRecommendedWorkouts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Programs'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: [
            Tab(text: 'All (${allWorkouts.length})'),
            Tab(text: 'Beginner (${allWorkouts.where((w) => w.level == WorkoutLevel.beginner).length})'),
            Tab(text: 'Intermediate (${allWorkouts.where((w) => w.level == WorkoutLevel.intermediate).length})'),
            Tab(text: 'Advanced (${allWorkouts.where((w) => w.level == WorkoutLevel.advanced).length})'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SweatPal Avatar
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Column(
                  children: [
                    SweatPalAvatar(
                      state: ref.watch(avatarProvider),
                      size: 140,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.local_fire_department, color: Colors.orange, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            "Level ${ref.watch(avatarProvider).level} • ${progress.currentStreak} Day Streak",
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Walk Workout Card (step count + GPS tracking)
            const WalkWorkoutCard(),
            const SizedBox(height: 16),

            // Stats Row
            _buildStatsRow(progress),
            const SizedBox(height: 24),

            // Recommended Section (only show on All tab)
            if (_selectedLevel == null && recommended.isNotEmpty) ...[
              Text(
                "Recommended for You",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommended.length,
                  itemBuilder: (context, index) => _buildRecommendedCard(context, recommended[index], progressNotifier),
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Workouts List
            Text(
              _selectedLevel == null ? "All Programs" : "${_selectedLevel!.name.toUpperCase()} Programs",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...workouts.map((w) => _buildWorkoutCard(context, w, progressNotifier)),

            // History Section
            if (history.isNotEmpty) ...[
              const SizedBox(height: 32),
              Text(
                "Recent Sessions",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...history.take(3).map((s) => _buildHistoryItem(s, allWorkouts)),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateWorkoutScreen()),
          );
        },
        label: const Text('Create'),
        icon: const Icon(Icons.add),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  Widget _buildStatsRow(WorkoutProgress progress) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.pinkPastel, AppColors.tealAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('🔥', '${progress.currentStreak}', 'Day Streak'),
          _buildStatItem('💪', '${progress.totalWorkoutsCompleted}', 'Workouts'),
          _buildStatItem('🏆', '${progress.longestStreak}', 'Best Streak'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String emoji, String value, String label) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    );
  }

  Widget _buildRecommendedCard(BuildContext context, Workout workout, WorkoutProgressNotifier progressNotifier) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        context.pushAnimated(WorkoutTimerScreen(workout: workout));
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade100, Colors.pink.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              workout.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Icon(Icons.timer_outlined, size: 14, color: Colors.pink[700]),
                const SizedBox(width: 4),
                Text('${workout.durationMinutes} min', style: TextStyle(color: Colors.pink[700])),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutCard(BuildContext context, Workout workout, WorkoutProgressNotifier progressNotifier) {
    final isUnlocked = progressNotifier.isUnlocked(workout.id);
    final completionCount = progressNotifier.getCompletionCount(workout.id);
    final unlockProgress = progressNotifier.getUnlockProgress(workout);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: Opacity(
        opacity: isUnlocked ? 1.0 : 0.6,
        child: InkWell(
          onTap: isUnlocked
              ? () {
                  HapticFeedback.lightImpact();
                  context.pushAnimated(WorkoutTimerScreen(workout: workout));
                }
              : () => _showLockedDialog(context, workout, progressNotifier),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (!isUnlocked)
                                const Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Icon(Icons.lock_rounded, size: 18, color: Colors.grey),
                                ),
                              if (workout.isChallenge)
                                const Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Icon(Icons.emoji_events_rounded, size: 18, color: Colors.amber),
                                ),
                              Expanded(
                                child: Text(
                                  workout.title,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            workout.description,
                            style: TextStyle(color: Colors.grey[600], fontSize: 14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (isUnlocked)
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              HapticFeedback.mediumImpact();
                              context.pushAnimated(WorkoutTimerScreen(workout: workout));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.pinkPastel,
                              foregroundColor: Colors.pink[700],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text("Start"),
                          ),
                          if (completionCount > 0)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                '${completionCount}x done',
                                style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                              ),
                            ),
                          if (workout.isCustom)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: IconButton(
                                onPressed: () => _confirmDelete(context, workout),
                                icon: const Icon(Icons.delete_outline, size: 20, color: Colors.grey),
                                tooltip: 'Delete',
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                style: const ButtonStyle(
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildChip(_getLevelColor(workout.level), workout.levelDisplayName),
                    const SizedBox(width: 8),
                    _buildChip(Colors.grey[200]!, workout.categoryDisplayName),
                    const SizedBox(width: 8),
                    _buildChip(Colors.grey[200]!, '${workout.totalDurationMinutes} min', icon: Icons.timer_outlined),
                  ],
                ),
                if (!isUnlocked) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: unlockProgress,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.pink[300]!),
                            minHeight: 6,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        progressNotifier.getUnlockText(workout),
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getLevelColor(WorkoutLevel level) {
    switch (level) {
      case WorkoutLevel.beginner:
        return Colors.green[100]!;
      case WorkoutLevel.intermediate:
        return Colors.orange[100]!;
      case WorkoutLevel.advanced:
        return Colors.red[100]!;
    }
  }

  Widget _buildChip(Color color, String label, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: Colors.grey[700]),
            const SizedBox(width: 4),
          ],
          Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[700])),
        ],
      ),
    );
  }

  void _showLockedDialog(BuildContext context, Workout workout, WorkoutProgressNotifier progressNotifier) {
    HapticFeedback.heavyImpact();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.lock_rounded, color: Colors.grey),
            const SizedBox(width: 8),
            Expanded(child: Text(workout.title)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('This workout is locked!'),
            const SizedBox(height: 16),
            const Text(
              'To unlock:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(progressNotifier.getUnlockText(workout)),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progressNotifier.getUnlockProgress(workout),
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.pink[300]!),
                minHeight: 8,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(WorkoutSession session, List<Workout> workouts) {
    final workout = workouts.firstWhere((w) => w.id == session.workoutId, orElse: () => workouts.first);
    return ListTile(
      leading: const Icon(Icons.check_circle, color: Colors.teal),
      title: Text(workout.title),
      subtitle: Text("${session.completedAt.day}/${session.completedAt.month} • ${(session.totalDurationSeconds / 60).ceil()} mins"),
    );
  }

  void _confirmDelete(BuildContext context, Workout workout) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Workout'),
        content: Text('Are you sure you want to delete "${workout.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(workoutsProvider.notifier).deleteCustomWorkout(workout.id);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Workout deleted')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
