import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../models/scheduled_workout.dart';
import '../../models/workout.dart';
import '../../providers/workouts_provider.dart';
import '../../providers/workout_calendar_provider.dart';
import '../../providers/workout_progress_provider.dart';
import '../../theme/app_colors.dart';
import '../../utils/page_routes.dart';
import 'workout_timer_screen.dart';

class WorkoutCalendarScreen extends ConsumerStatefulWidget {
  const WorkoutCalendarScreen({super.key});

  @override
  ConsumerState<WorkoutCalendarScreen> createState() => _WorkoutCalendarScreenState();
}

class _WorkoutCalendarScreenState extends ConsumerState<WorkoutCalendarScreen> {
  late DateTime _weekStart;
  
  @override
  void initState() {
    super.initState();
    // Start from Monday of current week
    final now = DateTime.now();
    _weekStart = now.subtract(Duration(days: now.weekday - 1));
  }

  void _previousWeek() {
    setState(() {
      _weekStart = _weekStart.subtract(const Duration(days: 7));
    });
  }

  void _nextWeek() {
    setState(() {
      _weekStart = _weekStart.add(const Duration(days: 7));
    });
  }

  void _goToThisWeek() {
    final now = DateTime.now();
    setState(() {
      _weekStart = now.subtract(Duration(days: now.weekday - 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    final calendarNotifier = ref.watch(workoutCalendarProvider.notifier);
    final weekSchedule = calendarNotifier.getWeekSchedule(_weekStart);
    final todaysWorkouts = calendarNotifier.todaysWorkouts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Calendar'),
        actions: [
          IconButton(
            onPressed: _goToThisWeek,
            icon: const Icon(Icons.today_rounded),
            tooltip: 'Go to this week',
          ),
        ],
      ),
      body: Column(
        children: [
          // Week Navigation
          _buildWeekHeader(),
          
          // Week Days
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 7,
              itemBuilder: (context, index) {
                final day = DateTime(_weekStart.year, _weekStart.month, _weekStart.day + index);
                final scheduled = weekSchedule[day] ?? [];
                return _buildDayCard(context, day, scheduled);
              },
            ),
          ),
          
          // Today's Quick Actions
          if (todaysWorkouts.isNotEmpty)
            _buildTodaysBanner(todaysWorkouts),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showScheduleDialog(context),
        backgroundColor: AppColors.pinkAccent,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Schedule'),
      ),
    );
  }

  Widget _buildWeekHeader() {
    final weekEnd = _weekStart.add(const Duration(days: 6));
    final dateFormat = DateFormat('MMM d');
    final isCurrentWeek = _isCurrentWeek();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _previousWeek,
            icon: const Icon(Icons.chevron_left_rounded),
          ),
          Column(
            children: [
              Text(
                '${dateFormat.format(_weekStart)} - ${dateFormat.format(weekEnd)}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              if (isCurrentWeek)
                Text(
                  'This Week',
                  style: TextStyle(color: Colors.pink[400], fontSize: 12),
                ),
            ],
          ),
          IconButton(
            onPressed: _nextWeek,
            icon: const Icon(Icons.chevron_right_rounded),
          ),
        ],
      ),
    );
  }

  bool _isCurrentWeek() {
    final now = DateTime.now();
    final currentWeekStart = now.subtract(Duration(days: now.weekday - 1));
    return _weekStart.year == currentWeekStart.year &&
        _weekStart.month == currentWeekStart.month &&
        _weekStart.day == currentWeekStart.day;
  }

  Widget _buildDayCard(BuildContext context, DateTime day, List<ScheduledWorkout> scheduled) {
    final calendarNotifier = ref.watch(workoutCalendarProvider.notifier);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final isToday = day.year == today.year && day.month == today.month && day.day == today.day;
    final isPast = day.isBefore(today);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isToday ? Colors.pink[50] : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isToday ? BorderSide(color: Colors.pink[300]!, width: 2) : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      DateFormat('EEE').format(day),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isToday ? Colors.pink[700] : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat('MMM d').format(day),
                      style: TextStyle(
                        color: isToday ? Colors.pink[400] : Colors.grey[600],
                      ),
                    ),
                    if (isToday)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.pink[400],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'TODAY',
                          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
                if (!isPast)
                  IconButton(
                    onPressed: () => _showScheduleDialog(context, selectedDate: day),
                    icon: const Icon(Icons.add_circle_outline_rounded),
                    iconSize: 20,
                    color: Colors.grey[400],
                  ),
              ],
            ),
            if (scheduled.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  isPast ? 'Rest day' : 'No workout scheduled',
                  style: TextStyle(color: Colors.grey[500], fontStyle: FontStyle.italic),
                ),
              )
            else
              ...scheduled.map((s) => _buildScheduledWorkoutTile(s, calendarNotifier, isPast)),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduledWorkoutTile(ScheduledWorkout scheduled, WorkoutCalendarNotifier notifier, bool isPast) {
    final workout = notifier.getWorkoutForSchedule(scheduled);
    if (workout == null) return const SizedBox.shrink();

    final isMissed = scheduled.isMissed;
    final isCompleted = scheduled.isCompleted;

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCompleted 
            ? Colors.green[50] 
            : isMissed 
                ? Colors.red[50] 
                : Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isCompleted 
              ? Colors.green[200]! 
              : isMissed 
                  ? Colors.red[200]! 
                  : Colors.grey[300]!,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isCompleted 
                ? Icons.check_circle_rounded 
                : isMissed 
                    ? Icons.cancel_rounded 
                    : Icons.fitness_center_rounded,
            color: isCompleted 
                ? Colors.green[600] 
                : isMissed 
                    ? Colors.red[400] 
                    : Colors.pink[400],
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workout.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                Text(
                  '${workout.durationMinutes} min • ${workout.levelDisplayName}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          if (!isCompleted && !isMissed)
            ElevatedButton(
              onPressed: () {
                HapticFeedback.mediumImpact();
                context.pushAnimated(WorkoutTimerScreen(workout: workout)).then((_) {
                  // Mark as complete when returning
                  ref.read(workoutCalendarProvider.notifier).markComplete(scheduled.id);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[100],
                foregroundColor: Colors.pink[700],
                minimumSize: const Size(60, 32),
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              child: const Text('Start'),
            )
          else if (isCompleted)
            const Chip(
              label: Text('Done!', style: TextStyle(fontSize: 11)),
              backgroundColor: Colors.transparent,
              side: BorderSide.none,
              padding: EdgeInsets.zero,
            ),
          IconButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              ref.read(workoutCalendarProvider.notifier).removeScheduledWorkout(scheduled.id);
            },
            icon: Icon(Icons.close_rounded, size: 18, color: Colors.grey[400]),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaysBanner(List<ScheduledWorkout> todaysWorkouts) {
    final notifier = ref.watch(workoutCalendarProvider.notifier);
    final incompleteCount = todaysWorkouts.where((s) => !s.isCompleted).length;
    
    if (incompleteCount == 0) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink[400]!, Colors.pink[300]!],
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            const Icon(Icons.local_fire_department_rounded, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '$incompleteCount workout${incompleteCount > 1 ? 's' : ''} left today!',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                final incomplete = todaysWorkouts.firstWhere((s) => !s.isCompleted);
                final workout = notifier.getWorkoutForSchedule(incomplete);
                if (workout != null) {
                  context.pushAnimated(WorkoutTimerScreen(workout: workout));
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.pink[700],
              ),
              child: const Text('Let\'s Go!'),
            ),
          ],
        ),
      ),
    );
  }

  void _showScheduleDialog(BuildContext context, {DateTime? selectedDate}) {
    final progressNotifier = ref.read(workoutProgressProvider.notifier);
    final allWorkouts = ref.read(workoutsProvider);
    final unlockedWorkouts = allWorkouts.where((w) => progressNotifier.isUnlocked(w.id)).toList();

    DateTime chosenDate = selectedDate ?? DateTime.now();
    Workout? chosenWorkout;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Schedule Workout',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(ctx),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Date Picker
              const Text('Date', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: chosenDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) {
                    setModalState(() => chosenDate = picked);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_rounded, size: 20),
                      const SizedBox(width: 12),
                      Text(DateFormat('EEEE, MMM d, yyyy').format(chosenDate)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Workout Picker
              const Text('Workout', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: unlockedWorkouts.length,
                  itemBuilder: (context, index) {
                    final workout = unlockedWorkouts[index];
                    final isSelected = chosenWorkout?.id == workout.id;
                    return Card(
                      color: isSelected ? Colors.pink[50] : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: isSelected 
                            ? BorderSide(color: Colors.pink[300]!, width: 2) 
                            : BorderSide.none,
                      ),
                      child: ListTile(
                        onTap: () => setModalState(() => chosenWorkout = workout),
                        leading: Icon(
                          isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
                          color: isSelected ? Colors.pink[400] : Colors.grey[400],
                        ),
                        title: Text(workout.title),
                        subtitle: Text('${workout.durationMinutes} min • ${workout.levelDisplayName}'),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              
              // Schedule Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: chosenWorkout == null
                      ? null
                      : () {
                          HapticFeedback.mediumImpact();
                          ref.read(workoutCalendarProvider.notifier).scheduleWorkout(
                            chosenWorkout!.id,
                            chosenDate,
                          );
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${chosenWorkout!.title} scheduled for ${DateFormat('EEE, MMM d').format(chosenDate)}'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.pinkAccent,
                    foregroundColor: Colors.pink[700],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Schedule Workout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
