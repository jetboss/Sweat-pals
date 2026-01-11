import 'dart:ui';
import 'package:flutter/material.dart';

class SweatPalCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final bool hasGlass;
  final double borderRadius;
  final Border? border;
  final List<BoxShadow>? boxShadow;

  const SweatPalCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(20),
    this.color,
    this.hasGlass = false,
    this.borderRadius = 24.0,
    this.border,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Default styling
    final baseColor = color ?? theme.cardTheme.color ?? Colors.white;
    final effectiveBorderRadius = BorderRadius.circular(borderRadius);

    Widget cardContent = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: hasGlass ? baseColor.withValues(alpha: 0.1) : baseColor,
        borderRadius: effectiveBorderRadius,
        border: border ?? Border.all(
          color: hasGlass 
              ? Colors.white.withValues(alpha: 0.2) 
              : theme.dividerColor.withValues(alpha: 0.1),
          width: 1.5,
        ),
        boxShadow: boxShadow ?? [
          BoxShadow(
            color: hasGlass 
                ? baseColor.withValues(alpha: 0.1) 
                : Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
            spreadRadius: -5,
          ),
        ],
      ),
      child: child,
    );

    // Apply Glassmorphism
    if (hasGlass) {
      cardContent = ClipRRect(
        borderRadius: effectiveBorderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: cardContent,
        ),
      );
    }

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: cardContent,
      );
    }

    return cardContent;
  }
}
