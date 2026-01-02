import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import '../../models/workout.dart';
import '../../providers/workouts_provider.dart';
import '../../providers/workout_progress_provider.dart';
import 'package:lottie/lottie.dart';
import '../../theme/app_colors.dart';
import '../../services/audio_service.dart';
import '../../services/sensory_service.dart';

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
  bool _isResting = false; // New state for rest mode
  Timer? _timer;
  int _totalElapsedSeconds = 0;
  late ConfettiController _confettiController;
  final WorkoutAudioService _audioService = WorkoutAudioService();

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _resetExercise();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _confettiController.dispose();
    _audioService.stop();
    super.dispose();
  }

  void _resetExercise({bool autoStart = false}) {
    final ex = widget.workout.exercises[_currentExerciseIndex];
    
    // Announce exercise if autostarting or initializing
    if (autoStart) {
       _audioService.speak("Begin ${ex.name}");
    }
    
    setState(() {
      _isResting = false;
      _secondsLeft = ex.durationSeconds > 0 ? ex.durationSeconds : 30; // 30s default for rep-based
      _isRunning = false;
    });
    _timer?.cancel();
    if (autoStart) {
      SensoryService().engage();
      _toggleTimer();
    }
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
            if (_secondsLeft > 0 && _secondsLeft <= 3) {
              SensoryService().tick();
            }
          });
        } else {
          _handleTimerComplete();
        }
      });
    }
    setState(() => _isRunning = !_isRunning);
  }

  void _handleTimerComplete() {
    _timer?.cancel();
    
    if (_isResting) {
      // Rest finished, start next exercise
       if (_currentExerciseIndex < widget.workout.exercises.length - 1) {
        setState(() {
          _currentExerciseIndex++;
        });
        _resetExercise(autoStart: true);
       } else {
         _finishWorkout();
       }
    } else {
      if (_currentExerciseIndex < widget.workout.exercises.length - 1) {
        final nextExercise = widget.workout.exercises[_currentExerciseIndex + 1];
        
        // Announce Rest
        _audioService.speak("Rest for ten seconds. Next up, ${nextExercise.name}");
        
        setState(() {
          _isResting = true;
          _secondsLeft = 10; // 10s rest
          _isRunning = false;
        });
        _toggleTimer(); // Start rest timer
        SensoryService().engage();
      } else {
        _finishWorkout();
      }
    }
  }

  void _nextExercise() {
    // Manual skip
    _timer?.cancel();
    if (_currentExerciseIndex < widget.workout.exercises.length - 1) {
      setState(() {
        // If skipping during rest, we actually just want to start the next exercise immediately
        // If skipping during exercise, we move to next exercise (skipping rest for this one? or going to rest? Standard apps usually skip to next exercise).
        // Let's Skip to Next Exercise immediately.
        if (!_isResting) {
          _currentExerciseIndex++;
        }
        // If we were resting, index was already pointing to 'previous', so we need to increment? 
        // No, current logic: during rest, index is still on previous. 
        // So we ALWAYS increment index.
        else {
          _currentExerciseIndex++; 
        } 
        
        // Wait, if I am resting, index = 0. Next is 1.
        // If I skip rest, I want index = 1.
        // If I am exercising index = 0. Next is 1.
        // If I skip exercise, I want index = 1.
        // So always increment.
      });
      _resetExercise(autoStart: true); // Manual skip usually implies wanting to start next
    } else {
      _finishWorkout();
    }
  }

  void _finishWorkout() async {
    _audioService.speak("Workout complete! Congratulations!");
    final session = WorkoutSession(
      workoutId: widget.workout.id,
      completedAt: DateTime.now(),
      totalDurationSeconds: _totalElapsedSeconds,
    );
    await ref.read(workoutsProvider.notifier).saveSession(session);
    
    // Track progress and check for unlocks
    final newlyUnlocked = await ref.read(workoutProgressProvider.notifier).completeWorkout(widget.workout.id);
    
    if (mounted) {
      SensoryService().success();
      _showHighFive(newlyUnlocked);
    }
  }

  void _showHighFive(List<String> newlyUnlocked) {
    _confettiController.play();
    
    final allWorkouts = ref.read(workoutsProvider);
    final unlockedWorkouts = newlyUnlocked
        .map((id) => allWorkouts.firstWhere((w) => w.id == id, orElse: () => allWorkouts.first))
        .toList();

    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, anim1, anim2) {
        return Stack(
          children: [
            // Confetti overlay
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: pi / 2,
                maxBlastForce: 5,
                minBlastForce: 2,
                emissionFrequency: 0.05,
                numberOfParticles: 50,
                gravity: 0.1,
                shouldLoop: false,
                colors: const [
                  Colors.pink,
                  Colors.pinkAccent,
                  Colors.purple,
                  Colors.amber,
                  Colors.cyan,
                  Colors.green,
                ],
              ),
            ),
            // Dialog
            Center(
              child: Material(
                color: Colors.transparent,
                child: ScaleTransition(
                  scale: CurvedAnimation(
                    parent: anim1,
                    curve: Curves.elasticOut,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.pink.shade50],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Trophy emoji
                        const Text(
                          "🏆",
                          style: TextStyle(fontSize: 64),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "HIGH FIVE!",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Colors.pink,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "You crushed ${widget.workout.title}!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Stats row
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildStatPill("⏱", "${(_totalElapsedSeconds / 60).ceil()}", "mins"),
                              Container(width: 1, height: 30, color: Colors.grey[300]),
                              _buildStatPill("🔥", "${widget.workout.exercises.length}", "exercises"),
                            ],
                          ),
                        ),
                        // Unlocked workouts
                        if (unlockedWorkouts.isNotEmpty) ...[
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.amber.shade50,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.amber.shade200),
                            ),
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.lock_open_rounded, color: Colors.amber, size: 20),
                                    SizedBox(width: 8),
                                    Text(
                                      "NEW UNLOCKED!",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.amber,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                ...unlockedWorkouts.map((w) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2),
                                  child: Text(
                                    w.title,
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),
                        // CTA Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              HapticFeedback.mediumImpact();
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Awesome! 🙌",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatPill(String emoji, String value, String label) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.workout.exercises[_currentExerciseIndex];
    final totalTime = _isResting ? 10 : (exercise.durationSeconds > 0 ? exercise.durationSeconds : 30);
    final progress = 1.0 - (_secondsLeft / totalTime);

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
              if (_isResting) ...[
                 const Text(
                   "REST",
                   style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green),
                   textAlign: TextAlign.center,
                 ),
                 const SizedBox(height: 12),
                 if (_currentExerciseIndex < widget.workout.exercises.length - 1)
                   Text(
                     "Up Next: ${widget.workout.exercises[_currentExerciseIndex + 1].name}",
                     style: const TextStyle(fontSize: 18, color: AppColors.textSecondary),
                   ),
              ] else ...[
                 Text(
                   exercise.name,
                   style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.pink),
                   textAlign: TextAlign.center,
                 ),
              ],
              const SizedBox(height: 24),
              // Show media for Next exercise if resting
              Builder(
                builder: (context) {
                   final targetExercise = _isResting && (_currentExerciseIndex < widget.workout.exercises.length - 1)
                       ? widget.workout.exercises[_currentExerciseIndex + 1]
                       : exercise;
                   
                   if (targetExercise.lottieUrl != null) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          height: 220,
                          child: Lottie.network(
                            targetExercise.lottieUrl!,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                                return const Center(child: Icon(Icons.error, color: Colors.grey));
                            },
                          ),
                        ),
                      );
                   } else if (targetExercise.imageUrl != null) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: targetExercise.imageUrl!,
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            height: 220,
                            color: Colors.grey[200],
                            child: const Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) => const SizedBox(height: 220, child: Center(child: Icon(Icons.error))),
                        ),
                      );
                   }
                   return const SizedBox(height: 20);
                }
              ),
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
                      color: _isResting ? Colors.green[300] : Colors.pink[100],
                      backgroundColor: _isResting ? Colors.green[50] : Colors.pink[50],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        _secondsLeft.toString(),
                        style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _isResting ? "REST" : (exercise.durationSeconds > 0 ? "SECONDS" : "REPS: ${exercise.reps}"),
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
