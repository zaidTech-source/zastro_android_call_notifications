import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/services.dart';

class OngoingCallNotificationHandler {
  /*static void startOnGoingCallNotification(int seconds) async {
    if (Platform.isAndroid) {
      try {
        var intent = AndroidIntent(
          action: "com.example.zastro_android_call_notifications.START_CALL_NOTIFICATION",
          package: "com.example.zastro_android_call_notifications",
          arguments: <String, dynamic>{
            "call_duration_seconds": seconds,
          },
          flags: <int>[
            Flag.FLAG_INCLUDE_STOPPED_PACKAGES,
            Flag.FLAG_RECEIVER_FOREGROUND
          ],
        );
        await intent.sendBroadcast();
      } catch (e) {
        if (kDebugMode) {
          print("Error starting call notification: \$e");
        }
      }
    }
  }

  static void startMicNotification() async {
    if (Platform.isAndroid) {
      try {
        var intent = const AndroidIntent(
          action: "com.example.zastro_android_call_notifications.START_MICROPHONE_NOTIFICATION",
          package: "com.example.zastro_android_call_notifications",
          flags: <int>[
            Flag.FLAG_INCLUDE_STOPPED_PACKAGES,
            Flag.FLAG_RECEIVER_FOREGROUND
          ],
        );
        if (kDebugMode) {
          print("Sending STARTMICNOTIFICATION broadcast...");
        }
        await intent.sendBroadcast();
      } catch (e) {
        if (kDebugMode) {
          print("Error starting mic notification: \$e");
        }
      }
    }
  }

  static Future<void> updateCallDuration(int seconds) async {
    if (Platform.isAndroid) {
      await Future.delayed(const Duration(milliseconds: 300));
      try {
        var intent = AndroidIntent(
          action: "com.example.zastro_android_call_notifications.UPDATE_CALL_NOTIFICATION",
          package: "com.example.zastro_android_call_notifications",
          arguments: <String, dynamic>{
            "call_duration_seconds": seconds,
          },
          flags: <int>[
            Flag.FLAG_INCLUDE_STOPPED_PACKAGES,
            Flag.FLAG_RECEIVER_FOREGROUND
          ],
        );
        if (kDebugMode) {
          print("Sending UPDATECALLNOTIFICATION broadcast...");
        }
        await intent.sendBroadcast();
      } catch (e) {
        debugPrint("Error triggering call notification: \$e");
      }
    }
  }

  static void stopOngoingCallNotification() async {
    if (Platform.isAndroid) {
      try {
        var intent = const AndroidIntent(
          action: "com.example.zastro_android_call_notifications.STOP_CALL_NOTIFICATION",
          package: "com.example.zastro_android_call_notifications",
          flags: <int>[
            Flag.FLAG_INCLUDE_STOPPED_PACKAGES,
            Flag.FLAG_RECEIVER_FOREGROUND
          ],
        );
        if (kDebugMode) {
          print("Sending STOP_CALL_NOTIFICATION broadcast...");
        }
        await intent.sendBroadcast();
      } catch (e) {
        if (kDebugMode) {
          print("Error stopping call notification: \$e");
        }
      }
    }
  }

  static void stopMicNotification() async {
    if (Platform.isAndroid) {
      try {
        var intent = const AndroidIntent(
          action: "com.example.zastro_android_call_notifications.STOP_MIC_NOTIFICATION",
          package: "com.example.zastro_android_call_notifications",
          flags: <int>[
            Flag.FLAG_INCLUDE_STOPPED_PACKAGES,
            Flag.FLAG_RECEIVER_FOREGROUND
          ],
        );
        if (kDebugMode) {
          print("Sending STOP_MIC_NOTIFICATION broadcast...");
        }
        await intent.sendBroadcast();
      } catch (e) {
        if (kDebugMode) {
          print("Error stopping call notification: \$e");
        }
      }
    }
  }*/

  static const MethodChannel _ongoingCallChannel = MethodChannel('zastro_android_call_notifications');

  static Future<void> startOnGoingCallNotification(int seconds) async {
    try {
      await _ongoingCallChannel.invokeMethod('startOngoingCallNotification', {
        'call_duration_seconds': seconds,
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error starting call notification: $e");
      }
    }
  }

  static Future<void> startMicNotification() async {
    try {
      await _ongoingCallChannel.invokeMethod('startMicNotification');
    } catch (e) {
      if (kDebugMode) {
        print("Error starting mic notification: $e");
      }
    }
  }

  static Future<void> updateCallDuration(int seconds) async {
    try {
      await _ongoingCallChannel.invokeMethod('updateCallDuration', {
        'call_duration_seconds': seconds,
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error updating call duration: $e");
      }
    }
  }

  static Future<void> stopOngoingCallNotification() async {
    try {
      await _ongoingCallChannel.invokeMethod('stopOngoingCallNotification');
    } catch (e) {
      if (kDebugMode) {
        print("Error stopping call notification: $e");
      }
    }
  }

  static Future<void> stopMicNotification() async {
    try {
      await _ongoingCallChannel.invokeMethod('stopMicNotification');
    } catch (e) {
      if (kDebugMode) {
        print("Error stopping mic notification: $e");
      }
    }
  }

}
