import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/foundation.dart';

class ChatNotificationPlugin {
  static const MethodChannel _channel = MethodChannel('Chat notifications');

  static Future<void> showCallNotification(Map<String, dynamic> data) async {
    try {
      await _channel.invokeMethod('showCallNotification', data);
    } on PlatformException catch (e) {
      print("Error invoking showCallNotification: ${e.message}");
    }
  }

  static Future<void> cancelCallNotification(int notificationId) async {
    try {
      await _channel.invokeMethod('cancelCallNotification', {"notificationId": notificationId});
    } on PlatformException catch (e) {
      print("Error invoking cancelCallNotification: ${e.message}");
    }
  }

  static Future<void> initialize() async {
    await _channel.invokeMethod('initialize');
  }

  Future<void> triggerIncomingCallNotificationFromPlugin(String messageDataJson) async {
    try {
      final Map<String, dynamic> data = jsonDecode(messageDataJson);
      final String type = data['type'] ?? "alert";

      if (type == "chat") {
        final intent = AndroidIntent(
          action: "com.example.zastro_android_call_notifications.SHOW_CALL_NOTIFICATION",
          package: "com.example.zastro_android_call_notifications",
          arguments: {
            "message_data_in_string": messageDataJson,
          },
          flags: const <int>[
            Flag.FLAG_INCLUDE_STOPPED_PACKAGES,
            Flag.FLAG_RECEIVER_FOREGROUND,
          ],
        );
        await intent.sendBroadcast();
      } else if (type == "cancel") {
        final int notificationId =
            int.tryParse(data['notification_id'] ?? "-1") ?? -1;

        final intent = AndroidIntent(
          action: "com.example.zastro_android_call_notifications.CANCEL_CALL_NOTIFICATION",
          package: "com.example.zastro_android_call_notifications",
          arguments: {
            "notificationId": notificationId,
          },
          flags: const <int>[
            Flag.FLAG_INCLUDE_STOPPED_PACKAGES,
            Flag.FLAG_RECEIVER_FOREGROUND,
          ],
        );
        await intent.sendBroadcast();
      }
    } catch (e) {
      debugPrint("Plugin trigger error: $e");
    }
  }
}
