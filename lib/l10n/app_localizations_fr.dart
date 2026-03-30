// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Colordary';

  @override
  String get homeTitle => 'Mon Mois';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get emotionAngry => 'En colère';

  @override
  String get emotionSad => 'Triste';

  @override
  String get emotionNeutral => 'Neutre';

  @override
  String get emotionRelaxed => 'Détendu';

  @override
  String get emotionHappy => 'Heureux';

  @override
  String get colorBlindMode => 'Mode daltonien';

  @override
  String get colorBlindModeDesc =>
      'Icônes et motifs pour un meilleur contraste';

  @override
  String get themeMode => 'Thème';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get themeSystem => 'Système';

  @override
  String get palette => 'Palette de couleurs';

  @override
  String get paletteDefault => 'Pastel (Par défaut)';

  @override
  String get paletteNature => 'Nature';

  @override
  String get paletteSunset => 'Coucher de soleil';

  @override
  String get fontSize => 'Taille de police';

  @override
  String get fontSizeSmall => 'Petit';

  @override
  String get fontSizeMedium => 'Moyen';

  @override
  String get fontSizeLarge => 'Grand';

  @override
  String get save => 'Enregistrer';

  @override
  String get successSaved => 'Enregistré avec succès';

  @override
  String get errorPastDate =>
      'Vous ne pouvez éditer que l\'entrée d\'aujourd\'hui';

  @override
  String get errorGeneral => 'Une erreur inattendue s\'est produite';

  @override
  String get dailyEntryHint => 'Comment s\'est passée votre journée ?';

  @override
  String get selectEmotion => 'Sélectionnez votre humeur';

  @override
  String get sectionAppearance => 'Apparence';

  @override
  String get sectionPrivacy => 'Confidentialité';

  @override
  String get sectionLanguage => 'Langue';

  @override
  String get sectionAccessibility => 'Accessibilité';

  @override
  String get authTitle => 'Protection d\'accès';

  @override
  String get authSubtitle => 'Verrouiller le journal lors de l\'ouverture';

  @override
  String get authSwitch => 'Empreinte/PIN requis';

  @override
  String get languageSelector => 'Sélection de la langue';

  @override
  String get notificationTitle => 'Rappel quotidien';

  @override
  String get notificationSubtitle =>
      'Voulez-vous un rappel pour remplir votre journal ?';

  @override
  String get notificationTime => 'Avis à 21h00';

  @override
  String get accessibilityPatterns => 'Activer les motifs et icônes';

  @override
  String get biometricReason =>
      'Protégez votre refuge quotidien en vérifiant votre identité';

  @override
  String get authFailed => 'Échec de l\'authentification';

  @override
  String get notifPermissionDenied => 'Permission de notification refusée';

  @override
  String get textPreview => 'Aperçu du texte';

  @override
  String get exportDate => 'Date';

  @override
  String get exportEmotion => 'Émotion enregistrée';

  @override
  String get exportReflection => 'Réflexion';

  @override
  String get exportLabel => 'Exporter TXT';

  @override
  String get statsTitle => 'Résumé du mois';

  @override
  String get statsHeader => 'Statistiques de ce mois';

  @override
  String get statsNoData => 'Pas encore de données.';

  @override
  String get closeMonthTitle => 'Fermer le mois et purger les textes ?';

  @override
  String get closeMonthContent =>
      'Les graphiques seront conservés, mais TOUS les détails écrits de ce mois seront définitivement supprimés.';

  @override
  String get closeMonthSuccess => 'Mois fermé avec succès. Textes supprimés.';

  @override
  String get closeMonthLabel => 'Fermer le mois';

  @override
  String get historyTitle => 'Historique cumulé';

  @override
  String get historyNoData => 'Pas encore de résumés historiques.';

  @override
  String historyTotalEvents(Object count) {
    return 'Total des événements enregistrés : $count';
  }
}
