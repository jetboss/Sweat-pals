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
  late DateTime _currentMonth;
  bool _isMonthView = false;
  
  @override
  void initState() {
    super.initState();
    // Start from Monday of current week
    final now = DateTime.now();
    _weekStart = now.subtract(Duration(days: now.weekday - 1));
    _currentMonth = DateTime(now.year, now.month, 1);
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

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
  }

  void _goToThisWeek() {
    final now = DateTime.now();
    setState(() {
      _weekStart = now.subtract(Duration(days: now.weekday - 1));
      _currentMonth = DateTime(now.year, now.month, 1);
    });
  }

  void _toggleView() {
    setState(() {
      _isMonthView = !_isMonthView;
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
          // View toggle button - use distinct icons
          IconButton(
            onPressed: _toggleView,
            icon: Icon(_isMonthView ? Icons.view_agenda_rounded : Icons.grid_view_rounded),
            tooltip: _isMonthView ? 'Week view' : 'Month view',
          ),
        ],
      ),
      body: Column(
        children: [
          // Header (week or month)
          _isMonthView ? _buildMonthHeader() : _buildWeekHeader(),
          
          // Body (week or month)
          Expanded(
            child: _isMonthView
                ? _buildMonthGrid(calendarNotifier)
                : ListView.builder(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100),
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
          
          // Extra space for FAB and nav bar
          const SizedBox(height: 80),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 90),
        child: FloatingActionButton.extended(
          onPressed: () => _showScheduleDialog(context),
          backgroundColor: AppColors.primary,
          icon: const Icon(Icons.add_rounded),
          label: const Text('Schedule'),
        ),
      ),
    );
  }

  Widget _buildMonthHeader() {
    final dateFormat = DateFormat('MMMM yyyy');
    final now = DateTime.now();
    final isCurrentMonth = _currentMonth.year == now.year && _currentMonth.month == now.month;

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
            onPressed: _previousMonth,
            icon: const Icon(Icons.chevron_left_rounded),
          ),
          Column(
            children: [
              Text(
                dateFormat.format(_currentMonth),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              if (isCurrentMonth)
                Text(
                  'This Month',
                  style: TextStyle(color: AppColors.primary, fontSize: 12),
                ),
            ],
          ),
          IconButton(
            onPressed: _nextMonth,
            icon: const Icon(Icons.chevron_right_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthGrid(WorkoutCalendarNotifier calendarNotifier) {
    final firstDayOfMonth = _currentMonth;
    final lastDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;
    
    // Get the weekday of the first day (1 = Monday, 7 = Sunday in Dart)
    final firstWeekday = firstDayOfMonth.weekday;
    
    // Calculate how many cells we need (leading empty + days in month)
    final leadingEmptyDays = firstWeekday - 1; // Monday = 0 empty, Sunday = 6 empty
    final totalCells = leadingEmptyDays + daysInMonth;
    final rows = (totalCells / 7).ceil();

    return Column(
      children: [
        // Day headers
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                .map((d) => Expanded(
                      child: Center(
                        child: Text(
                          d,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
        // Calendar grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 100),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: rows * 7,
            itemBuilder: (context, index) {
              final dayNumber = index - leadingEmptyDays + 1;
              
              if (dayNumber < 1 || dayNumber > daysInMonth) {
                return const SizedBox.shrink();
              }
              
              final date = DateTime(_currentMonth.year, _currentMonth.month, dayNumber);
              return _buildMonthDayCell(date, calendarNotifier);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMonthDayCell(DateTime date, WorkoutCalendarNotifier calendarNotifier) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final isToday = date.year == today.year && date.month == today.month && date.day == today.day;
    final isPast = date.isBefore(today);
    
    // Get scheduled workouts for this date
    final scheduled = calendarNotifier.getForDate(date);
    final hasWorkout = scheduled.isNotEmpty;
    final allCompleted = scheduled.isNotEmpty && scheduled.every((s) => s.isCompleted);
    final hasMissed = scheduled.any((s) => s.isMissed);

    return InkWell(
      onTap: isPast ? null : () {
        // Open schedule dialog with this date pre-selected
        _showScheduleDialog(context, selectedDate: date);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: isToday 
              ? AppColors.primary.withValues(alpha: 0.15)
              : hasWorkout 
                  ? (allCompleted ? Colors.green[50] : hasMissed ? Colors.red[50] : AppColors.primary.withValues(alpha: 0.05))
                  : null,
          borderRadius: BorderRadius.circular(8),
          border: isToday 
              ? Border.all(color: AppColors.primary, width: 2)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${date.day}',
              style: TextStyle(
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                color: isPast && !isToday ? Colors.grey[400] : null,
              ),
            ),
            if (hasWorkout)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    allCompleted 
                        ? Icons.check_circle 
                        : hasMissed 
                            ? Icons.cancel 
                            : Icons.fitness_center,
                    size: 12,
                    color: allCompleted 
                        ? Colors.green 
                        : hasMissed 
                            ? Colors.red 
                            : AppColors.primary,
                  ),
                ],
              ),
          ],
        ),
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
                  style: TextStyle(color: AppColors.primary, fontSize: 12),
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
      color: isToday ? AppColors.primary.withValues(alpha: 0.1) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isToday ? BorderSide(color: AppColors.primary, width: 2) : BorderSide.none,
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
                        color: isToday ? AppColors.primaryVariant : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat('MMM d').format(day),
                      style: TextStyle(
                        color: isToday ? AppColors.primary : Colors.grey[600],
                      ),
                    ),
                    if (isToday)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
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
                    : AppColors.primary,
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
                backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                foregroundColor: AppColors.primaryVariant,
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
          colors: [AppColors.primary, AppColors.primary],
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
                foregroundColor: AppColors.primaryVariant,
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
                      color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: isSelected 
                            ? BorderSide(color: AppColors.primary, width: 2) 
                            : BorderSide.none,
                      ),
                      child: ListTile(
                        onTap: () => setModalState(() => chosenWorkout = workout),
                        leading: Icon(
                          isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
                          color: isSelected ? AppColors.primary : Colors.grey[400],
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
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.primaryVariant,
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
