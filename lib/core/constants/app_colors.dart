import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // --- UI Colors (Light Mode) ---
  static const Color backgroundLight = Color(0xFFFDF5E6); // Soft Cream
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textPrimaryLight = Color(0xFF2D3142);
  static const Color textSecondaryLight = Color(0xFF9094A6);
  static const Color dividerLight = Color(0xFFE5E6EB);

  // --- UI Colors (Dark Mode) ---
  static const Color backgroundDark = Color(0xFF1E1E24);
  static const Color surfaceDark = Color(0xFF2B2B36);
  static const Color textPrimaryDark = Color(0xFFF8F9FA);
  static const Color textSecondaryDark = Color(0xFFA9ABB6);
  static const Color dividerDark = Color(0xFF3F404D);

  // --- Emotion Palettes ---
  // Indices represent moods:
  // 0: Very Sad, 1: Sad, 2: Neutral, 3: Happy, 4: Very Happy

  // Palette 1: Default (Cozy Pastels)
  static const List<Color> emotionPaletteDefault = [
    Color(0xFF82A0D8), // Very Sad (Soft Blue)
    Color(0xFFB0C4DE), // Sad (Light Steel Blue)
    Color(0xFFD3D3D3), // Neutral (Warm Gray)
    Color(0xFFA8E6CF), // Happy (Mint Green)
    Color(0xFFFFD3B6), // Very Happy (Peach/Orange)
  ];

  // Palette 2: Nature (Earthy Tones)
  static const List<Color> emotionPaletteNature = [
    Color(0xFF4A6741), // Very Sad (Deep Moss)
    Color(0xFF7A9E7E), // Sad (Sage)
    Color(0xFFEFE8D6), // Neutral (Sand)
    Color(0xFFD4A373), // Happy (Clay)
    Color(0xFFE9C46A), // Very Happy (Sunlight)
  ];

  // Palette 3: Sunset (Warm & Vibrant)
  static const List<Color> emotionPaletteSunset = [
    Color(0xFF451F55), // Very Sad (Deep Purple)
    Color(0xFF724E91), // Sad (Muted Purple)
    Color(0xFFE5989B), // Neutral (Dusty Rose)
    Color(0xFFFFB4A2), // Happy (Melon)
    Color(0xFFFFD166), // Very Happy (Golden Yellow)
  ];

  // Palette 4: Colorblind Safe (Deuteranopia/Protanopia friendly)
  // High contrast and distinct hues
  static const List<Color> emotionPaletteColorblind = [
    Color(0xFF001219), // Very Sad
    Color(0xFF005F73), // Sad
    Color(0xFF94D2BD), // Neutral
    Color(0xFFE9D8A6), // Happy
    Color(0xFFCA6702), // Very Happy
  ];
}
