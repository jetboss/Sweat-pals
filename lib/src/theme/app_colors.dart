import 'package:flutter/material.dart';

class AppColors {
  // ===== LIGHT THEME =====
  // Primary Palette
  static const Color pinkPastel = Color(0xFFFCE4EC); // Colors.pink[50]
  static const Color pinkAccent = Color(0xFFF8BBD0); // Colors.pink[100]
  static const Color primary = pinkAccent; // Main brand color
  
  // Accents for Motivation
  static const Color tealAccent = Color(0xFFB2DFDB); // Colors.teal[100]
  static const Color greenAccent = Color(0xFFC8E6C9); // Colors.green[100]
  
  // Neutral / Background
  static const Color scaffoldBackground = Color(0xFFFAFAFA);
  static const Color background = scaffoldBackground;
  static const Color cardBackground = Colors.white;
  static const Color cardSurface = Colors.white;
  
  // Text
  static const Color textPrimary = Color(0xFF424242);
  static const Color textSecondary = Color(0xFF757575);

  // ===== DARK THEME =====
  static const Color darkScaffoldBackground = Color(0xFF121212);
  static const Color darkCardBackground = Color(0xFF1E1E1E);
  static const Color darkSurface = Color(0xFF2C2C2C);
  
  // Text (Dark)
  static const Color darkTextPrimary = Color(0xFFE0E0E0);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  
  // Accent colors remain vibrant in dark mode
  static const Color darkPinkAccent = Color(0xFFFF80AB); // Brighter pink
  static const Color darkTealAccent = Color(0xFF80CBC4);
  static const Color darkGreenAccent = Color(0xFFA5D6A7);
}
