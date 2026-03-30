// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get appTitle => 'Colordary';

  @override
  String get homeTitle => 'El meu Mes';

  @override
  String get settingsTitle => 'Ajustaments';

  @override
  String get emotionAngry => 'Enfadat';

  @override
  String get emotionSad => 'Trist';

  @override
  String get emotionNeutral => 'Neutre';

  @override
  String get emotionRelaxed => 'Relaxat';

  @override
  String get emotionHappy => 'Feliç';

  @override
  String get colorBlindMode => 'Mode Daltònic';

  @override
  String get colorBlindModeDesc => 'Icones i patrons per major contrast';

  @override
  String get themeMode => 'Tema';

  @override
  String get themeLight => 'Clar';

  @override
  String get themeDark => 'Fosc';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get palette => 'Paleta de Colors';

  @override
  String get paletteDefault => 'Pastís (Per defecte)';

  @override
  String get paletteNature => 'Natura';

  @override
  String get paletteSunset => 'Capvespre';

  @override
  String get fontSize => 'Mida de Lletra';

  @override
  String get fontSizeSmall => 'Petit';

  @override
  String get fontSizeMedium => 'Mitjà';

  @override
  String get fontSizeLarge => 'Gran';

  @override
  String get save => 'Desar';

  @override
  String get successSaved => 'Desat correctament';

  @override
  String get errorPastDate => 'Només pots editar l\'entrada d\'avui';

  @override
  String get errorGeneral => 'S\'ha produït un error inesperat';

  @override
  String get dailyEntryHint => 'Com ha anat el teu dia?';

  @override
  String get selectEmotion => 'Selecciona el teu estat d\'ànim';

  @override
  String get sectionAppearance => 'Apariència';

  @override
  String get sectionPrivacy => 'Privadesa';

  @override
  String get sectionLanguage => 'Idioma';

  @override
  String get sectionAccessibility => 'Accessibilitat';

  @override
  String get authTitle => 'Protecció d\'Accés';

  @override
  String get authSubtitle => 'Bloca el diari al obrir l\'aplicació';

  @override
  String get authSwitch => 'Requerir Empremta/PIN';

  @override
  String get languageSelector => 'Selecció d\'Idioma';

  @override
  String get notificationTitle => 'Recordatori Diari';

  @override
  String get notificationSubtitle => 'Et recordem d\'escriure al diari?';

  @override
  String get notificationTime => 'Avís a les 21:00h';

  @override
  String get accessibilityPatterns => 'Activar Patrons i Icones';

  @override
  String get biometricReason =>
      'Protegeix el teu refugi diari comprovant la teva identitat';

  @override
  String get authFailed => 'Autenticació fallida';

  @override
  String get notifPermissionDenied => 'Permís de notificacions denegat';

  @override
  String get textPreview => 'Previsualització del text';

  @override
  String get exportDate => 'Data';

  @override
  String get exportEmotion => 'Emoció registrada';

  @override
  String get exportReflection => 'Reflexió';

  @override
  String get exportLabel => 'Exportar TXT';

  @override
  String get statsTitle => 'Resum del Mes';

  @override
  String get statsHeader => 'Estadístiques d\'aquest Mes';

  @override
  String get statsNoData => 'No hi ha dades encara.';

  @override
  String get closeMonthTitle => 'Tancar Mes i Purgar Textos?';

  @override
  String get closeMonthContent =>
      'Es conservaran les gràfiques de l\'estat d\'ànim però TOTS els detalls escrits de l\'mes seran esborrats per sempre.';

  @override
  String get closeMonthSuccess => 'Mes tancat correctament. Textos esborrats.';

  @override
  String get closeMonthLabel => 'Tancar Mes';

  @override
  String get historyTitle => 'Historial Acumulat';

  @override
  String get historyNoData => 'No hi ha resums històrics encara.';

  @override
  String historyTotalEvents(Object count) {
    return 'Esdeveniments totals registrats: $count';
  }
}
