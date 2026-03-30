abstract class SettingsRepository {
  Future<void> saveThemeMode(String mode);
  Future<void> saveColorblindMode(bool isEnabled);
  Future<void> saveFontSizeScale(double scale);
  Future<void> saveEmotionPaletteIndex(int index);
  Future<void> saveNotificationsEnabled(bool isEnabled);
  Future<void> saveAuthEnabled(bool isEnabled);
  Future<void> saveLanguageCode(String code);
  
  bool getAuthEnabled();
  String? getLanguageCode();
}
