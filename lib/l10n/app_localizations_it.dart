// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Colordary';

  @override
  String get homeTitle => 'Il mio Mese';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get emotionAngry => 'Arrabbiato';

  @override
  String get emotionSad => 'Triste';

  @override
  String get emotionNeutral => 'Neutrale';

  @override
  String get emotionRelaxed => 'Rilassato';

  @override
  String get emotionHappy => 'Felice';

  @override
  String get colorBlindMode => 'Modalità Daltonica';

  @override
  String get colorBlindModeDesc => 'Icone e pattern per un contrasto maggiore';

  @override
  String get themeMode => 'Tema';

  @override
  String get themeLight => 'Chiaro';

  @override
  String get themeDark => 'Scuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get palette => 'Tavolozza dei Colori';

  @override
  String get paletteDefault => 'Pastello (Predefinito)';

  @override
  String get paletteNature => 'Natura';

  @override
  String get paletteSunset => 'Tramonto';

  @override
  String get fontSize => 'Dimensione Carattere';

  @override
  String get fontSizeSmall => 'Piccolo';

  @override
  String get fontSizeMedium => 'Medio';

  @override
  String get fontSizeLarge => 'Grande';

  @override
  String get save => 'Salva';

  @override
  String get successSaved => 'Salvato correttamente';

  @override
  String get errorPastDate => 'Puoi modificare solo la voce di oggi';

  @override
  String get errorGeneral => 'Si è verificato un errore imprevisto';

  @override
  String get dailyEntryHint => 'Com\'è andata la tua giornata?';

  @override
  String get selectEmotion => 'Seleziona il tuo stato d\'animo';

  @override
  String get sectionAppearance => 'Aspetto';

  @override
  String get sectionPrivacy => 'Privacy';

  @override
  String get sectionLanguage => 'Lingua';

  @override
  String get sectionAccessibility => 'Accessibilità';

  @override
  String get authTitle => 'Protezione Accesso';

  @override
  String get authSubtitle => 'Blocca il diario all\'apertura';

  @override
  String get authSwitch => 'Richiedi Impronta/PIN';

  @override
  String get languageSelector => 'Selezione Lingua';

  @override
  String get notificationTitle => 'Promemoria Quotidiano';

  @override
  String get notificationSubtitle => 'Vuoi un avviso per compilare il diario?';

  @override
  String get notificationTime => 'Avviso alle 21:00';

  @override
  String get accessibilityPatterns => 'Attiva Pattern e Icone';

  @override
  String get biometricReason =>
      'Proteggi il tuo rifugio quotidiano verificando la tua identità';

  @override
  String get authFailed => 'Autenticazione fallita';

  @override
  String get notifPermissionDenied => 'Permesso di notifica negato';

  @override
  String get notificationTest => 'Invia notifica di prova';

  @override
  String get notificationTestSent => 'Notifica di prova inviata';

  @override
  String get textPreview => 'Anteprima del testo';

  @override
  String get exportDate => 'Data';

  @override
  String get exportEmotion => 'Emozione registrata';

  @override
  String get exportReflection => 'Riflessione';

  @override
  String get exportLabel => 'Esporta TXT';

  @override
  String get statsTitle => 'Riepilogo mensile';

  @override
  String get statsHeader => 'Statistiche del mese';

  @override
  String get statsNoData => 'Nessun dato ancora.';

  @override
  String get closeMonthTitle => 'Chiudere il mese e cancellare i testi?';

  @override
  String get closeMonthContent =>
      'I grafici rimarranno, ma TUTTI i dettagli scritti di questo mese saranno cancellati per sempre.';

  @override
  String get closeMonthSuccess =>
      'Mese chiuso correttamente. Testi cancellati.';

  @override
  String get closeMonthLabel => 'Chiudi mese';

  @override
  String get historyTitle => 'Cronologia accumulata';

  @override
  String get historyNoData => 'Nessun riepilogo storico ancora.';

  @override
  String historyTotalEvents(Object count) {
    return 'Eventi totali registrati: $count';
  }

  @override
  String get diaryReminderMessage =>
      'Non dimenticare di compilare il tuo diario';
}
