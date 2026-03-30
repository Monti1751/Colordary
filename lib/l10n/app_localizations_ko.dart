// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Colordary';

  @override
  String get homeTitle => '나의 한 달';

  @override
  String get settingsTitle => '설정';

  @override
  String get emotionAngry => '화남';

  @override
  String get emotionSad => '슬픔';

  @override
  String get emotionNeutral => '보통';

  @override
  String get emotionRelaxed => '편안함';

  @override
  String get emotionHappy => '행복';

  @override
  String get colorBlindMode => '색약 모드';

  @override
  String get colorBlindModeDesc => '대비 향상을 위한 아이콘 및 패턴 사용';

  @override
  String get themeMode => '테마';

  @override
  String get themeLight => '라이트';

  @override
  String get themeDark => '다크';

  @override
  String get themeSystem => '시스템 설정';

  @override
  String get palette => '색상 팔레트';

  @override
  String get paletteDefault => '파스텔 (기본)';

  @override
  String get paletteNature => '자연';

  @override
  String get paletteSunset => '노을';

  @override
  String get fontSize => '글자 크기';

  @override
  String get fontSizeSmall => '작게';

  @override
  String get fontSizeMedium => '중간';

  @override
  String get fontSizeLarge => '크게';

  @override
  String get save => '저장';

  @override
  String get successSaved => '성공적으로 저장되었습니다';

  @override
  String get errorPastDate => '오늘의 일기만 수정할 수 있습니다';

  @override
  String get errorGeneral => '예기치 않은 오류가 발생했습니다';

  @override
  String get dailyEntryHint => '오늘 하루는 어땠나요?';

  @override
  String get selectEmotion => '현재 기분을 선택하세요';

  @override
  String get sectionAppearance => '모양';

  @override
  String get sectionPrivacy => '개인 정보';

  @override
  String get sectionLanguage => '언어';

  @override
  String get sectionAccessibility => '접근성';

  @override
  String get authTitle => '액세스 보호';

  @override
  String get authSubtitle => '앱을 열 때 일기를 잠급니다';

  @override
  String get authSwitch => '지문/PIN 요구';

  @override
  String get languageSelector => '언어 선택';

  @override
  String get notificationTitle => '일일 알림';

  @override
  String get notificationSubtitle => '일기를 작성하도록 알려드릴까요?';

  @override
  String get notificationTime => '21:00에 알림';

  @override
  String get accessibilityPatterns => '패턴 및 아이콘 활성화';

  @override
  String get biometricReason => '본인 확인을 통해 일기를 보호합니다';

  @override
  String get authFailed => '인증에 실패했습니다';

  @override
  String get notifPermissionDenied => '알림 권한이 거부되었습니다';

  @override
  String get textPreview => '텍스트 미리보기';

  @override
  String get exportDate => '날짜';

  @override
  String get exportEmotion => '기록된 감정';

  @override
  String get exportReflection => '성찰';

  @override
  String get exportLabel => 'TXT로 내보내기';

  @override
  String get statsTitle => '월별 요약';

  @override
  String get statsHeader => '이번 달 통계';

  @override
  String get statsNoData => '아직 데이터가 없습니다.';

  @override
  String get closeMonthTitle => '월을 마감하고 텍스트를 삭제하시겠습니까?';

  @override
  String get closeMonthContent =>
      '기분 그래프는 유지되지만, 이번 달의 모든 개별 기록 사항은 영구히 삭제됩니다.';

  @override
  String get closeMonthSuccess => '월이 성공적으로 마감되었습니다. 텍스트가 삭제되었습니다.';

  @override
  String get closeMonthLabel => '월 마감';

  @override
  String get historyTitle => '누적 기록';

  @override
  String get historyNoData => '아직 과거 요약이 없습니다.';

  @override
  String historyTotalEvents(Object count) {
    return '총 등록된 이벤트 수: $count';
  }
}
