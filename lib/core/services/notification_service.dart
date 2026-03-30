import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:flutter/material.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  static const int dailyReminderId = 1001;

  Future<void> init() async {
    tz.initializeTimeZones();
    try {
      final String timeZoneName = (await FlutterTimezone.getLocalTimezone()).toString();
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    } catch (_) {
      // Fallback to UTC if timezone detection fails
    }
    
    const AndroidInitializationSettings initAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings = InitializationSettings(android: initAndroid);
    await _notificationsPlugin.initialize(settings: initSettings);
  }

  Future<bool> requestPermissions() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        _notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    
    // Request standard notification permission
    final bool? granted = await androidImplementation?.requestNotificationsPermission();
    return granted ?? false;
  }

  Future<void> scheduleDailyReminder({required String title, required String body, bool forceTomorrow = false}) async {
    await cancelDailyReminder();
    
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 21, 0);
    
    if (scheduledDate.isBefore(now) || forceTomorrow) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    const AndroidNotificationDetails androidSpecs = AndroidNotificationDetails(
      'daily_diary_reminder',
      'Recordatorio Diario',
      channelDescription: 'Aviso de las 21:00h para rellenar tu diario acogedor.',
      importance: Importance.max,
      priority: Priority.max,
      icon: '@mipmap/ic_launcher',
    );

    // Dynamic scheduling mode: Use exact only if permission is granted, otherwise fallback to inexact
    AndroidScheduleMode scheduleMode = AndroidScheduleMode.exactAllowWhileIdle;
    
    try {
      await _notificationsPlugin.zonedSchedule(
        id: dailyReminderId,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
        notificationDetails: const NotificationDetails(android: androidSpecs),
        androidScheduleMode: scheduleMode,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (e) {
      // If exact fails (e.g. missing permission on Android 12+), fallback to inexact to prevent crash/hang
      await _notificationsPlugin.zonedSchedule(
        id: dailyReminderId,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
        notificationDetails: const NotificationDetails(android: androidSpecs),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  Future<void> cancelDailyReminder() async {
    await _notificationsPlugin.cancel(id: dailyReminderId);
  }
}
