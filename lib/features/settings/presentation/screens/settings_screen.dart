import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:colordary/l10n/app_localizations.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/providers/dependency_providers.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final settingsState = ref.watch(settingsNotifierProvider);
    final settingsNotifier = ref.read(settingsNotifierProvider.notifier);

    final palettes = [
      AppColors.emotionPaletteDefault,
      AppColors.emotionPaletteNature,
      AppColors.emotionPaletteSunset,
    ];
    final paletteNames = [
      loc.paletteDefault,
      loc.paletteNature,
      loc.paletteSunset,
    ];

    Widget buildSectionHeader(String title) {
      return Padding(
        padding: const EdgeInsets.only(left: AppDimensions.paddingS, bottom: AppDimensions.paddingS),
        child: Text(
          title.toUpperCase(),
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.primary,
            letterSpacing: 1.2,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.settingsTitle, style: theme.textTheme.titleLarge),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppDimensions.paddingM),
          children: [
            // Apariencia
            buildSectionHeader(loc.sectionAppearance),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(loc.themeMode, style: theme.textTheme.titleMedium),
                    const SizedBox(height: AppDimensions.paddingM),
                    SwitchListTile(
                      title: Text(loc.themeDark, style: theme.textTheme.bodyLarge!),
                      value: settingsState.themeMode == ThemeMode.dark,
                      onChanged: (val) {
                        settingsNotifier.updateThemeMode(val ? ThemeMode.dark : ThemeMode.light);
                      },
                      secondary: Icon(
                        settingsState.themeMode == ThemeMode.dark 
                          ? Icons.dark_mode_rounded 
                          : Icons.light_mode_rounded,
                        color: theme.colorScheme.primary,
                      ),
                      activeColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusM)),
                    ),
                    const Divider(height: AppDimensions.paddingXL),
                    Text(loc.palette, style: theme.textTheme.titleMedium),
                    const SizedBox(height: AppDimensions.paddingM),
                    
                    // Visual Selector
                    Stack(
                      children: [
                        Opacity(
                          opacity: settingsState.isColorBlindMode ? 0.5 : 1.0,
                          child: AbsorbPointer(
                            absorbing: settingsState.isColorBlindMode,
                            child: SizedBox(
                              height: 100,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: palettes.length,
                                separatorBuilder: (context, _) => const SizedBox(width: AppDimensions.paddingM),
                                itemBuilder: (context, index) {
                                  final isSelected = settingsState.selectedPaletteIndex == index;
                                  return GestureDetector(
                                    onTap: () => settingsNotifier.updatePalette(index),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      width: 140,
                                      padding: const EdgeInsets.all(AppDimensions.paddingS),
                                      decoration: BoxDecoration(
                                        color: isSelected ? theme.colorScheme.primary.withOpacity(0.1) : Colors.transparent,
                                        border: Border.all(
                                          color: isSelected ? theme.colorScheme.primary : theme.dividerColor,
                                          width: isSelected ? 2 : 1,
                                        ),
                                        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            paletteNames[index], 
                                            style: theme.textTheme.bodyMedium?.copyWith(
                                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: AppDimensions.paddingS),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: palettes[index].map((color) => Container(
                                              width: 16,
                                              height: 16,
                                              margin: const EdgeInsets.symmetric(horizontal: 2),
                                              decoration: BoxDecoration(
                                                color: color,
                                                shape: BoxShape.circle,
                                              ),
                                            )).toList(),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        if (settingsState.isColorBlindMode)
                          Positioned.fill(
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM, vertical: AppDimensions.paddingS),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.surface.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                                  border: Border.all(color: theme.colorScheme.primary.withOpacity(0.5)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.lock_outline, size: 16, color: theme.colorScheme.primary),
                                    const SizedBox(width: AppDimensions.paddingS),
                                    Text(
                                      "Modo daltónico activo", 
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.primary
                                      )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingL),

            // Privacidad
            buildSectionHeader(loc.sectionPrivacy),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(loc.authTitle, style: theme.textTheme.titleMedium),
                    SwitchListTile(
                      title: Text(loc.authSwitch, style: theme.textTheme.bodyLarge!),
                      subtitle: Text(loc.authSubtitle, style: theme.textTheme.bodyMedium!),
                      value: settingsState.isAuthEnabled,
                      onChanged: (val) => settingsNotifier.toggleAuth(val, context),
                      secondary: Icon(Icons.fingerprint_rounded, color: theme.colorScheme.primary),
                      activeColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusM)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingL),

            // Idioma
            buildSectionHeader(loc.sectionLanguage),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(loc.languageSelector, style: theme.textTheme.titleMedium),
                    const SizedBox(height: AppDimensions.paddingM),
                    DropdownButtonFormField<Locale>(
                      value: settingsState.locale ?? Localizations.localeOf(context),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.language_rounded, color: theme.colorScheme.primary),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusM)),
                      ),
                      items: const [
                        DropdownMenuItem(value: Locale('es'), child: Text("Español")),
                        DropdownMenuItem(value: Locale('ca'), child: Text("Català")),
                        DropdownMenuItem(value: Locale('en'), child: Text("English")),
                        DropdownMenuItem(value: Locale('fr'), child: Text("Français")),
                        DropdownMenuItem(value: Locale('de'), child: Text("Deutsch")),
                        DropdownMenuItem(value: Locale('it'), child: Text("Italiano")),
                        DropdownMenuItem(value: Locale('pt'), child: Text("Português")),
                        DropdownMenuItem(value: Locale('ru'), child: Text("Русский")),
                        DropdownMenuItem(value: Locale('ja'), child: Text("日本語")),
                        DropdownMenuItem(value: Locale('ko'), child: Text("한국어")),
                        DropdownMenuItem(value: Locale('zh'), child: Text("中文")),
                      ],
                      onChanged: (Locale? newLocale) {
                        if (newLocale != null) {
                          settingsNotifier.updateLocale(newLocale);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingL),

            // Accesibilidad
            buildSectionHeader(loc.sectionAccessibility),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(loc.colorBlindMode, style: theme.textTheme.titleMedium),
                    SwitchListTile(
                      title: Text(loc.accessibilityPatterns, style: theme.textTheme.bodyLarge!),
                      subtitle: Text(loc.colorBlindModeDesc, style: theme.textTheme.bodyMedium!),
                      value: settingsState.isColorBlindMode,
                      onChanged: settingsNotifier.updateColorBlindMode,
                      secondary: Icon(Icons.visibility_rounded, color: theme.colorScheme.primary),
                      activeColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusM)),
                    ),
                    const Divider(height: AppDimensions.paddingXL),
                    Text(loc.notificationTitle, style: theme.textTheme.titleMedium),
                    SwitchListTile(
                      title: Text(loc.notificationTime, style: theme.textTheme.bodyLarge!),
                      subtitle: Text(loc.notificationSubtitle, style: theme.textTheme.bodyMedium!),
                      value: settingsState.isNotificationsEnabled,
                      onChanged: (val) => settingsNotifier.toggleNotifications(
                        val,
                        loc.appTitle,
                        loc.dailyEntryHint,
                        context,
                      ),
                      secondary: Icon(Icons.notifications_active_rounded, color: theme.colorScheme.primary),
                      activeColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusM)),
                    ),
                    const Divider(height: AppDimensions.paddingXL),
                    Text(loc.fontSize, style: theme.textTheme.titleMedium),
                    const SizedBox(height: AppDimensions.paddingM),
                    SizedBox(
                      width: double.infinity,
                      child: SegmentedButton<double>(
                        segments: [
                          ButtonSegment(value: 0.9, label: Text(loc.fontSizeSmall)),
                          ButtonSegment(value: 1.0, label: Text(loc.fontSizeMedium)),
                          ButtonSegment(value: 1.2, label: Text(loc.fontSizeLarge)),
                        ],
                        selected: {settingsState.fontSizeMultiplier},
                        onSelectionChanged: (newSelection) {
                          settingsNotifier.updateFontSize(newSelection.first);
                        },
                        style: SegmentedButton.styleFrom(
                          selectedBackgroundColor: theme.colorScheme.primary,
                          selectedForegroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingL),
                    Center(
                      child: Text(
                        loc.textPreview,
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: AppDimensions.paddingL),
            
            // Reassurance / Brand Message
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingXL),
              child: Column(
                children: [
                  Icon(Icons.favorite_rounded, color: theme.colorScheme.primary.withOpacity(0.5), size: 48),
                  const SizedBox(height: AppDimensions.paddingM),
                  Text(
                    "Gracias por dedicar unos minutos al día para cuidar tu bienestar emocional.",
                    style: theme.textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppDimensions.paddingS),
                  Text("Versión 1.0.0", style: theme.textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
