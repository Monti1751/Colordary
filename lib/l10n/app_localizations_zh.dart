// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Colordary';

  @override
  String get homeTitle => '我的月份';

  @override
  String get settingsTitle => '设置';

  @override
  String get emotionAngry => '愤怒';

  @override
  String get emotionSad => '悲伤';

  @override
  String get emotionNeutral => '平静';

  @override
  String get emotionRelaxed => '放松';

  @override
  String get emotionHappy => '开心';

  @override
  String get colorBlindMode => '色觉辅助模式';

  @override
  String get colorBlindModeDesc => '使用图标和图案增强对比度';

  @override
  String get themeMode => '主题';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get palette => '配色方案';

  @override
  String get paletteDefault => '柔和 (默认)';

  @override
  String get paletteNature => '自然';

  @override
  String get paletteSunset => '日落';

  @override
  String get fontSize => '字体大小';

  @override
  String get fontSizeSmall => '小';

  @override
  String get fontSizeMedium => '中';

  @override
  String get fontSizeLarge => '大';

  @override
  String get save => '保存';

  @override
  String get successSaved => '保存成功';

  @override
  String get errorPastDate => '只能编辑今天的日记';

  @override
  String get errorGeneral => '发生意外错误';

  @override
  String get dailyEntryHint => '今天过得怎么样？';

  @override
  String get selectEmotion => '选择您现在的心情';

  @override
  String get sectionAppearance => '外观';

  @override
  String get sectionPrivacy => '隐私';

  @override
  String get sectionLanguage => '语言';

  @override
  String get sectionAccessibility => '无障碍';

  @override
  String get authTitle => '访问保护';

  @override
  String get authSubtitle => '打开应用时锁定日记';

  @override
  String get authSwitch => '需要指纹/PIN';

  @override
  String get languageSelector => '语言选择';

  @override
  String get notificationTitle => '每日提醒';

  @override
  String get notificationSubtitle => '需要提醒您填写日记吗？';

  @override
  String get notificationTime => '21:00 发送通知';

  @override
  String get accessibilityPatterns => '启用图案和图标';

  @override
  String get biometricReason => '通过身份验证保护您的私人空间';

  @override
  String get authFailed => '身份验证失败';

  @override
  String get notifPermissionDenied => '通知权限被拒绝';

  @override
  String get notificationTest => '发送测试通知';

  @override
  String get notificationTestSent => '测试通知已发送';

  @override
  String get textPreview => '文本预览';

  @override
  String get exportDate => '日期';

  @override
  String get exportEmotion => '记录的感情';

  @override
  String get exportReflection => '感悟';

  @override
  String get exportLabel => '导出 TXT';

  @override
  String get statsTitle => '本月摘要';

  @override
  String get statsHeader => '本月统计';

  @override
  String get statsNoData => '尚无数据。';

  @override
  String get closeMonthTitle => '结月并清除文本？';

  @override
  String get closeMonthContent => '心情图表将保留，但本月的所有个人书面细节将被永久删除。';

  @override
  String get closeMonthSuccess => '月结成功。文本已清除。';

  @override
  String get closeMonthLabel => '结月';

  @override
  String get historyTitle => '累计历史';

  @override
  String get historyNoData => '尚无历史摘要。';

  @override
  String historyTotalEvents(Object count) {
    return '累计记录事件：$count';
  }

  @override
  String get diaryReminderMessage => '别忘了填写你的日记';
}
