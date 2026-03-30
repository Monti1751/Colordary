// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Colordary';

  @override
  String get homeTitle => 'Мой месяц';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get emotionAngry => 'Злой';

  @override
  String get emotionSad => 'Грустный';

  @override
  String get emotionNeutral => 'Нейтральный';

  @override
  String get emotionRelaxed => 'Спокойный';

  @override
  String get emotionHappy => 'Счастливый';

  @override
  String get colorBlindMode => 'Режим для дальтоников';

  @override
  String get colorBlindModeDesc => 'Иконки и узоры для лучшей контрастности';

  @override
  String get themeMode => 'Тема';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Темная';

  @override
  String get themeSystem => 'Системная';

  @override
  String get palette => 'Цветовая палитра';

  @override
  String get paletteDefault => 'Пастель (По умолчанию)';

  @override
  String get paletteNature => 'Природа';

  @override
  String get paletteSunset => 'Закат';

  @override
  String get fontSize => 'Размер шрифта';

  @override
  String get fontSizeSmall => 'Маленький';

  @override
  String get fontSizeMedium => 'Средний';

  @override
  String get fontSizeLarge => 'Большой';

  @override
  String get save => 'Сохранить';

  @override
  String get successSaved => 'Успешно сохранено';

  @override
  String get errorPastDate =>
      'Вы можете редактировать только сегодняшнюю запись';

  @override
  String get errorGeneral => 'Произошла непредвиденная ошибка';

  @override
  String get dailyEntryHint => 'Как прошел ваш день?';

  @override
  String get selectEmotion => 'Выберите свое настроение';

  @override
  String get sectionAppearance => 'Внешний вид';

  @override
  String get sectionPrivacy => 'Конфиденциальность';

  @override
  String get sectionLanguage => 'Язык';

  @override
  String get sectionAccessibility => 'Доступность';

  @override
  String get authTitle => 'Защита доступа';

  @override
  String get authSubtitle => 'Блокировать дневник при открытии';

  @override
  String get authSwitch => 'Требовать отпечаток/PIN';

  @override
  String get languageSelector => 'Выбор языка';

  @override
  String get notificationTitle => 'Ежедневное напоминание';

  @override
  String get notificationSubtitle => 'Хотите получать напоминания о дневнике?';

  @override
  String get notificationTime => 'Уведомление в 21:00';

  @override
  String get accessibilityPatterns => 'Активировать узоры и иконки';

  @override
  String get biometricReason =>
      'Защитите свое личное пространство, подтвердив личность';

  @override
  String get authFailed => 'Ошибка аутентификации';

  @override
  String get notifPermissionDenied => 'В доступе к уведомлениям отказано';

  @override
  String get textPreview => 'Предпросмотр текста';

  @override
  String get exportDate => 'Дата';

  @override
  String get exportEmotion => 'Зарегистрированная эмоция';

  @override
  String get exportReflection => 'Размышление';

  @override
  String get exportLabel => 'Экспорт TXT';

  @override
  String get statsTitle => 'Итоги месяца';

  @override
  String get statsHeader => 'Статистика за месяц';

  @override
  String get statsNoData => 'Данных пока нет.';

  @override
  String get closeMonthTitle => 'Закрыть месяц и удалить тексты?';

  @override
  String get closeMonthContent =>
      'Графики сохранятся, но ВСЕ письменные записи за этот месяц будут удалены навсегда.';

  @override
  String get closeMonthSuccess => 'Месяц успешно закрыт. Записи удалены.';

  @override
  String get closeMonthLabel => 'Закрыть месяц';

  @override
  String get historyTitle => 'Накопленная история';

  @override
  String get historyNoData => 'Исторических сводок пока нет.';

  @override
  String historyTotalEvents(Object count) {
    return 'Всего событий: $count';
  }
}
