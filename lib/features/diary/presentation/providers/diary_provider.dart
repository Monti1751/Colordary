import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';
import '../../../../core/enums/emotion.dart';
import '../../../../core/services/notification_service.dart';
import '../../domain/usecases/get_monthly_entries_usecase.dart';
import '../../domain/usecases/save_daily_entry_usecase.dart';
import '../../domain/entities/daily_entry.dart';
import 'diary_state.dart';

class DiaryNotifier extends StateNotifier<DiaryState> {
  final GetMonthlyEntriesUseCase _getMonthlyEntriesUseCase;
  final SaveDailyEntryUseCase _saveDailyEntryUseCase;
  final NotificationService _notificationService;

  DiaryNotifier({
    required GetMonthlyEntriesUseCase getMonthlyEntriesUseCase,
    required SaveDailyEntryUseCase saveDailyEntryUseCase,
    required NotificationService notificationService,
  })  : _getMonthlyEntriesUseCase = getMonthlyEntriesUseCase,
        _saveDailyEntryUseCase = saveDailyEntryUseCase,
        _notificationService = notificationService,
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

    result.fold(
      (failure) => state = state.copyWith(status: DiaryStatus.error, errorMessage: failure.message),
      (_) {
        loadMonth(date.year, date.month);
        
        final now = DateTime.now();
        if (date.year == now.year && date.month == now.month && date.day == now.day) {
          // El usuario ha rellenado su diario HOY.
          // En lugar de enviarle un aviso de "Rellena tu diario a las 21:00h" hoy,
          // posponemos su próximo recordatorio para MAÑANA y lo mantenemos activo repitiendose.
          _notificationService.scheduleDailyReminder(
             title: "Tu Refugio Diario", 
             body: "¿Cómo te has sentido hoy?",
             forceTomorrow: true,
          );
        }
      },
    );
  }

  void clearError() => state = state.copyWith(clearError: true, status: DiaryStatus.success);
}
