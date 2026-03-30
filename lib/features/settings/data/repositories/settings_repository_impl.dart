import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPreferences prefs;
  SettingsRepositoryImpl({required this.prefs});

  @override
  Future<void> saveThemeMode(String mode) async => await prefs.setString(AppStrings.prefKeyThemeMode, mode);

  @override
  Future<void> saveColorblindMode(bool isEnabled) async => await prefs.setBool(AppStrings.prefKeyColorblindMode, isEnabled);

  @override
  Future<void> saveFontSizeScale(double scale) async => await prefs.setDouble(AppStrings.prefKeyFontSizeScale, scale);

  @override
  Future<void> saveEmotionPaletteIndex(int index) async => await prefs.setInt(AppStrings.prefKeyEmotionPalette, index);

  @override
  Future<void> saveNotificationsEnabled(bool isEnabled) async => await prefs.setBool(AppStrings.prefKeyNotificationEnabled, isEnabled);

  @override
  Future<void> saveAuthEnabled(bool isEnabled) async => await prefs.setBool('pref_auth_enabled', isEnabled);

  @override
  Future<void> saveLanguageCode(String code) async => await prefs.setString('pref_language_code', code);

  String getThemeMode() => prefs.getString(AppStrings.prefKeyThemeMode) ?? 'system';
  bool getColorblindMode() => prefs.getBool(AppStrings.prefKeyColorblindMode) ?? false;
  double getFontSizeScale() => prefs.getDouble(AppStrings.prefKeyFontSizeScale) ?? 1.0;
  int getEmotionPaletteIndex() => prefs.getInt(AppStrings.prefKeyEmotionPalette) ?? 0;
  bool getNotificationsEnabled() => prefs.getBool(AppStrings.prefKeyNotificationEnabled) ?? false;
  
  @override
  bool getAuthEnabled() => prefs.getBool('pref_auth_enabled') ?? false;

  @override
  String? getLanguageCode() => prefs.getString('pref_language_code');
}
