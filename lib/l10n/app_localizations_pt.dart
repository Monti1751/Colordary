// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Colordary';

  @override
  String get homeTitle => 'Meu Mês';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get emotionAngry => 'Zangado';

  @override
  String get emotionSad => 'Triste';

  @override
  String get emotionNeutral => 'Neutro';

  @override
  String get emotionRelaxed => 'Relaxado';

  @override
  String get emotionHappy => 'Feliz';

  @override
  String get colorBlindMode => 'Modo Daltônico';

  @override
  String get colorBlindModeDesc => 'Ícones e padrões para maior contraste';

  @override
  String get themeMode => 'Tema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get palette => 'Paleta de Cores';

  @override
  String get paletteDefault => 'Pastel (Padrão)';

  @override
  String get paletteNature => 'Natureza';

  @override
  String get paletteSunset => 'Pôr do sol';

  @override
  String get fontSize => 'Tamanho da Fonte';

  @override
  String get fontSizeSmall => 'Pequeno';

  @override
  String get fontSizeMedium => 'Médio';

  @override
  String get fontSizeLarge => 'Grande';

  @override
  String get save => 'Salvar';

  @override
  String get successSaved => 'Salvo com sucesso';

  @override
  String get errorPastDate => 'Você só pode editar a entrada de hoje';

  @override
  String get errorGeneral => 'Ocorreu um erro inesperado';

  @override
  String get dailyEntryHint => 'Como foi o seu dia?';

  @override
  String get selectEmotion => 'Selecione seu estado de espírito';

  @override
  String get sectionAppearance => 'Aparência';

  @override
  String get sectionPrivacy => 'Privacidade';

  @override
  String get sectionLanguage => 'Idioma';

  @override
  String get sectionAccessibility => 'Acessibilidade';

  @override
  String get authTitle => 'Proteção de Acesso';

  @override
  String get authSubtitle => 'Bloquear o diário ao abrir o aplicativo';

  @override
  String get authSwitch => 'Exigir Impressão Digital/PIN';

  @override
  String get languageSelector => 'Seleção de Idioma';

  @override
  String get notificationTitle => 'Lembrete Diário';

  @override
  String get notificationSubtitle => 'Deseja um aviso para preencher o diário?';

  @override
  String get notificationTime => 'Aviso às 21:00h';

  @override
  String get accessibilityPatterns => 'Ativar Padrões e Ícones';

  @override
  String get biometricReason =>
      'Proteja seu refúgio diário confirmando sua identidade';

  @override
  String get authFailed => 'Falha na autenticação';

  @override
  String get notifPermissionDenied => 'Permissão de notificações negada';

  @override
  String get textPreview => 'Visualização do texto';

  @override
  String get exportDate => 'Data';

  @override
  String get exportEmotion => 'Emoção registrada';

  @override
  String get exportReflection => 'Reflexão';

  @override
  String get exportLabel => 'Exportar TXT';

  @override
  String get statsTitle => 'Resumo do mês';

  @override
  String get statsHeader => 'Estatísticas deste mês';

  @override
  String get statsNoData => 'Sem dados ainda.';

  @override
  String get closeMonthTitle => 'Fechar mês e apagar textos?';

  @override
  String get closeMonthContent =>
      'Os gráficos serão mantidos, mas TODOS os detalhes escritos deste mês serão apagados para sempre.';

  @override
  String get closeMonthSuccess => 'Mês fechado com sucesso. Textos apagados.';

  @override
  String get closeMonthLabel => 'Fechar mês';

  @override
  String get historyTitle => 'Histórico acumulado';

  @override
  String get historyNoData => 'Sem resumos históricos ainda.';

  @override
  String historyTotalEvents(Object count) {
    return 'Eventos totais registrados: $count';
  }
}
