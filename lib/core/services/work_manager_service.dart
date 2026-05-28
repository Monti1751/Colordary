import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../database/database_helper.dart';
import '../../features/diary/data/repositories/diary_repository_impl.dart';
import 'notification_service.dart';
import 'notification_messages.dart';

/// Callback ejecutado por WorkManager en background
/// IMPORTANTE: Esta función debe ser top-level y estática
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    try {
      if (taskName == WorkManagerService.dailyNotificationTaskId) {
        // Reinicializar servicios en el contexto del background isolate
        final prefs = await SharedPreferences.getInstance();
        final dbHelper = DatabaseHelper.instance;
        await dbHelper.database;
        
        final diaryRepository = DiaryRepositoryImpl(dbHelper: dbHelper);
        final notificationService = NotificationService();
        await notificationService.init();

        // Obtener configuración
        final isNotificationEnabled = prefs.getBool('pref_notification_enabled') ?? false;
        final languageCode = prefs.getString('pref_language_code') ?? 'es';

        if (isNotificationEnabled) {
          // Verificar si el diario de HOY está vacío
          final today = DateTime.now();
          final entry = await diaryRepository.getEntryByDate(today);
          final isDiaryEmpty = entry == null;
          
          if (isDiaryEmpty) {
            // Enviar notificación DIRECTAMENTE (no usar zonedSchedule en background)
            final title = NotificationMessages.getDiaryReminderMessage(languageCode);
            const androidNotificationDetails = AndroidNotificationDetails(
              'daily_diary_reminder',
              'Recordatorio Diario',
              channelDescription: 'Notificación diaria a las 21:00 para rellenar tu diario',
              importance: Importance.max,
              priority: Priority.max,
              icon: '@mipmap/ic_launcher',
              playSound: true,
              enableVibration: true,
            );
            
            const notificationDetails = NotificationDetails(
              android: androidNotificationDetails,
            );
            
            // Mostrar la notificación inmediatamente
            await notificationService.show(
              id: 1001,
              title: title,
              body: '¿Cómo te sientes hoy?',
              notificationDetails: notificationDetails,
            );
          }
        }

        return true;
      }
      return false;
    } catch (e, stackTrace) {
      debugPrint('❌ Error en WorkManager callback: $e\n$stackTrace');
      return false;
    }
  });
}

/// Servicio para gestionar tareas en segundo plano con WorkManager
class WorkManagerService {
  static const String dailyNotificationTaskId = 'daily_diary_notification';

  /// Inicializar WorkManager con el callback dispatcher
  static Future<void> init() async {
    try {
      await Workmanager().initialize(
        callbackDispatcher,
        isInDebugMode: false,
      );
      debugPrint('✓ WorkManager inicializado correctamente');
    } catch (e) {
      debugPrint('❌ Error inicializando WorkManager: $e');
      rethrow;
    }
  }

  /// Programar tarea periódica diaria a las 21:00
  static Future<void> scheduleDailyNotification() async {
    try {
      // Cancelar cualquier tarea anterior
      await Workmanager().cancelByUniqueName(dailyNotificationTaskId);
      debugPrint('📋 Registrando tarea periódica con WorkManager...');

      // Calcular delay inicial hasta las 21:00 hoy (o mañana si ya pasó)
      final now = DateTime.now();
      final today21 = DateTime(now.year, now.month, now.day, 21, 0);
      final initialDelay = now.isBefore(today21) 
        ? today21.difference(now)
        : today21.add(const Duration(days: 1)).difference(now);

      debugPrint('⏰ Próxima ejecución en: ${initialDelay.inHours}h ${initialDelay.inMinutes % 60}m');

      // Registrar tarea periódica
      await Workmanager().registerPeriodicTask(
        dailyNotificationTaskId,
        dailyNotificationTaskId,
        frequency: const Duration(days: 1),
        initialDelay: initialDelay,
        constraints: Constraints(
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresDeviceIdle: false,
        ),
        backoffPolicy: BackoffPolicy.exponential,
        backoffPolicyDelay: const Duration(minutes: 15),
      );
      
      debugPrint('✓ Tarea programada: se ejecutará diariamente a las 21:00');
    } catch (e) {
      debugPrint('❌ Error al registrar WorkManager: $e');
      rethrow;
    }
  }

  /// Cancelar tarea de notificación
  static Future<void> cancelDailyNotification() async {
    try {
      await Workmanager().cancelByUniqueName(dailyNotificationTaskId);
      debugPrint('✓ Tarea cancelada exitosamente');
    } catch (e) {
      debugPrint('❌ Error al cancelar WorkManager: $e');
      rethrow;
    }
  }
}
