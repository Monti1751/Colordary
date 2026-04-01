import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:colordary/l10n/app_localizations.dart';

import 'core/constants/app_strings.dart';
import 'core/database/database_helper.dart';
import 'core/services/notification_service.dart';
import 'core/providers/dependency_providers.dart';
import 'features/settings/presentation/providers/settings_provider.dart';
import 'features/diary/presentation/screens/home_screen.dart';
import 'features/settings/presentation/providers/theme_generator.dart';
import 'features/settings/presentation/providers/settings_state.dart';
import 'features/auth/presentation/widgets/auth_wrapper.dart';
import 'features/diary/data/repositories/diary_repository_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // Initialize Core Services required for Async Injections
  final prefs = await SharedPreferences.getInstance();
  final dbHelper = DatabaseHelper.instance;
  await dbHelper.database;
  
  final notifService = NotificationService();
  await notifService.init();

  // Crear un callback para verificar si el diario está vacío
  // Este callback será usado por la notificación para enviarla solo si el día está vacío
  final diaryRepository = DiaryRepositoryImpl(dbHelper: dbHelper);
  notifService.setDiaryEmptyChecker(() async {
    final today = DateTime.now();
    final entry = await diaryRepository.getEntryByDate(today);
    return entry == null; // Retorna true si está vacío (no hay entrada)
  });

  // Solicitar permisos de notificación
  await notifService.requestPermissions();

  // Programar la notificación diaria a las 21:00
  // Se obtendrá el idioma desde SharedPreferences si está disponible
  final languageCode = prefs.getString('pref_language_code');
  try {
    await notifService.scheduleDailyReminderIfEmpty(
      languageCode: languageCode ?? 'es',
    );
  } catch (e) {
    debugPrint('Error programando notificación diaria: $e');
  }

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        notificationServiceProvider.overrideWithValue(notifService),
      ],
      child: const CozyDiaryApp(),
    ),
  );
}

class CozyDiaryApp extends ConsumerWidget {
  const CozyDiaryApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsNotifierProvider);
    final settingsNotifier = ref.read(settingsNotifierProvider.notifier);

    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      
      theme: AppThemeGenerator.generateTheme(settingsState, isDark: false),
      darkTheme: AppThemeGenerator.generateTheme(settingsState, isDark: true),
      themeMode: settingsState.themeMode,
      locale: settingsState.locale,
      
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(settingsState.fontSizeMultiplier),
          ),
          child: child!,
        );
      },
      
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      
      home: const AuthWrapper(child: HomeScreen()),
    );
  }
}
