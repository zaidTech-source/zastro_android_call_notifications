import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class OngoingCallNotificationHandler {
  static const MethodChannel _channel = MethodChannel('your_channel_name');

  static Future<void> startOnGoingCallNotification(int seconds) async {
    if (_isInMainIsolate()) {
      try {
        await _channel.invokeMethod('startOnGoingCallNotification', {'seconds': seconds});
      } catch (e) {
        debugPrint('[OngoingCallNotificationHandler] Error: $e');
      }
    } else {
      debugPrint('[OngoingCallNotificationHandler] Skipped startOnGoingCallNotification (not in main isolate)');
    }
  }

  static Future<void> updateCallDuration(int seconds) async {
    if (_isInMainIsolate()) {
      try {
        await _channel.invokeMethod('updateCallDuration', {'seconds': seconds});
      } catch (e) {
        debugPrint('[OngoingCallNotificationHandler] Error: $e');
      }
    } else {
      debugPrint('[OngoingCallNotificationHandler] Skipped updateCallDuration (not in main isolate)');
    }
  }

  static Future<void> startMicNotification() async {
    if (_isInMainIsolate()) {
      try {
        await _channel.invokeMethod('startMicNotification');
      } catch (e) {
        debugPrint('[OngoingCallNotificationHandler] Error: $e');
      }
    } else {
      debugPrint('[OngoingCallNotificationHandler] Skipped startMicNotification (not in main isolate)');
    }
  }

  static Future<void> stopMicNotification() async {
    if (_isInMainIsolate()) {
      try {
        await _channel.invokeMethod('stopMicNotification');
      } catch (e) {
        debugPrint('[OngoingCallNotificationHandler] Error: $e');
      }
    } else {
      debugPrint('[OngoingCallNotificationHandler] Skipped stopMicNotification (not in main isolate)');
    }
  }

  static Future<void> stopOngoingCallNotification() async {
    if (_isInMainIsolate()) {
      try {
        await _channel.invokeMethod('stopOngoingCallNotification');
      } catch (e) {
        debugPrint('[OngoingCallNotificationHandler] Error: $e');
      }
    } else {
      debugPrint('[OngoingCallNotificationHandler] Skipped stopOngoingCallNotification (not in main isolate)');
    }
  }

  static bool _isInMainIsolate() {
    // Optional: For debugging, log the isolate hash
    // print('[Isolate Check] Hash: ${Isolate.current.hashCode}');
    return Isolate.current.debugName == null; // Main isolate has null debugName
  }
}



/*
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class OngoingCallNotificationHandler {


  static const MethodChannel _ongoingCallChannel = MethodChannel('Chat notifications');


  static Future<void> startOnGoingCallNotification(int seconds) async {
    print('[Isolate] startOnGoingCallNotification() Hash: ${Isolate.current.hashCode}');
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
    print('[Isolate] startMicNotification() Hash: ${Isolate.current.hashCode}');
    try {
      await _ongoingCallChannel.invokeMethod('startMicNotification');
    } catch (e) {
      if (kDebugMode) {
        print("Error starting mic notification: $e");
      }
    }
  }

  static Future<void> updateCallDuration(int seconds) async {
    print('[Isolate] updateCallTimer() Hash: ${Isolate.current.hashCode}');
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
    print('[Isolate] stopOngoingCallNotification() Hash: ${Isolate.current.hashCode}');
    try {
      await _ongoingCallChannel.invokeMethod('stopOngoingCallNotification');
    } catch (e) {
      if (kDebugMode) {
        print("Error stopping call notification: $e");
      }
    }
  }

  static Future<void> stopMicNotification() async {
    print('[Isolate] stopMicNotification() Hash: ${Isolate.current.hashCode}');
    try {
      await _ongoingCallChannel.invokeMethod('stopMicNotification');
    } catch (e) {
      if (kDebugMode) {
        print("Error stopping mic notification: $e");
      }
    }
  }

}
*/
