import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/workout.dart';
import '../../providers/workouts_provider.dart';
import '../../providers/workout_progress_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/exercise_video_player.dart';

class WorkoutTimerScreen extends ConsumerStatefulWidget {
  final Workout workout;

  const WorkoutTimerScreen({super.key, required this.workout});

  @override
  ConsumerState<WorkoutTimerScreen> createState() => _WorkoutTimerScreenState();
}

class _WorkoutTimerScreenState extends ConsumerState<WorkoutTimerScreen> {
  int _currentExerciseIndex = 0;
  int _secondsLeft = 0;
  bool _isRunning = false;
  Timer? _timer;
  int _totalElapsedSeconds = 0;

  @override
  void initState() {
    super.initState();
    _resetExercise();
  }

  void _resetExercise() {
    final ex = widget.workout.exercises[_currentExerciseIndex];
    setState(() {
      _secondsLeft = ex.durationSeconds > 0 ? ex.durationSeconds : 30; // 30s default for rep-based
      _isRunning = false;
    });
    _timer?.cancel();
  }

  void _toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_secondsLeft > 0) {
          setState(() {
            _secondsLeft--;
            _totalElapsedSeconds++;
          });
        } else {
          _nextExercise();
        }
      });
    }
    setState(() => _isRunning = !_isRunning);
  }

  void _nextExercise() {
    _timer?.cancel();
    if (_currentExerciseIndex < widget.workout.exercises.length - 1) {
      setState(() {
        _currentExerciseIndex++;
        _resetExercise();
      });
    } else {
      _finishWorkout();
    }
  }

  void _finishWorkout() async {
    final session = WorkoutSession(
      workoutId: widget.workout.id,
      completedAt: DateTime.now(),
      totalDurationSeconds: _totalElapsedSeconds,
    );
    await ref.read(workoutsProvider.notifier).saveSession(session);
    
    // Track progress and check for unlocks
    final newlyUnlocked = await ref.read(workoutProgressProvider.notifier).completeWorkout(widget.workout.id);
    
    if (mounted) {
      HapticFeedback.heavyImpact();
      _showHighFive(newlyUnlocked);
    }
  }

  void _showHighFive(List<String> newlyUnlocked) {
    final allWorkouts = ref.read(workoutsProvider);
    final unlockedWorkouts = newlyUnlocked
        .map((id) => allWorkouts.firstWhere((w) => w.id == id, orElse: () => allWorkouts.first))
        .toList();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Center(child: Text("🙌 HIGH FIVE!")),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "High five, sweat pal – we're getting stronger!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 20),
            Text("Duration: ${(_totalElapsedSeconds/60).ceil()} mins"),
            if (unlockedWorkouts.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 12),
              const Text(
                "🔓 UNLOCKED!",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
              ),
              const SizedBox(height: 8),
              ...unlockedWorkouts.map((w) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.fitness_center_rounded, size: 16, color: Colors.pink),
                    const SizedBox(width: 8),
                    Text(w.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              )),
            ],
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // dialog
                Navigator.of(context).pop(); // timer screen
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.pinkPastel),
              child: const Text("Awesome!"),
            ),
          ),
        ],
      ),
    );
  }

  void _showVideoPlayer(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: ExerciseVideoPlayer(videoUrl: url),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.workout.exercises[_currentExerciseIndex];
    final progress = 1.0 - (_secondsLeft / (exercise.durationSeconds > 0 ? exercise.durationSeconds : 30));

    return Scaffold(
      appBar: AppBar(title: Text(widget.workout.title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Step ${_currentExerciseIndex + 1} of ${widget.workout.exercises.length}",
                style: const TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 12),
              Text(
                exercise.name,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.pink),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              if (exercise.imageUrl != null)
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: exercise.imageUrl!,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: 180,
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 180,
                          color: Colors.grey[200],
                          child: const Icon(Icons.fitness_center_rounded, size: 64, color: Colors.grey),
                        ),
                      ),
                    ),
                    if (exercise.videoUrl != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton.filled(
                          onPressed: () => _showVideoPlayer(context, exercise.videoUrl!),
                          icon: const Icon(Icons.play_circle_fill_rounded, size: 32),
                          style: IconButton.styleFrom(backgroundColor: Colors.pink.withValues(alpha: 0.8)),
                        ),
                      ),
                  ],
                )
              else
                const SizedBox(height: 20),
              const SizedBox(height: 24),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 12,
                      color: Colors.pink[100],
                      backgroundColor: Colors.pink[50],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        _secondsLeft.toString(),
                        style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        exercise.durationSeconds > 0 ? "SECONDS" : "REPS: ${exercise.reps}",
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 48),
              Text(
                exercise.instructions,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton.filledTonal(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      if (_currentExerciseIndex > 0) {
                        setState(() {
                          _currentExerciseIndex--;
                          _resetExercise();
                        });
                      }
                    },
                    icon: const Icon(Icons.skip_previous_rounded),
                  ),
                  FloatingActionButton.large(
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      _toggleTimer();
                    },
                    backgroundColor: AppColors.pinkPastel,
                    child: Icon(_isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded, size: 48, color: Colors.pink[700]),
                  ),
                  IconButton.filledTonal(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      _nextExercise();
                    },
                    icon: const Icon(Icons.skip_next_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Bottom spacer for scrolling
            ],
          ),
        ),
      ),
    );
  }
}
