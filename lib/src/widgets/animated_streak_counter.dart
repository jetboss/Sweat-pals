import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

/// A beautiful animated streak counter with flame animation and confetti celebrations
class AnimatedStreakCounter extends StatefulWidget {
  final int streak;
  final VoidCallback? onTap;

  const AnimatedStreakCounter({
    super.key,
    required this.streak,
    this.onTap,
  });

  @override
  State<AnimatedStreakCounter> createState() => _AnimatedStreakCounterState();
}

class _AnimatedStreakCounterState extends State<AnimatedStreakCounter>
    with TickerProviderStateMixin {
  late AnimationController _flameController;
  late AnimationController _pulseController;
  late AnimationController _numberController;
  late ConfettiController _confettiController;
  
  int _previousStreak = 0;

  // Milestone streaks that trigger confetti
  static const List<int> _milestones = [7, 14, 21, 30, 45, 60, 90, 100, 150, 200, 365];

  @override
  void initState() {
    super.initState();
    _previousStreak = widget.streak;
    
    _flameController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _numberController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );

    // Check for milestone celebration on init
    if (_isMilestone(widget.streak)) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) _confettiController.play();
      });
    }
  }

  @override
  void didUpdateWidget(AnimatedStreakCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.streak != oldWidget.streak) {
      // Animate the number change
      _numberController.forward(from: 0);
      _pulseController.forward(from: 0);
      
      // Check if we hit a milestone
      if (widget.streak > _previousStreak && _isMilestone(widget.streak)) {
        _confettiController.play();
      }
      
      _previousStreak = widget.streak;
    }
  }

  bool _isMilestone(int streak) {
    return _milestones.contains(streak);
  }

  String? _getMilestoneMessage(int streak) {
    switch (streak) {
      case 7: return "1 Week! 🔥";
      case 14: return "2 Weeks! 💪";
      case 21: return "3 Weeks! 🎯";
      case 30: return "1 Month! 🏆";
      case 45: return "45 Days! 🌟";
      case 60: return "2 Months! 💎";
      case 90: return "3 Months! 👑";
      case 100: return "100 Days! 🎉";
      case 150: return "150 Days! ⭐";
      case 200: return "200 Days! 🚀";
      case 365: return "1 YEAR! 🏅";
      default: return null;
    }
  }

  @override
  void dispose() {
    _flameController.dispose();
    _pulseController.dispose();
    _numberController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final milestone = _getMilestoneMessage(widget.streak);
    
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // Confetti overlay
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: pi / 2, // downward
            maxBlastForce: 5,
            minBlastForce: 2,
            emissionFrequency: 0.05,
            numberOfParticles: 20,
            gravity: 0.2,
            shouldLoop: false,
            colors: const [
              Colors.orange,
              Colors.red,
              Colors.yellow,
              Colors.pink,
              Colors.purple,
            ],
          ),
        ),
        
        // Main streak card
        GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withValues(alpha: 0.8),
                  theme.colorScheme.secondary.withValues(alpha: 0.6),
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated Flame Icon
                AnimatedBuilder(
                  animation: _flameController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 1.0 + (0.1 * sin(_flameController.value * 2 * pi)),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Glow effect
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.orange.withOpacity(
                                    0.3 + 0.2 * sin(_flameController.value * 2 * pi),
                                  ),
                                  blurRadius: 30,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                          ),
                          // Flame icon with color animation
                          ShaderMask(
                            shaderCallback: (bounds) {
                              return LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.red,
                                  Colors.orange,
                                  Colors.yellow.withOpacity(
                                    0.8 + 0.2 * sin(_flameController.value * 4 * pi),
                                  ),
                                ],
                              ).createShader(bounds);
                            },
                            child: const Icon(
                              Icons.local_fire_department_rounded,
                              size: 72,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 12),
                
                // Animated Streak Number
                AnimatedBuilder(
                  animation: Listenable.merge([_pulseController, _numberController]),
                  builder: (context, child) {
                    final pulse = 1.0 + (0.15 * (1 - _pulseController.value));
                    return Transform.scale(
                      scale: pulse,
                      child: Text(
                        '${widget.streak}',
                        style: theme.textTheme.displayLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1,
                          shadows: [
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                
                Text(
                  'Day Streak!',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.95),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Milestone badge or encouragement
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: milestone != null
                      ? Container(
                          key: ValueKey(milestone),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            milestone,
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : Text(
                          key: const ValueKey('keep_going'),
                          _getEncouragementText(widget.streak),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                ),
                
                // Progress to next milestone
                if (!_isMilestone(widget.streak)) ...[
                  const SizedBox(height: 12),
                  _buildMilestoneProgress(theme),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getEncouragementText(int streak) {
    if (streak == 0) return "Start your journey today!";
    if (streak == 1) return "Great start! Keep it up!";
    if (streak < 7) return "Building momentum! 💪";
    if (streak < 14) return "You're on fire! 🔥";
    if (streak < 30) return "Incredible consistency!";
    return "Legendary dedication! 👑";
  }

  Widget _buildMilestoneProgress(ThemeData theme) {
    final nextMilestone = _milestones.firstWhere(
      (m) => m > widget.streak,
      orElse: () => widget.streak + 30,
    );
    final prevMilestone = _milestones.lastWhere(
      (m) => m <= widget.streak,
      orElse: () => 0,
    );
    
    final progress = (widget.streak - prevMilestone) / (nextMilestone - prevMilestone);
    
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${nextMilestone - widget.streak} days to next milestone',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.white60,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white.withValues(alpha: 0.8),
              ),
              minHeight: 6,
            ),
          ),
        ),
      ],
    );
  }
}
