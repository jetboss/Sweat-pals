import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../providers/avatar_provider.dart';

class SweatPalAvatar extends StatefulWidget {
  final AvatarState state;
  final double size;

  const SweatPalAvatar({
    super.key,
    required this.state,
    this.size = 200, // Balanced size for dashboard
  });

  @override
  State<SweatPalAvatar> createState() => _SweatPalAvatarState();
}

class _SweatPalAvatarState extends State<SweatPalAvatar> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
    
    _bounceController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        lowerBound: 0.0,
        upperBound: 0.35, // Increased bounce for more impact
    );
    _bounceAnimation = CurvedAnimation(parent: _bounceController, curve: Curves.elasticOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  void _handleTap() {
    HapticFeedback.mediumImpact();
    // Play bounce
    _bounceController.forward().then((_) => _bounceController.reverse());
    
    // Show quick emoji overlay
    _showEmojiReaction();
  }
  
  void _showEmojiReaction() {
    // Simple overlay of an emoji rising
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    
    late OverlayEntry entry;
    
    // Choose emoji based on mood
    String emoji = "🔥";
    if (widget.state.mood == AvatarMood.happy) emoji = "❤️";
    if (widget.state.mood == AvatarMood.tired) emoji = "💤";
    
    entry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx + size.width / 2 - 20,
        top: position.dy,
        child: _FloatingEmoji(emoji: emoji, onEnd: () => entry.remove()),
      ),
    );
    
    overlay.insert(entry);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: Listenable.merge([_controller, _bounceController]),
        builder: (context, child) {
          final scale = 1.0 + (0.5 * _bounceAnimation.value); // Scale factor
          return Transform.scale(
            scale: scale,
            child: CustomPaint(
              size: Size(widget.size, widget.size),
              painter: PerformancePulsePainter(
                color: widget.state.primaryColor,
                mood: widget.state.mood,
                level: widget.state.level,
                animationValue: _controller.value,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FloatingEmoji extends StatefulWidget {
  final String emoji;
  final VoidCallback onEnd;
  const _FloatingEmoji({required this.emoji, required this.onEnd});

  @override
  State<_FloatingEmoji> createState() => _FloatingEmojiState();
}

class _FloatingEmojiState extends State<_FloatingEmoji> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _float;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _float = Tween<double>(begin: 0, end: -100).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _fade = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(parent: _ctrl, curve: const Interval(0.5, 1.0)));
    
    _ctrl.forward().then((_) => widget.onEnd());
  }
  
  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (ctx, child) => Transform.translate(
        offset: Offset(0, _float.value),
        child: Opacity(
          opacity: _fade.value,
          child: Text(widget.emoji, style: const TextStyle(fontSize: 40, decoration: TextDecoration.none)),
        ),
      ),
    );
  }
}

class PerformancePulsePainter extends CustomPainter {
  final Color color;
  final AvatarMood mood;
  final int level;
  final double animationValue;

  PerformancePulsePainter({
    required this.color,
    required this.mood,
    required this.level,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final coreRadius = size.width / 5;

    // 1. Draw Background Biometric Rings
    _drawBiometricRings(canvas, center, size.width);

    // 2. Draw Heart Rate Wave
    _drawHeartRateWave(canvas, center, size.width);

    // 3. Draw The Crystal Core (Evolves with Level)
    _drawCrystalCore(canvas, center, coreRadius);

    // 4. Draw Energy Particles / Sparkles
    if (mood == AvatarMood.energetic || mood == AvatarMood.happy) {
      _drawEnergyParticles(canvas, center, size.width);
    }
  }

  void _drawBiometricRings(Canvas canvas, Offset center, double size) {
    final ringCount = 3;
    final baseRadius = size * 0.25;
    
    for (int i = 1; i <= ringCount; i++) {
      final radius = baseRadius + (i * 20);
      final opacity = (0.2 / i) + (0.05 * sin(animationValue * 2 * pi + (i * 0.5)));
      
      final paint = Paint()
        ..color = color.withOpacity(opacity.clamp(0.0, 1.0))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0 / i;

      // Draw dashed-style ring segment
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        animationValue * 2 * pi * (i.isEven ? 1 : -1),
        1.5 * pi,
        false,
        paint,
      );
    }
  }

  void _drawHeartRateWave(Canvas canvas, Offset center, double size) {
    final pulsePaint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path();
    final waveWidth = size * 0.8;
    final startX = center.dx - (waveWidth / 2);
    
    path.moveTo(startX, center.dy);
    
    for (double x = 0; x <= waveWidth; x += 5) {
      double relativeX = x / waveWidth;
      // Frequency and Amplitude shift based on mood
      double speed = mood == AvatarMood.energetic ? 4 : 2;
      double amplitude = mood == AvatarMood.energetic ? 20 : 10;
      
      // Horizontal movement
      double xPos = startX + x;
      // EKG-style spike
      double spike = 0.0;
      double t = (animationValue * speed + relativeX) % 1.0;
      if (t > 0.4 && t < 0.6) {
         spike = sin((t - 0.4) * 5 * pi) * amplitude;
      }
      
      path.lineTo(xPos, center.dy - spike);
    }
    canvas.drawPath(path, pulsePaint);
  }

