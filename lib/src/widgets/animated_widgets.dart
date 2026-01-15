import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// An animated counter that counts up from 0 to the target value
class AnimatedCounter extends StatefulWidget {
  final int value;
  final Duration duration;
  final TextStyle? style;
  final String? suffix;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.duration = const Duration(milliseconds: 1000),
    this.style,
    this.suffix,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = IntTween(begin: 0, end: widget.value).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _animation = IntTween(begin: _animation.value, end: widget.value).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          '${_animation.value}${widget.suffix ?? ''}',
          style: widget.style,
        );
      },
    );
  }
}

/// A pulsing container that glows on hover or focus
class GlowContainer extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final double glowRadius;

  const GlowContainer({
    super.key,
    required this.child,
    this.glowColor = Colors.pink,
    this.glowRadius = 20,
  });

  @override
  State<GlowContainer> createState() => _GlowContainerState();
}

class _GlowContainerState extends State<GlowContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.2, end: 0.4).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withValues(alpha: _animation.value),
                blurRadius: widget.glowRadius,
                spreadRadius: 2,
              ),
            ],
          ),
          child: widget.child,
        );
      },
    );
  }
}

/// A spring-animated scale widget for tap feedback
class SpringButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double scale;

  const SpringButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.scale = 0.95,
  });

  @override
  State<SpringButton> createState() => _SpringButtonState();
}

class _SpringButtonState extends State<SpringButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: widget.scale).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child,
          );
        },
      ),
    );
  }
}

/// A floating action button with a glowing effect for dark mode
class GlowingFAB extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final String? label;

  const GlowingFAB({
    super.key,
    required this.onPressed,
    required this.child,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: isDark ? BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.4),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ) : null,
      child: label != null
        ? FloatingActionButton.extended(
            onPressed: onPressed,
            label: Text(label!),
            icon: child,
          )
        : FloatingActionButton(
            onPressed: onPressed,
            child: child,
          ),
    );
  }
}
