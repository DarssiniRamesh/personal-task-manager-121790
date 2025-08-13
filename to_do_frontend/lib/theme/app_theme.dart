import 'package:flutter/material.dart';

/// Central app theme and design tokens approximating the provided Figma/CSS.
/// Colors are mapped from CSS variables where possible.
class AppTheme {
  // Core palette (from common.css)
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color color9395d3 = Color(0xFF9395D3);
  static const Color color8b8787 = Color(0xFF8B8787);
  static const Color color000000 = Color(0xFF000000);

  static const double appBarHeight = 118; // matches Figma
  static const double bottomNavHeight = 68; // matches Figma
  static const double fabSize = 70; // matches Figma
  static const double cardHeight = 82; // matches Figma

  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 4,
          offset: const Offset(0, 4),
        ),
      ];

  // PUBLIC_INTERFACE
  static ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: color9395d3,
        brightness: Brightness.light,
        primary: color9395d3,
      ),
      scaffoldBackgroundColor: colorWhite,
      textTheme: const TextTheme(
        // Title (24, w600) similar to typo_8
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          height: 34.68 / 24,
          color: colorWhite,
        ),
        // Card Title (13, w600) similar to typo_9
        titleMedium: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          height: 18.785 / 13,
          color: color9395d3,
        ),
        // Card Subtitle (10, w400) similar to typo_10
        bodySmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          height: 14.45 / 10,
          color: color000000,
        ),
        // Field label (16, w400) similar to typo_11
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 23.12 / 16,
          color: color8b8787,
        ),
        // Button "ADD" (20, w600) similar to typo_12
        labelLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 28.9 / 20,
          color: colorWhite,
        ),
      ),
    );
  }
}
