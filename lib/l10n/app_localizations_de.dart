// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Colordary';

  @override
  String get homeTitle => 'Mein Monat';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get emotionAngry => 'Wütend';

  @override
  String get emotionSad => 'Traurig';

  @override
  String get emotionNeutral => 'Neutral';

  @override
  String get emotionRelaxed => 'Entspannt';

  @override
  String get emotionHappy => 'Glücklich';

  @override
  String get colorBlindMode => 'Farbenblind-Modus';

  @override
  String get colorBlindModeDesc => 'Symbole und Muster für besseren Kontrast';

  @override
  String get themeMode => 'Thema';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get themeSystem => 'System';

  @override
  String get palette => 'Farbpalette';

  @override
  String get paletteDefault => 'Pastell (Standard)';

  @override
  String get paletteNature => 'Natur';

  @override
  String get paletteSunset => 'Sonnenuntergang';

  @override
  String get fontSize => 'Schriftgröße';

  @override
  String get fontSizeSmall => 'Klein';

  @override
  String get fontSizeMedium => 'Mittel';

  @override
  String get fontSizeLarge => 'Groß';

  @override
  String get save => 'Speichern';

  @override
  String get successSaved => 'Erfolgreich gespeichert';

  @override
  String get errorPastDate => 'Sie können nur den heutigen Eintrag bearbeiten';

  @override
  String get errorGeneral => 'Ein unerwarteter Fehler ist aufgetreten';

  @override
  String get dailyEntryHint => 'Wie war dein Tag?';

  @override
  String get selectEmotion => 'Wählen Sie Ihre Stimmung';

  @override
  String get sectionAppearance => 'Erscheinungsbild';

  @override
  String get sectionPrivacy => 'Datenschutz';

  @override
  String get sectionLanguage => 'Sprache';

  @override
  String get sectionAccessibility => 'Barrierefreiheit';

  @override
  String get authTitle => 'Zugriffsschutz';

  @override
  String get authSubtitle => 'Tagebuch beim Öffnen sperren';

  @override
  String get authSwitch => 'Fingerabdruck/PIN erforderlich';

  @override
  String get languageSelector => 'Sprachauswahl';

  @override
  String get notificationTitle => 'Tägliche Erinnerung';

  @override
  String get notificationSubtitle =>
      'Möchten Sie an das Tagebuch erinnert werden?';

  @override
  String get notificationTime => 'Benachrichtigung um 21:00 Uhr';

  @override
  String get accessibilityPatterns => 'Muster und Symbole aktivieren';

  @override
  String get biometricReason =>
      'Schützen Sie Ihren täglichen Rückzugsort durch Identitätsprüfung';

  @override
  String get authFailed => 'Authentifizierung fehlgeschlagen';

  @override
  String get notifPermissionDenied => 'Benachrichtigungsberechtigung abgelehnt';

  @override
  String get textPreview => 'Textvorschau';

  @override
  String get exportDate => 'Datum';

  @override
  String get exportEmotion => 'Registrierte Emotion';

  @override
  String get exportReflection => 'Reflexion';

  @override
  String get exportLabel => 'TXT Exportieren';

  @override
  String get statsTitle => 'Monatsübersicht';

  @override
  String get statsHeader => 'Statistiken dieses Monats';

  @override
  String get statsNoData => 'Noch keine Daten.';

  @override
  String get closeMonthTitle => 'Monat schließen und Texte löschen?';

  @override
  String get closeMonthContent =>
      'Stimmungsgrafiken bleiben erhalten, aber ALLE schriftlichen Details dieses Monats werden dauerhaft gelöscht.';

  @override
  String get closeMonthSuccess =>
      'Monat erfolgreich geschlossen. Texte gelöscht.';

  @override
  String get closeMonthLabel => 'Monat schließen';

  @override
  String get historyTitle => 'Kumulierter Verlauf';

  @override
  String get historyNoData => 'Noch keine historischen Zusammenfassungen.';

  @override
  String historyTotalEvents(Object count) {
    return 'Registrierte Ereignisse insgesamt: $count';
  }
}
