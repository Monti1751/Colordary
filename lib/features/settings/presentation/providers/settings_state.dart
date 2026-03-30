import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/constants/app_colors.dart';

class SettingsState extends Equatable {
  final ThemeMode themeMode;
  final double fontSizeMultiplier;
  final int selectedPaletteIndex;
  final bool isColorBlindMode;
  final bool isNotificationsEnabled;
  final bool isAuthEnabled;
  final Locale? locale;

  const SettingsState({
    this.themeMode = ThemeMode.system,
    this.fontSizeMultiplier = 1.0,
    this.selectedPaletteIndex = 0,
    this.isColorBlindMode = false,
    this.isNotificationsEnabled = false,
    this.isAuthEnabled = false,
    this.locale,
  });

  /// Centralized logic for the active emotion palette.
  List<Color> get currentPalette {
    if (isColorBlindMode) return AppColors.emotionPaletteColorblind;
    switch (selectedPaletteIndex) {
      case 1: return AppColors.emotionPaletteNature;
      case 2: return AppColors.emotionPaletteSunset;
      default: return AppColors.emotionPaletteDefault;
    }
  }

  SettingsState copyWith({
    ThemeMode? themeMode,
    double? fontSizeMultiplier,
    int? selectedPaletteIndex,
    bool? isColorBlindMode,
    bool? isNotificationsEnabled,
    bool? isAuthEnabled,
    Locale? locale,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      fontSizeMultiplier: fontSizeMultiplier ?? this.fontSizeMultiplier,
      selectedPaletteIndex: selectedPaletteIndex ?? this.selectedPaletteIndex,
      isColorBlindMode: isColorBlindMode ?? this.isColorBlindMode,
      isNotificationsEnabled: isNotificationsEnabled ?? this.isNotificationsEnabled,
      isAuthEnabled: isAuthEnabled ?? this.isAuthEnabled,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [
        themeMode,
        fontSizeMultiplier,
        selectedPaletteIndex,
        isColorBlindMode,
        isNotificationsEnabled,
        isAuthEnabled,
        locale,
      ];
}
