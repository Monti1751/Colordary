class AppStrings {
  AppStrings._();
  
  static const String appName = 'Colordary';

  // --- Database ---
  static const String databaseName = 'cozy_diary.db';
  static const int databaseVersion = 1;

  // Tablas y Columnas SQFlite
  static const String tableDiary = 'diary_entries';
  static const String columnId = 'id';
  static const String columnDate = 'date';
  static const String columnContent = 'content';
  static const String columnEmotionIndex = 'emotion_index';

  static const String tableMonthlySummary = 'monthly_summaries';
  static const String columnMonthYear = 'month_year'; // Format: YYYY-MM
  static const String columnStatsJson = 'stats_json'; // Metadatos/estadísticas json

  // --- SharedPreferences Keys ---
  static const String prefKeyThemeMode = 'pref_theme_mode'; 
  static const String prefKeyColorblindMode = 'pref_colorblind_mode'; 
  static const String prefKeyFontSizeScale = 'pref_font_size_scale'; 
  static const String prefKeyEmotionPalette = 'pref_emotion_palette'; 
  static const String prefKeyNotificationEnabled = 'pref_notification_enabled'; 
  static const String prefKeyNotificationHour = 'pref_notification_hour'; 
  static const String prefKeyNotificationMinute = 'pref_notification_minute'; 
}
