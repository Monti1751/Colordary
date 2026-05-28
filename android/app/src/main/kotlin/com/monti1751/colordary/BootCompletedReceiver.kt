package com.monti1751.colordary

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

/**
 * BroadcastReceiver que se ejecuta al reiniciar el dispositivo.
 * Las alarmas de AlarmManager se pierden al apagar el dispositivo, así que
 * lanzamos la app en background para que main.dart las reprograme automáticamente.
 */
class BootCompletedReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == Intent.ACTION_BOOT_COMPLETED) {
            val prefs = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
            val isNotificationsEnabled = prefs.getBoolean("flutter.pref_notification_enabled", false)

            if (isNotificationsEnabled) {
                // Lanzar la app en background para que main.dart reprograme la alarma exacta
                val launchIntent = Intent(context, MainActivity::class.java).apply {
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    putExtra("reschedule_notification", true)
                }
                context.startActivity(launchIntent)
            }
        }
    }
}
