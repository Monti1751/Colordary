import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'notification_messages.dart';

typedef IsDiaryEmptyCallback = Future<bool> Function();

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  static const int dailyReminderId = 1001;
  static const String channelId = 'daily_diary_reminder';
  static const String channelName = 'Recordatorio Diario';
  static const String channelDescription = 'Notificación diaria a las 21:00 para rellenar tu diario';

  IsDiaryEmptyCallback? _isDiaryEmptyCallback;

  Future<void> init() async {
    tz.initializeTimeZones();
    try {
      final String timeZoneName = (await FlutterTimezone.getLocalTimezone()).toString();
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    } catch (_) {
      // Fallback to UTC if timezone detection fails
    }
    
    // Create the notification channel BEFORE initializing (required for Android 8+)
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      channelId,
      channelName,
      description: channelDescription,
      importance: Importance.max,
    );
    
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    
    const AndroidInitializationSettings initAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings = InitializationSettings(android: initAndroid);
    await _notificationsPlugin.initialize(settings: initSettings);
  }

  /// Registra el callback para verificar si el diario está vacío
  /// Este debe ser llamado después de inicializar el NotificationService
  /// idealmente con una función que acceda al DiaryRepository
  void setDiaryEmptyChecker(IsDiaryEmptyCallback callback) {
    _isDiaryEmptyCallback = callback;
  }

  Future<bool> requestPermissions() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        _notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    
    // Request notification permission
    final bool? granted = await androidImplementation?.requestNotificationsPermission();
    // Also request exact alarms permission for precise scheduling
    final bool? exactAlarm = await androidImplementation?.requestExactAlarmsPermission();
    
    return (granted ?? false) && (exactAlarm ?? true); // exactAlarm can be null on older Android
  }

  Future<void> scheduleDailyReminder({
    required String title,
    required String body,
    bool forceTomorrow = false,
  }) async {
    try {
      await cancelDailyReminder();
      
      final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
      tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        21,
        0,
      );
      
      // If the time has already passed today or forceTomorrow is true, schedule for tomorrow
      if (scheduledDate.isBefore(now) || forceTomorrow) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.max,
        icon: '@mipmap/ic_launcher',
        playSound: true,
        enableVibration: true,
      );

      const NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails,
      );

      // Try exact alarm first (for Android 12+)
      try {
        await _notificationsPlugin.zonedSchedule(
          id: dailyReminderId,
          title: title,
          body: body,
          scheduledDate: scheduledDate,
          notificationDetails: notificationDetails,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.time, // Repeats daily at this time
        );
      } catch (e) {
        // Fallback to inexact if exact fails
        await _notificationsPlugin.zonedSchedule(
          id: dailyReminderId,
          title: title,
          body: body,
          scheduledDate: scheduledDate,
          notificationDetails: notificationDetails,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.time,
        );
      }
    } catch (e) {
      // Log error for debugging
      debugPrint('Error scheduling daily reminder: $e');
      rethrow;
    }
  }

  /// Programa una notificación diaria a las 21:00 que solo se envía si el diario está vacío
  /// Requiere que setDiaryEmptyChecker haya sido llamado anteriormente
  Future<void> scheduleDailyReminderIfEmpty({
    String? languageCode,
    bool forceTomorrow = false,
  }) async {
    try {
      // Verificar si el callback está configurado
      if (_isDiaryEmptyCallback == null) {
        debugPrint('Warning: setDiaryEmptyChecker no ha sido configurado. Notificación no será enviada.');
        return;
      }

      // Verificar si el diario está vacío
      final isDiaryEmpty = await _isDiaryEmptyCallback!();
      
      if (!isDiaryEmpty) {
        // El diario ya tiene entrada, cancelar la notificación
        await cancelDailyReminder();
        return;
      }

      // El diario está vacío, programar la notificación
      final title = NotificationMessages.getDiaryReminderMessage(languageCode);
      final body = '¿Cómo te sientes hoy?';
      
      await scheduleDailyReminder(
        title: title,
        body: body,
        forceTomorrow: forceTomorrow,
      );
    } catch (e) {
      debugPrint('Error scheduling daily reminder if empty: $e');
      rethrow;
    }
  }

  Future<void> cancelDailyReminder() async {
    try {
      await _notificationsPlugin.cancel(id: dailyReminderId);
    } catch (e) {
      debugPrint('Error canceling daily reminder: $e');
    }
  }

  /// Envía una notificación de prueba inmediata para verificar que el sistema funciona
  Future<void> sendTestNotification({String? languageCode}) async {
    try {
      final title = NotificationMessages.getDiaryReminderMessage(languageCode);
      const body = '¿Cómo te sientes hoy?';

      const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.max,
        icon: '@mipmap/ic_launcher',
        playSound: true,
        enableVibration: true,
      );

      const NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails,
      );

      await _notificationsPlugin.show(
        id: 9999, // ID único para notificación de prueba
        title: title,
        body: body,
        notificationDetails: notificationDetails,
      );
      
      debugPrint('Notificación de prueba enviada');
    } catch (e) {
      debugPrint('Error sending test notification: $e');
      rethrow;
    }
  }
}
