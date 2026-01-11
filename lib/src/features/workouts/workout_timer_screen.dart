import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confetti/confetti.dart';
import '../../models/workout.dart';
import '../../providers/workouts_provider.dart';
import '../../providers/workout_progress_provider.dart';
import '../../theme/app_colors.dart';
import '../../services/audio_service.dart';
import '../../services/sensory_service.dart';

class WorkoutTimerScreen extends ConsumerStatefulWidget {
  final Workout workout;

  const WorkoutTimerScreen({super.key, required this.workout});

  @override
  ConsumerState<WorkoutTimerScreen> createState() => _WorkoutTimerScreenState();
}

class _WorkoutTimerScreenState extends ConsumerState<WorkoutTimerScreen> with TickerProviderStateMixin {
  int _currentExerciseIndex = 0;
  int _secondsLeft = 0;
  bool _isRunning = false;
  bool _isResting = false;
  Timer? _timer;
  int _totalElapsedSeconds = 0;
  late ConfettiController _confettiController;
  final WorkoutAudioService _audioService = WorkoutAudioService();
  
  // Immersive Animations
  late AnimationController _breathingController;
  late Animation<double> _breathingAnimation;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    
    // Setup breathing animation (simulates heart rate/breath)
    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    
    _breathingAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _breathingController, curve: Curves.easeInOut),
    );

    _resetExercise();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _confettiController.dispose();
    _audioService.stop();
    _breathingController.dispose();
    super.dispose();
  }

  void _resetExercise({bool autoStart = false}) {
    final ex = widget.workout.exercises[_currentExerciseIndex];
    if (autoStart) _audioService.speak("Begin ${ex.name}");
    
    setState(() {
      _isResting = false;
      _secondsLeft = ex.durationSeconds > 0 ? ex.durationSeconds : 30;
      _isRunning = false;
    });
    
    // Calm breathing for setup
    _breathingController.duration = const Duration(milliseconds: 2000);
    _breathingController.repeat(reverse: true);

    _timer?.cancel();
    if (autoStart) {
      SensoryService().engage();
      _toggleTimer();
    }
  }

  void _toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
      _breathingController.stop(); // Pause breathing on pause
    } else {
      // Start immersive breathing based on state
      _breathingController.duration = _isResting 
          ? const Duration(milliseconds: 4000) // Slow deep breath for rest
          : const Duration(milliseconds: 800); // Fast pump for work
      _breathingController.repeat(reverse: true);

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
                colors: const [Colors.pink, Colors.cyan, Colors.amber],
              ),
            ),
            Center(
              child: Material(
                color: Colors.transparent,
                child: ScaleTransition(
                  scale: CurvedAnimation(parent: anim1, curve: Curves.elasticOut),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("🏆", style: TextStyle(fontSize: 64)),
                        const SizedBox(height: 16),
                        const Text("HIGH FIVE!", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildStatPill("⏱", "${(_totalElapsedSeconds / 60).ceil()}", "mins"),
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
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                            child: const Text("Awesome!"),
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
        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.workout.exercises[_currentExerciseIndex];
    final totalTime = _isResting ? 10 : (exercise.durationSeconds > 0 ? exercise.durationSeconds : 30);
    final progress = 1.0 - (_secondsLeft / totalTime);

    // Dynamic Gradient based on state
    final gradientColors = _isResting
        ? [const Color(0xFF004D40), const Color(0xFF009688)] // Deep Teal for Rest
        : _isRunning
            ? [const Color(0xFFD50000), const Color(0xFFFF1744)] // Intense Red for Work
            : [const Color(0xFF212121), const Color(0xFF424242)]; // Dark Gray for Pause/Idle

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(widget.workout.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // 1. Animated Background
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          
          // 2. Sweat Particles (Simple Overlay)
          if (_isRunning && !_isResting)
             Positioned.fill(
               child: Opacity(
                 opacity: 0.1,
                 child: Image.network("https://www.transparenttextures.com/patterns/stardust.png", repeat: ImageRepeat.repeat),
               ),
             ),

          // 3. Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Header Info
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                    ),
                    child: Text(
                      _isResting ? "RECOVER" : "EXERCISE ${_currentExerciseIndex + 1}/${widget.workout.exercises.length}",
                      style: const TextStyle(color: Colors.white, letterSpacing: 1.5, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                  
                  // Breathing Timer Ring
                  AnimatedBuilder(
                    animation: _breathingAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _isRunning ? _breathingAnimation.value : 1.0,
                        child: child,
                      );
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Glow
                        Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(_isResting ? 0.2 : 0.4),
                                blurRadius: 60,
                                spreadRadius: 10,
                              )
                            ],
                          ),
                        ),
                        // Progress
                        SizedBox(
                          width: 280,
                          height: 280,
                          child: CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 20,
                            color: Colors.white,
                            backgroundColor: Colors.white.withValues(alpha: 0.2),
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                        // Timer Text
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "$_secondsLeft",
                              style: const TextStyle(
                                fontSize: 100, 
                                fontWeight: FontWeight.w900, 
                                color: Colors.white,
                                height: 0.9,
                              ),
                            ),
                            Text(
                              _isResting ? "REST" : (exercise.durationSeconds > 0 ? "SEC" : "REPS"),
                              style: TextStyle(
                                fontSize: 20, 
                                fontWeight: FontWeight.bold, 
                                color: Colors.white.withValues(alpha: 0.8)
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // Exercise Name & Next Up
                  Column(
                    children: [
                      Text(
                        _isResting 
                            ? (_currentExerciseIndex < widget.workout.exercises.length - 1 
                                ? "UP NEXT: ${widget.workout.exercises[_currentExerciseIndex + 1].name.toUpperCase()}" 
                                : "ALMOST DONE!")
                            : exercise.name.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28, 
                          fontWeight: FontWeight.w800, 
                          color: Colors.white,
                          fontFamily: 'Outfit', // Ensure our premium font usage
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Instruction/Tip
                      if (!_isResting)
                        Text(
                          exercise.instructions,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 14),
                        ),
                    ],
                  ),
                  
                  const Spacer(),
                  
                  // Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildGlassButton(
                        icon: Icons.skip_previous_rounded,
                        onTap: _currentExerciseIndex > 0 
                            ? () {
                                HapticFeedback.lightImpact();
                                setState(() {
                                  _currentExerciseIndex--;
                                  _resetExercise();
                                });
                              } 
                            : null,
                      ),
                      _buildPlayButton(),
                      _buildGlassButton(
                        icon: Icons.skip_next_rounded,
                        onTap: () {
                          HapticFeedback.lightImpact();
                          _nextExercise();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassButton({required IconData icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
        ),
        child: Icon(icon, color: Colors.white, size: 32),
      ),
    );
  }

  Widget _buildPlayButton() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        _toggleTimer();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 5,
            )
          ],
        ),
        child: Icon(
          _isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
          color: AppColors.primary,
          size: 48,
        ),
      ),
    );
  }
}
