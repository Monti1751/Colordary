import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:state_notifier/state_notifier.dart';
import '../../../../core/enums/emotion.dart';
import '../../../../core/services/notification_service.dart';
import '../../../../core/services/notification_messages.dart';
import '../../../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../domain/usecases/get_monthly_entries_usecase.dart';
import '../../domain/usecases/save_daily_entry_usecase.dart';
import '../../domain/entities/daily_entry.dart';
import 'diary_state.dart';

class DiaryNotifier extends StateNotifier<DiaryState> {
  final GetMonthlyEntriesUseCase _getMonthlyEntriesUseCase;
  final SaveDailyEntryUseCase _saveDailyEntryUseCase;
  final NotificationService _notificationService;
  final SettingsRepositoryImpl _settingsRepository;

  DiaryNotifier({
    required GetMonthlyEntriesUseCase getMonthlyEntriesUseCase,
    required SaveDailyEntryUseCase saveDailyEntryUseCase,
    required NotificationService notificationService,
    required SettingsRepositoryImpl settingsRepository,
  })  : _getMonthlyEntriesUseCase = getMonthlyEntriesUseCase,
        _saveDailyEntryUseCase = saveDailyEntryUseCase,
        _notificationService = notificationService,
        _settingsRepository = settingsRepository,
        super(const DiaryState()) {
    final now = DateTime.now();
    loadMonth(now.year, now.month);
  }

  Future<void> loadMonth(int year, int month) async {
    state = state.copyWith(status: DiaryStatus.loading, clearError: true);
    final result = await _getMonthlyEntriesUseCase(year, month);
    result.fold(
      (failure) => state = state.copyWith(status: DiaryStatus.error, errorMessage: failure.message),
      (entries) => state = state.copyWith(status: DiaryStatus.success, monthlyEntries: entries),
    );
  }

  Future<void> saveEntry(DateTime date, Emotion emotion, String text, {int? id}) async {
    state = state.copyWith(status: DiaryStatus.loading, clearError: true);
    final entry = DailyEntry(id: id, date: date, content: text, emotion: emotion);
    final result = await _saveDailyEntryUseCase(entry);

    bool savedToday = false;

    result.fold(
      (failure) => state = state.copyWith(status: DiaryStatus.error, errorMessage: failure.message),
      (_) {
        loadMonth(date.year, date.month);
        final now = DateTime.now();
        if (date.year == now.year && date.month == now.month && date.day == now.day) {
          savedToday = true;
        }
      },
    );

    // Reprogramar notificación fuera del fold (requiere await)
    if (savedToday && _settingsRepository.getNotificationsEnabled()) {
      try {
        final langCode = _settingsRepository.getLanguageCode() ?? 'es';
        final title = NotificationMessages.getDiaryReminderMessage(langCode);
        await _notificationService.scheduleDailyReminder(
          title: title,
          body: '¿Cómo te sientes hoy?',
          forceTomorrow: true,
        );
        debugPrint('✓ Recordatorio reprogramado para mañana (diario rellenado hoy)');
      } catch (e) {
        debugPrint('✗ Error reprogramando notificación: $e');
      }
    }
  }

  void clearError() => state = state.copyWith(clearError: true, status: DiaryStatus.success);
}
