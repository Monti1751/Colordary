import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import 'settings_state.dart';

class AppThemeGenerator {
  static ThemeData generateTheme(SettingsState state, {bool isDark = false}) {
    // Determine Palette based on SettingsState
    final List<Color> palette = state.currentPalette;

    final Color bgColor = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final Color surfaceColor = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondaryColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    
    // We use palette[3] (Happy) as primary brand color for Buttons/Accents usually
    final Color primaryColor = palette[3];

    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: bgColor,
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: primaryColor,
        onPrimary: isDark ? Colors.black : Colors.white,
        secondary: palette[2],
        onSecondary: Colors.white,
        error: Colors.redAccent,
        onError: Colors.white,
        background: bgColor,
        onBackground: textColor,
        surface: surfaceColor,
        onSurface: textColor,
      ),
      textTheme: TextTheme(
        // Cozy Typography: Rounded Google Font like 'Nunito' or 'Quicksand'
        displayLarge: GoogleFonts.quicksand(
          fontSize: AppDimensions.fontHeadline * state.fontSizeMultiplier,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        titleLarge: GoogleFonts.quicksand(
          fontSize: AppDimensions.fontTitle * state.fontSizeMultiplier,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
        bodyLarge: GoogleFonts.quicksand(
          fontSize: AppDimensions.fontBody * state.fontSizeMultiplier,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        bodyMedium: GoogleFonts.quicksand(
          fontSize: AppDimensions.fontSmall * state.fontSizeMultiplier,
          color: textSecondaryColor,
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: AppDimensions.elevationSoft,
        shadowColor: Colors.black.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: AppDimensions.elevationSoft,
          shadowColor: primaryColor.withOpacity(0.4), // Diffuse colored shadow
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.paddingM,
            horizontal: AppDimensions.paddingL,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(AppDimensions.paddingM),
      ),
      iconTheme: IconThemeData(
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
        size: AppDimensions.iconM,
      ),
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (context) => const Icon(Icons.arrow_back_ios_new_rounded),
      ),
    );
  }
}
