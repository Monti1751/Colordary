package com.monti1751.colordary

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import androidx.work.OneTimeWorkRequestBuilder
import androidx.work.WorkManager
import androidx.work.Data
import java.util.concurrent.TimeUnit

/**
 * BroadcastReceiver to reschedule notifications after device boot
 * This ensures that scheduled notifications are restored after the device restarts
 */
class BootCompletedReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == Intent.ACTION_BOOT_COMPLETED) {
            // Reschedule the daily notification if it was enabled
            val prefs = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
            val isNotificationsEnabled = prefs.getBoolean("flutter.pref_notification_enabled", false)
            
            if (isNotificationsEnabled) {
                // Schedule a one-time work request to reschedule the notification
                val reschedulerWorkRequest = OneTimeWorkRequestBuilder<NotificationReschedulerWorker>()
                    .setInitialDelay(5, TimeUnit.SECONDS) // Give the app a moment to initialize
                    .build()
                
                WorkManager.getInstance(context).enqueueUniqueWork(
                    "notify_rescheduler",
                    androidx.work.ExistingWorkPolicy.KEEP,
                    reschedulerWorkRequest
                )
            }
        }
    }
}
