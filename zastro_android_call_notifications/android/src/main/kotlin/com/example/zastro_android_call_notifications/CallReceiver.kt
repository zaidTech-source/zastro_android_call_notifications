package com.example.zastro_android_call_notifications

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.widget.Toast
import android.os.Build
import org.json.JSONObject

class CallReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == "com.example.zastro_android_call_notifications.SHOW_CALL_NOTIFICATION") {
            val messageDataJsonString = intent.getStringExtra("message_data_in_string")
            val messageData: JSONObject? = messageDataJsonString?.let {
                try {
                    JSONObject(it)
                } catch (e: Exception) {
                    e.printStackTrace()
                    null
                }
            }

            val type = messageData?.optString("type", "")
            val uniqueId = messageData?.optString("uniqueId", "")
            val customerUniId = messageData?.optString("customerUniId", "")
            val notificationId = messageData?.optInt("notification_id", -1) ?: -1
            val callerName = messageData?.optString("customerName", "")
            val callerImage = messageData?.optString("customerImage", "")
            val serviceIntent = Intent(context, CallNotificationService::class.java).apply {
                putExtra("message_data_in_string", messageDataJsonString)
                putExtra("type", type)
                putExtra("uniqueId", uniqueId)
                putExtra("customerUniId", customerUniId)
                putExtra("notificationId", notificationId)
                putExtra("caller_name", callerName)
                putExtra("caller_image", callerImage)
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(serviceIntent)
            } else {
                context.startService(serviceIntent)
            }
        }
        else if (intent.action == "com.example.zastro_android_call_notifications.CANCEL_CALL_NOTIFICATION") {
            val notificationId = intent.getIntExtra("notificationId", -1)
            if (notificationId != -1) {
                val serviceIntent =
                    Intent(context, CallNotificationService::class.java).apply {
                        action = "ACTION_CANCEL_CALL_NOTIFICATION"
                        putExtra("notificationId", notificationId)
                    }
                context.stopService(serviceIntent)
            }
        }
    }
}
