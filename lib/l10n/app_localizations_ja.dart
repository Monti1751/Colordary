// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Colordary';

  @override
  String get homeTitle => '今月の記録';

  @override
  String get settingsTitle => '設定';

  @override
  String get emotionAngry => '怒り';

  @override
  String get emotionSad => '悲しみ';

  @override
  String get emotionNeutral => '普通';

  @override
  String get emotionRelaxed => 'リラックス';

  @override
  String get emotionHappy => '幸せ';

  @override
  String get colorBlindMode => '色覚サポートモード';

  @override
  String get colorBlindModeDesc => 'コントラスト向上のためのアイコンとパターン';

  @override
  String get themeMode => 'テーマ';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeDark => 'ダーク';

  @override
  String get themeSystem => 'システム設定に従う';

  @override
  String get palette => 'カラーパレット';

  @override
  String get paletteDefault => 'パステル (デフォルト)';

  @override
  String get paletteNature => '自然';

  @override
  String get paletteSunset => '夕焼け';

  @override
  String get fontSize => '文字サイズ';

  @override
  String get fontSizeSmall => '小';

  @override
  String get fontSizeMedium => '中';

  @override
  String get fontSizeLarge => '大';

  @override
  String get save => '保存';

  @override
  String get successSaved => '正常に保存されました';

  @override
  String get errorPastDate => '編集できるのは今日の投稿のみです';

  @override
  String get errorGeneral => '予期しないエラーが発生しました';

  @override
  String get dailyEntryHint => '今日はどんな一日でしたか？';

  @override
  String get selectEmotion => '今の気分を選んでください';

  @override
  String get sectionAppearance => '外観';

  @override
  String get sectionPrivacy => 'プライバシー';

  @override
  String get sectionLanguage => '言語';

  @override
  String get sectionAccessibility => 'アクセシビリティ';

  @override
  String get authTitle => 'アクセス保護';

  @override
  String get authSubtitle => 'アプリ起動時に日記をロックする';

  @override
  String get authSwitch => '指紋認証/PINを要求';

  @override
  String get languageSelector => '言語選択';

  @override
  String get notificationTitle => '毎日のリマインダー';

  @override
  String get notificationSubtitle => '日記の記入を通知しますか？';

  @override
  String get notificationTime => '21:00に通知';

  @override
  String get accessibilityPatterns => 'パターンとアイコンを有効にする';

  @override
  String get biometricReason => '本人確認を行って日記を保護します';

  @override
  String get authFailed => '認証に失敗しました';

  @override
  String get notifPermissionDenied => '通知権限が拒否されました';

  @override
  String get notificationTest => 'テスト通知を送信';

  @override
  String get notificationTestSent => 'テスト通知が送信されました';

  @override
  String get textPreview => 'テキストのプレビュー';

  @override
  String get exportDate => '日付';

  @override
  String get exportEmotion => '記録された感情';

  @override
  String get exportReflection => '振り返り';

  @override
  String get exportLabel => 'TXT形式で書き出し';

  @override
  String get statsTitle => '月のまとめ';

  @override
  String get statsHeader => '今月の統計';

  @override
  String get statsNoData => 'まだデータがありません。';

  @override
  String get closeMonthTitle => '月を閉じてテキストを消去しますか？';

  @override
  String get closeMonthContent => '気分のグラフは保持されますが、今月の個別の記述内容はすべて完全に削除されます。';

  @override
  String get closeMonthSuccess => '月が正常に終了しました。テキストが消去されました。';

  @override
  String get closeMonthLabel => '月を閉じる';

  @override
  String get historyTitle => '積算履歴';

  @override
  String get historyNoData => '過去のサマリーはまだありません。';

  @override
  String historyTotalEvents(Object count) {
    return '登録された合計イベント数: $count';
  }

  @override
  String get diaryReminderMessage => '日記を書き忘れないでください';
}
