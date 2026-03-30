import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // Initialize Core Services required for Async Injections
  final prefs = await SharedPreferences.getInstance();
  await DatabaseHelper.instance.database;
  
  final notifService = NotificationService();
  await notifService.init();

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
