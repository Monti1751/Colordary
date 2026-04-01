/// Helper class to manage notification messages across different languages
/// without requiring BuildContext
class NotificationMessages {
  static const _diaryReminderMessages = {
    'es': 'No olvides rellenar tu diario',
    'en': 'Don\'t forget to fill your diary',
    'ca': 'No oblidis omplir el teu diari',
    'de': 'Vergessen Sie nicht, Ihr Tagebuch zu führen',
    'fr': 'N\'oublie pas de remplir ton journal',
    'it': 'Non dimenticare di compilare il tuo diario',
    'pt': 'Não esqueça de preencher seu diário',
    'ru': 'Не забудьте заполнить дневник',
    'ja': '日記を書き忘れないでください',
    'ko': '일기 쓰는 것을 잊지 마세요',
    'zh': '别忘了填写你的日记',
  };

  /// Get the diary reminder message for the given language code
  /// Falls back to English if language not found
  static String getDiaryReminderMessage(String? languageCode) {
    if (languageCode == null || languageCode.isEmpty) {
      return _diaryReminderMessages['en'] ?? 'Don\'t forget to fill your diary';
    }
    
    // Try exact match first
    if (_diaryReminderMessages.containsKey(languageCode)) {
      return _diaryReminderMessages[languageCode] ?? _diaryReminderMessages['en']!;
    }
    
    // Try first part of language code (e.g., 'es' from 'es_ES')
    final shortCode = languageCode.split('_').first;
    if (_diaryReminderMessages.containsKey(shortCode)) {
      return _diaryReminderMessages[shortCode] ?? _diaryReminderMessages['en']!;
    }
    
    // Fall back to English
    return _diaryReminderMessages['en'] ?? 'Don\'t forget to fill your diary';
  }
}
