// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Colordary';

  @override
  String get homeTitle => 'Mi Mes';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get emotionAngry => 'Enfadado';

  @override
  String get emotionSad => 'Triste';

  @override
  String get emotionNeutral => 'Neutro';

  @override
  String get emotionRelaxed => 'Relajado';

  @override
  String get emotionHappy => 'Feliz';

  @override
  String get colorBlindMode => 'Modo Daltónico';

  @override
  String get colorBlindModeDesc => 'Iconos y patrones para mayor contraste';

  @override
  String get themeMode => 'Tema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get palette => 'Paleta de Colores';

  @override
  String get paletteDefault => 'Pastel (Por defecto)';

  @override
  String get paletteNature => 'Naturaleza';

  @override
  String get paletteSunset => 'Atardecer';

  @override
  String get fontSize => 'Tamaño de Letra';

  @override
  String get fontSizeSmall => 'Pequeño';

  @override
  String get fontSizeMedium => 'Mediano';

  @override
  String get fontSizeLarge => 'Grande';

  @override
  String get save => 'Guardar';

  @override
  String get successSaved => 'Guardado correctamente';

  @override
  String get errorPastDate => 'Solo puedes editar la entrada de hoy';

  @override
  String get errorGeneral => 'Ha ocurrido un error inesperado';

  @override
  String get dailyEntryHint => '¿Qué tal ha ido tu día?';

  @override
  String get selectEmotion => 'Selecciona tu estado de ánimo';

  @override
  String get sectionAppearance => 'Apariencia';

  @override
  String get sectionPrivacy => 'Privacidad';

  @override
  String get sectionLanguage => 'Idioma';

  @override
  String get sectionAccessibility => 'Accesibilidad';

  @override
  String get authTitle => 'Protección de Acceso';

  @override
  String get authSubtitle => 'Bloquea el diario al abrir la aplicación';

  @override
  String get authSwitch => 'Requerir Huella/PIN';

  @override
  String get languageSelector => 'Selección de Idioma';

  @override
  String get notificationTitle => 'Recordatorio Diario';

  @override
  String get notificationSubtitle => '¿Te avisamos para rellenar el diario?';

  @override
  String get notificationTime => 'Aviso a las 21:00h';

  @override
  String get accessibilityPatterns => 'Activar Patrones e Iconos';

  @override
  String get biometricReason =>
      'Protege tu refugio diario comprobando tu identidad';

  @override
  String get authFailed => 'Autenticación fallida';

  @override
  String get notifPermissionDenied => 'Permiso de notificaciones denegado';

  @override
  String get notificationTest => 'Enviar notificación de prueba';

  @override
  String get notificationTestSent => 'Notificación de prueba enviada';

  @override
  String get textPreview => 'Previsualización del texto';

  @override
  String get exportDate => 'Fecha';

  @override
  String get exportEmotion => 'Emoción registrada';

  @override
  String get exportReflection => 'Reflexión';

  @override
  String get exportLabel => 'Exportar TXT';

  @override
  String get statsTitle => 'Resumen del Mes';

  @override
  String get statsHeader => 'Estadísticas de este Mes';

  @override
  String get statsNoData => 'No hay datos todavía.';

  @override
  String get closeMonthTitle => '¿Cerrar Mes y Purgar Textos?';

  @override
  String get closeMonthContent =>
      'Se conservarán las gráficas del estado de ánimo pero TODOS los detalles escritos individuales de este mes serán borrados para siempre.';

  @override
  String get closeMonthSuccess => 'Mes cerrado correctamente. Textos borrados.';

  @override
  String get closeMonthLabel => 'Cerrar Mes';

  @override
  String get historyTitle => 'Historial Acumulado';

  @override
  String get historyNoData => 'No hay resúmenes históricos todavía.';

  @override
  String historyTotalEvents(Object count) {
    return 'Eventos totales registrados: $count';
  }

  @override
  String get diaryReminderMessage => 'No olvides rellenar tu diario';
}
