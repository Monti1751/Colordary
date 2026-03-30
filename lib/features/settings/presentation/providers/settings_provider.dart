import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:colordary/l10n/app_localizations.dart';
import '../../../../core/services/notification_service.dart';
import '../../../../core/services/local_auth_service.dart';
import '../../domain/usecases/update_app_settings_usecase.dart';
import '../../data/repositories/settings_repository_impl.dart';
import 'settings_state.dart';
import 'theme_generator.dart';

class SettingsNotifier extends StateNotifier<SettingsState> {
  final UpdateAppSettingsUseCase _updateSettingsUseCase;
  final SettingsRepositoryImpl _repository;
  final NotificationService _notificationService;
  final LocalAuthService _localAuthService;

  SettingsNotifier(
    this._updateSettingsUseCase, 
    this._repository, 
    this._notificationService,
    this._localAuthService,
  ) : super(const SettingsState()) {
    _loadSettings();
  }

  void _loadSettings() {
    final langCode = _repository.getLanguageCode();
    state = state.copyWith(
      themeMode: _parseThemeMode(_repository.getThemeMode()),
      fontSizeMultiplier: _repository.getFontSizeScale(),
      selectedPaletteIndex: _repository.getEmotionPaletteIndex(),
      isColorBlindMode: _repository.getColorblindMode(),
      isNotificationsEnabled: _repository.getNotificationsEnabled(),
      isAuthEnabled: _repository.getAuthEnabled(),
      locale: langCode != null ? Locale(langCode) : null,
    );
  }

  ThemeMode _parseThemeMode(String mode) {
    if (mode == 'dark') return ThemeMode.dark;
    if (mode == 'light') return ThemeMode.light;
    return ThemeMode.system;
  }

  Future<void> updateThemeMode(ThemeMode mode) async {
    String modeStr = 'system';
    if (mode == ThemeMode.dark) modeStr = 'dark';
    if (mode == ThemeMode.light) modeStr = 'light';
    await _updateSettingsUseCase(themeMode: modeStr);
    state = state.copyWith(themeMode: mode);
  }

  Future<void> updateFontSize(double multiplier) async {
    await _updateSettingsUseCase(fontSizeScale: multiplier);
    state = state.copyWith(fontSizeMultiplier: multiplier);
  }

  Future<void> updatePalette(int index) async {
    await _updateSettingsUseCase(emotionPaletteIndex: index);
    state = state.copyWith(selectedPaletteIndex: index);
  }

  Future<void> updateLocale(Locale locale) async {
    await _updateSettingsUseCase(languageCode: locale.languageCode);
    state = state.copyWith(locale: locale);
  }

  Future<void> updateColorBlindMode(bool isEnabled) async {
    await _updateSettingsUseCase(isColorblindMode: isEnabled);
    state = state.copyWith(isColorBlindMode: isEnabled);
  }

  Future<void> toggleNotifications(bool isEnabled, String targetTitle, String targetBody, BuildContext context) async {
    try {
      if (isEnabled) {
        final granted = await _notificationService.requestPermissions();
        if (granted) {
          await _notificationService.scheduleDailyReminder(title: targetTitle, body: targetBody);
          await _updateSettingsUseCase(isNotificationsEnabled: true);
          state = state.copyWith(isNotificationsEnabled: true);
        } else {
          if (context.mounted) {
            final loc = AppLocalizations.of(context)!;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(loc.notifPermissionDenied)));
          }
        }
      } else {
        await _notificationService.cancelDailyReminder();
        await _updateSettingsUseCase(isNotificationsEnabled: false);
        state = state.copyWith(isNotificationsEnabled: false);
      }
    } catch (e) {
      if (context.mounted) {
        final loc = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(loc.errorGeneral)));
      }
    }
  }

  Future<void> toggleAuth(bool isEnabled, BuildContext context) async {
    if (isEnabled) {
      final isAvailable = await _localAuthService.isBiometricsAvailable();
      if (!isAvailable) {
        if (context.mounted) {
           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Dispositivo incompatible o sin biometría configurada.')));
        }
        return;
      }
      final success = await _localAuthService.authenticate(AppLocalizations.of(context)!.biometricReason);
      if (success) {
        await _updateSettingsUseCase(isAuthEnabled: true);
        state = state.copyWith(isAuthEnabled: true);
      } else {
        if (context.mounted) {
          final loc = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(loc.authFailed)));
        }
      }
    } else {
      await _updateSettingsUseCase(isAuthEnabled: false);
      state = state.copyWith(isAuthEnabled: false);
    }
  }

  ThemeData get lightTheme => AppThemeGenerator.generateTheme(state, isDark: false);
  ThemeData get darkTheme => AppThemeGenerator.generateTheme(state, isDark: true);
  ThemeMode get currentThemeMode => state.themeMode;
}