  void _drawCrystalCore(Canvas canvas, Offset center, double radius) {
    final breathFactor = 1.0 + (0.05 * sin(animationValue * 2 * pi));
    final currentRadius = radius * breathFactor;
    
    // Core Glow
    final glowPaint = Paint()
      ..color = color.withValues(alpha: 0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);
    canvas.drawCircle(center, currentRadius * 1.5, glowPaint);

    // Draw Multifaceted structure based on Level
    int facets = 4; // Tetrahedron
    if (level == 2) facets = 8; // Octahedron
    if (level >= 3) facets = 12; // Dodecahedron (simplified)

    final paint = Paint()..style = PaintingStyle.fill;
    
    // Abstract facets using triangulation
    for (int i = 0; i < facets; i++) {
      final angle = (i * 2 * pi / facets) + (animationValue * 0.5);
      final nextAngle = ((i + 1) * 2 * pi / facets) + (animationValue * 0.5);
      
      final p1 = Offset(
        center.dx + currentRadius * cos(angle),
        center.dy + currentRadius * sin(angle),
      );
      final p2 = Offset(
        center.dx + currentRadius * cos(nextAngle),
        center.dy + currentRadius * sin(nextAngle),
      );
      
      // Face Color Variation (simulate light refraction)
      final shadeValue = (sin(angle + animationValue * pi) + 1) / 2;
      paint.color = Color.lerp(color, Colors.white, 0.1 + (0.4 * shadeValue))!
          .withValues(alpha: 0.9);
      
      final pPath = Path()
        ..moveTo(center.dx, center.dy)
        ..lineTo(p1.dx, p1.dy)
        ..lineTo(p2.dx, p2.dy)
        ..close();
      
      canvas.drawPath(pPath, paint);
      
      // Facet Lines
      final linePaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      canvas.drawPath(pPath, linePaint);
    }

    // Inner Core Pulse (Heart or Flame depending on mood)
    _drawCoreGlyph(canvas, center, currentRadius * 0.4);
  }

  void _drawCoreGlyph(Canvas canvas, Offset center, double size) {
    final glyphPaint = Paint()
      ..color = Colors.white.withOpacity(0.6 + (0.3 * sin(animationValue * 4 * pi)))
      ..style = PaintingStyle.fill;

    if (mood == AvatarMood.energetic) {
      // Draw Flame
      final path = Path();
      final w = size;
      final h = size * 1.2;
      path.moveTo(center.dx, center.dy + h * 0.4);
      path.quadraticBezierTo(center.dx - w * 0.8, center.dy + h * 0.2, center.dx - w * 0.4, center.dy - h * 0.2);
      path.quadraticBezierTo(center.dx - w * 0.2, center.dy - h * 0.8, center.dx, center.dy - h);
      path.quadraticBezierTo(center.dx + w * 0.2, center.dy - h * 0.8, center.dx + w * 0.4, center.dy - h * 0.2);
      path.quadraticBezierTo(center.dx + w * 0.8, center.dy + h * 0.2, center.dx, center.dy + h * 0.4);
      canvas.drawPath(path, glyphPaint);
    } else if (mood == AvatarMood.happy) {
      // Draw Heart
      final path = Path();
      final w = size;
      final h = size;
      path.moveTo(center.dx, center.dy + h * 0.3);
      path.cubicTo(center.dx - w, center.dy - h * 0.5, center.dx - w * 0.5, center.dy - h, center.dx, center.dy - h * 0.3);
      path.cubicTo(center.dx + w * 0.5, center.dy - h, center.dx + w, center.dy - h * 0.5, center.dx, center.dy + h * 0.3);
      canvas.drawPath(path, glyphPaint);
    } else {
      // Draw simple glowing circle core
      canvas.drawCircle(center, size * 0.6, glyphPaint..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5));
    }
  }

  void _drawEnergyParticles(Canvas canvas, Offset center, double size) {
    final random = Random(42);
    final particlePaint = Paint()..style = PaintingStyle.fill;
    
    for (int i = 0; i < 15; i++) {
      final pAngle = random.nextDouble() * 2 * pi;
      final distance = (size * 0.2) + (size * 0.2 * ((animationValue + random.nextDouble()) % 1.0));
      final pSize = 1.0 + random.nextDouble() * 3.0;
      
      final pPos = Offset(
        center.dx + distance * cos(pAngle + animationValue),
        center.dy + distance * sin(pAngle + animationValue),
      );
      
      particlePaint.color = color.withOpacity((1.0 - (distance / (size * 0.4))).clamp(0.0, 1.0));
      canvas.drawCircle(pPos, pSize, particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant PerformancePulsePainter oldDelegate) {
    return true; // Constant animation
  }
}
