import 'package:flutter/material.dart';

class AppColors {
  // ===== BRAND IDENTITY =====
  // High-Energy Primary: A vivid, mature pink/red. No more soft baby pinks.
  static const Color primary = Color(0xFFFF1744); // Deep Accent Pink/Red
  static const Color primaryVariant = Color(0xFFD50000); 

  // Secondary/Accent: Electric Blue/Purple for high contrast elements
  static const Color accent = Color(0xFF651FFF); // Deep Purple Accent

  // ===== NEUTRALS (Light) =====
  static const Color scaffoldBackground = Color(0xFFF5F5F7); // Apple-style light gray
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Color(0xFF1D1D1F); // Almost black
  static const Color textSecondary = Color(0xFF86868B); // Mid gray
  static const Color divider = Color(0xFFE5E5EA);

  // ===== NEUTRALS (Dark) =====
  static const Color darkScaffoldBackground = Color(0xFF000000); // True black for OLED
  static const Color darkCardBackground = Color(0xFF1C1C1E); // Apple-style dark gray
  static const Color darkTextPrimary = Color(0xFFF5F5F7);
  static const Color darkTextSecondary = Color(0xFF86868B);

  // ===== FUNCTIONAL =====
  static const Color success = Color(0xFF34C759);
  static const Color warning = Color(0xFFFF9F0A);
  static const Color error = Color(0xFFFF3B30);
  
  // Gradients
  static const LinearGradient brandGradient = LinearGradient(
    colors: [Color(0xFFFF1744), Color(0xFFFF4081)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient darkBrandGradient = LinearGradient(
    colors: [Color(0xFFD50000), Color(0xFFC51162)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
