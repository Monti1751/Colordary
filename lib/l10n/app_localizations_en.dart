// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Colordary';

  @override
  String get homeTitle => 'My Month';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get emotionAngry => 'Angry';

  @override
  String get emotionSad => 'Sad';

  @override
  String get emotionNeutral => 'Neutral';

  @override
  String get emotionRelaxed => 'Relaxed';

  @override
  String get emotionHappy => 'Happy';

  @override
  String get colorBlindMode => 'Colorblind Mode';

  @override
  String get colorBlindModeDesc => 'Icons and patterns for higher contrast';

  @override
  String get themeMode => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get palette => 'Color Palette';

  @override
  String get paletteDefault => 'Pastel (Default)';

  @override
  String get paletteNature => 'Nature';

  @override
  String get paletteSunset => 'Sunset';

  @override
  String get fontSize => 'Font Size';

  @override
  String get fontSizeSmall => 'Small';

  @override
  String get fontSizeMedium => 'Medium';

  @override
  String get fontSizeLarge => 'Large';

  @override
  String get save => 'Save';

  @override
  String get successSaved => 'Saved successfully';

  @override
  String get errorPastDate => 'You can only edit today\'s entry';

  @override
  String get errorGeneral => 'An unexpected error occurred';

  @override
  String get dailyEntryHint => 'How was your day?';

  @override
  String get selectEmotion => 'Select your mood';

  @override
  String get sectionAppearance => 'Appearance';

  @override
  String get sectionPrivacy => 'Privacy';

  @override
  String get sectionLanguage => 'Language';

  @override
  String get sectionAccessibility => 'Accessibility';

  @override
  String get authTitle => 'Access Protection';

  @override
  String get authSubtitle => 'Locks the diary when opening the app';

  @override
  String get authSwitch => 'Require Fingerprint/PIN';

  @override
  String get languageSelector => 'Language Selection';

  @override
  String get notificationTitle => 'Daily Reminder';

  @override
  String get notificationSubtitle => 'Should we remind you to fill your diary?';

  @override
  String get notificationTime => 'Reminder at 21:00h';

  @override
  String get accessibilityPatterns => 'Enable Patterns and Icons';

  @override
  String get biometricReason =>
      'Protect your daily sanctuary by verifying your identity';

  @override
  String get authFailed => 'Authentication failed';

  @override
  String get notifPermissionDenied => 'Notification permission denied';

  @override
  String get textPreview => 'Text Preview';

  @override
  String get exportDate => 'Date';

  @override
  String get exportEmotion => 'Registered Emotion';

  @override
  String get exportReflection => 'Reflection';

  @override
  String get exportLabel => 'Export TXT';

  @override
  String get statsTitle => 'Monthly Summary';

  @override
  String get statsHeader => 'Statistics of this Month';

  @override
  String get statsNoData => 'No data yet.';

  @override
  String get closeMonthTitle => 'Close Month and Purge Texts?';

  @override
  String get closeMonthContent =>
      'Mood charts will be kept, but ALL individual written details from this month will be permanently deleted.';

  @override
  String get closeMonthSuccess => 'Month closed successfully. Texts deleted.';

  @override
  String get closeMonthLabel => 'Close Month';

  @override
  String get historyTitle => 'Cumulative History';

  @override
  String get historyNoData => 'No historical summaries yet.';

  @override
  String historyTotalEvents(Object count) {
    return 'Total registered events: $count';
  }
}
