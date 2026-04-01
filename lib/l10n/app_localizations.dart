import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ca.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ca'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ru'),
    Locale('zh')
  ];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'Colordary'**
  String get appTitle;

  /// No description provided for @homeTitle.
  ///
  /// In es, this message translates to:
  /// **'Mi Mes'**
  String get homeTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get settingsTitle;

  /// No description provided for @emotionAngry.
  ///
  /// In es, this message translates to:
  /// **'Enfadado'**
  String get emotionAngry;

  /// No description provided for @emotionSad.
  ///
  /// In es, this message translates to:
  /// **'Triste'**
  String get emotionSad;

  /// No description provided for @emotionNeutral.
  ///
  /// In es, this message translates to:
  /// **'Neutro'**
  String get emotionNeutral;

  /// No description provided for @emotionRelaxed.
  ///
  /// In es, this message translates to:
  /// **'Relajado'**
  String get emotionRelaxed;

  /// No description provided for @emotionHappy.
  ///
  /// In es, this message translates to:
  /// **'Feliz'**
  String get emotionHappy;

  /// No description provided for @colorBlindMode.
  ///
  /// In es, this message translates to:
  /// **'Modo Daltónico'**
  String get colorBlindMode;

  /// No description provided for @colorBlindModeDesc.
  ///
  /// In es, this message translates to:
  /// **'Iconos y patrones para mayor contraste'**
  String get colorBlindModeDesc;

  /// No description provided for @themeMode.
  ///
  /// In es, this message translates to:
  /// **'Tema'**
  String get themeMode;

  /// No description provided for @themeLight.
  ///
  /// In es, this message translates to:
  /// **'Claro'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In es, this message translates to:
  /// **'Oscuro'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In es, this message translates to:
  /// **'Sistema'**
  String get themeSystem;

  /// No description provided for @palette.
  ///
  /// In es, this message translates to:
  /// **'Paleta de Colores'**
  String get palette;

  /// No description provided for @paletteDefault.
  ///
  /// In es, this message translates to:
  /// **'Pastel (Por defecto)'**
  String get paletteDefault;

  /// No description provided for @paletteNature.
  ///
  /// In es, this message translates to:
  /// **'Naturaleza'**
  String get paletteNature;

  /// No description provided for @paletteSunset.
  ///
  /// In es, this message translates to:
  /// **'Atardecer'**
  String get paletteSunset;

  /// No description provided for @fontSize.
  ///
  /// In es, this message translates to:
  /// **'Tamaño de Letra'**
  String get fontSize;

  /// No description provided for @fontSizeSmall.
  ///
  /// In es, this message translates to:
  /// **'Pequeño'**
  String get fontSizeSmall;

  /// No description provided for @fontSizeMedium.
  ///
  /// In es, this message translates to:
  /// **'Mediano'**
  String get fontSizeMedium;

  /// No description provided for @fontSizeLarge.
  ///
  /// In es, this message translates to:
  /// **'Grande'**
  String get fontSizeLarge;

  /// No description provided for @save.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get save;

  /// No description provided for @successSaved.
  ///
  /// In es, this message translates to:
  /// **'Guardado correctamente'**
  String get successSaved;

  /// No description provided for @errorPastDate.
  ///
  /// In es, this message translates to:
  /// **'Solo puedes editar la entrada de hoy'**
  String get errorPastDate;

  /// No description provided for @errorGeneral.
  ///
  /// In es, this message translates to:
  /// **'Ha ocurrido un error inesperado'**
  String get errorGeneral;

  /// No description provided for @dailyEntryHint.
  ///
  /// In es, this message translates to:
  /// **'¿Qué tal ha ido tu día?'**
  String get dailyEntryHint;

  /// No description provided for @selectEmotion.
  ///
  /// In es, this message translates to:
  /// **'Selecciona tu estado de ánimo'**
  String get selectEmotion;

  /// No description provided for @sectionAppearance.
  ///
  /// In es, this message translates to:
  /// **'Apariencia'**
  String get sectionAppearance;

  /// No description provided for @sectionPrivacy.
  ///
  /// In es, this message translates to:
  /// **'Privacidad'**
  String get sectionPrivacy;

  /// No description provided for @sectionLanguage.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get sectionLanguage;

  /// No description provided for @sectionAccessibility.
  ///
  /// In es, this message translates to:
  /// **'Accesibilidad'**
  String get sectionAccessibility;

  /// No description provided for @authTitle.
  ///
  /// In es, this message translates to:
  /// **'Protección de Acceso'**
  String get authTitle;

  /// No description provided for @authSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Bloquea el diario al abrir la aplicación'**
  String get authSubtitle;

  /// No description provided for @authSwitch.
  ///
  /// In es, this message translates to:
  /// **'Requerir Huella/PIN'**
  String get authSwitch;

  /// No description provided for @languageSelector.
  ///
  /// In es, this message translates to:
  /// **'Selección de Idioma'**
  String get languageSelector;

  /// No description provided for @notificationTitle.
  ///
  /// In es, this message translates to:
  /// **'Recordatorio Diario'**
  String get notificationTitle;

  /// No description provided for @notificationSubtitle.
  ///
  /// In es, this message translates to:
  /// **'¿Te avisamos para rellenar el diario?'**
  String get notificationSubtitle;

  /// No description provided for @notificationTime.
  ///
  /// In es, this message translates to:
  /// **'Aviso a las 21:00h'**
  String get notificationTime;

  /// No description provided for @accessibilityPatterns.
  ///
  /// In es, this message translates to:
  /// **'Activar Patrones e Iconos'**
  String get accessibilityPatterns;

  /// No description provided for @biometricReason.
  ///
  /// In es, this message translates to:
  /// **'Protege tu refugio diario comprobando tu identidad'**
  String get biometricReason;

  /// No description provided for @authFailed.
  ///
  /// In es, this message translates to:
  /// **'Autenticación fallida'**
  String get authFailed;

  /// No description provided for @notifPermissionDenied.
  ///
  /// In es, this message translates to:
  /// **'Permiso de notificaciones denegado'**
  String get notifPermissionDenied;

  /// No description provided for @notificationTest.
  ///
  /// In es, this message translates to:
  /// **'Enviar notificación de prueba'**
  String get notificationTest;

  /// No description provided for @notificationTestSent.
  ///
  /// In es, this message translates to:
  /// **'Notificación de prueba enviada'**
  String get notificationTestSent;

  /// No description provided for @textPreview.
  ///
  /// In es, this message translates to:
  /// **'Previsualización del texto'**
  String get textPreview;

  /// No description provided for @exportDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha'**
  String get exportDate;

  /// No description provided for @exportEmotion.
  ///
  /// In es, this message translates to:
  /// **'Emoción registrada'**
  String get exportEmotion;

  /// No description provided for @exportReflection.
  ///
  /// In es, this message translates to:
  /// **'Reflexión'**
  String get exportReflection;

  /// No description provided for @exportLabel.
  ///
  /// In es, this message translates to:
  /// **'Exportar TXT'**
  String get exportLabel;

  /// No description provided for @statsTitle.
  ///
  /// In es, this message translates to:
  /// **'Resumen del Mes'**
  String get statsTitle;

  /// No description provided for @statsHeader.
  ///
  /// In es, this message translates to:
  /// **'Estadísticas de este Mes'**
  String get statsHeader;

  /// No description provided for @statsNoData.
  ///
  /// In es, this message translates to:
  /// **'No hay datos todavía.'**
  String get statsNoData;

  /// No description provided for @closeMonthTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Cerrar Mes y Purgar Textos?'**
  String get closeMonthTitle;

  /// No description provided for @closeMonthContent.
  ///
  /// In es, this message translates to:
  /// **'Se conservarán las gráficas del estado de ánimo pero TODOS los detalles escritos individuales de este mes serán borrados para siempre.'**
  String get closeMonthContent;

  /// No description provided for @closeMonthSuccess.
  ///
  /// In es, this message translates to:
  /// **'Mes cerrado correctamente. Textos borrados.'**
  String get closeMonthSuccess;

  /// No description provided for @closeMonthLabel.
  ///
  /// In es, this message translates to:
  /// **'Cerrar Mes'**
  String get closeMonthLabel;

  /// No description provided for @historyTitle.
  ///
  /// In es, this message translates to:
  /// **'Historial Acumulado'**
  String get historyTitle;

  /// No description provided for @historyNoData.
  ///
  /// In es, this message translates to:
  /// **'No hay resúmenes históricos todavía.'**
  String get historyNoData;

  /// No description provided for @historyTotalEvents.
  ///
  /// In es, this message translates to:
  /// **'Eventos totales registrados: {count}'**
  String historyTotalEvents(Object count);

  /// No description provided for @diaryReminderMessage.
  ///
  /// In es, this message translates to:
  /// **'No olvides rellenar tu diario'**
  String get diaryReminderMessage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ca',
        'de',
        'en',
        'es',
        'fr',
        'it',
        'ja',
        'ko',
        'pt',
        'ru',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ca':
      return AppLocalizationsCa();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
