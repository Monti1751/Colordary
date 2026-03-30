import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/database_helper.dart';
import '../services/notification_service.dart';
import '../services/local_auth_service.dart';

import '../../features/diary/data/repositories/diary_repository_impl.dart';
import '../../features/diary/domain/repositories/diary_repository.dart';
import '../../features/diary/domain/usecases/get_monthly_entries_usecase.dart';
import '../../features/diary/domain/usecases/save_daily_entry_usecase.dart';
import '../../features/diary/presentation/providers/diary_provider.dart';
import '../../features/diary/presentation/providers/diary_state.dart';

import '../../features/summary/data/repositories/summary_repository_impl.dart';
import '../../features/summary/domain/repositories/summary_repository.dart';
import '../../features/summary/domain/usecases/close_month_and_generate_summary_usecase.dart';
import '../../features/summary/domain/usecases/get_monthly_statistics_usecase.dart';
import '../../features/summary/domain/usecases/export_month_data_usecase.dart';
import '../../features/summary/presentation/providers/summary_provider.dart';
import '../../features/summary/presentation/providers/summary_state.dart';

import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/domain/usecases/update_app_settings_usecase.dart';
import '../../features/settings/presentation/providers/settings_provider.dart';
import '../../features/settings/presentation/providers/settings_state.dart';

// --- 1. Core / Infraestructura ---
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) => throw UnimplementedError('Debe inicializarse en main()'));
final notificationServiceProvider = Provider<NotificationService>((ref) => throw UnimplementedError('Debe inicializarse en main()'));
final localAuthServiceProvider = Provider<LocalAuthService>((ref) => LocalAuthService());

final databaseHelperProvider = Provider<DatabaseHelper>((ref) => DatabaseHelper.instance);

// --- 2. Repositorios ---
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl(prefs: ref.watch(sharedPreferencesProvider));
});

final diaryRepositoryProvider = Provider<DiaryRepository>((ref) {
  return DiaryRepositoryImpl(dbHelper: ref.watch(databaseHelperProvider));
});

final summaryRepositoryProvider = Provider<SummaryRepository>((ref) {
  return SummaryRepositoryImpl(dbHelper: ref.watch(databaseHelperProvider));
});

// --- 3. Casos de Uso (Domain) ---
final updateAppSettingsUseCaseProvider = Provider<UpdateAppSettingsUseCase>((ref) {
  return UpdateAppSettingsUseCase(ref.watch(settingsRepositoryProvider));
});

final getMonthlyEntriesUseCaseProvider = Provider<GetMonthlyEntriesUseCase>((ref) {
  return GetMonthlyEntriesUseCase(ref.watch(diaryRepositoryProvider));
});

final saveDailyEntryUseCaseProvider = Provider<SaveDailyEntryUseCase>((ref) {
  return SaveDailyEntryUseCase(ref.watch(diaryRepositoryProvider));
});

final closeMonthUseCaseProvider = Provider<CloseMonthAndGenerateSummaryUseCase>((ref) {
  return CloseMonthAndGenerateSummaryUseCase(ref.watch(summaryRepositoryProvider));
});

final getMonthlyStatsUseCaseProvider = Provider<GetMonthlyStatisticsUseCase>((ref) {
  return GetMonthlyStatisticsUseCase(ref.watch(summaryRepositoryProvider));
});

final exportMonthDataUseCaseProvider = Provider<ExportMonthDataUseCase>((ref) {
  return ExportMonthDataUseCase(ref.watch(diaryRepositoryProvider));
});

// --- 4. State Management (Riverpod Notifiers) ---
final settingsNotifierProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  final useCase = ref.watch(updateAppSettingsUseCaseProvider);
  final repository = ref.watch(settingsRepositoryProvider) as SettingsRepositoryImpl;
  final notifications = ref.watch(notificationServiceProvider);
  final localAuth = ref.watch(localAuthServiceProvider);
  return SettingsNotifier(useCase, repository, notifications, localAuth);
});

final diaryNotifierProvider = StateNotifierProvider<DiaryNotifier, DiaryState>((ref) {
  final getUseCase = ref.watch(getMonthlyEntriesUseCaseProvider);
  final saveUseCase = ref.watch(saveDailyEntryUseCaseProvider);
  final notifications = ref.watch(notificationServiceProvider);
  return DiaryNotifier(
    getMonthlyEntriesUseCase: getUseCase,
    saveDailyEntryUseCase: saveUseCase,
    notificationService: notifications,
  );
});

final summaryNotifierProvider = StateNotifierProvider<SummaryNotifier, SummaryState>((ref) {
  final getStatsUseCase = ref.watch(getMonthlyStatsUseCaseProvider);
  final closeMonthUseCase = ref.watch(closeMonthUseCaseProvider);
  return SummaryNotifier(
    getStatsUseCase: getStatsUseCase,
    closeMonthUseCase: closeMonthUseCase,
  );
});
