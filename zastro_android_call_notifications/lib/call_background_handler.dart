import 'package:flutter/services.dart';

void callCallbackDispatcher() {
  const MethodChannel _backgroundChannel = MethodChannel('Chat notifications');

  // Optional: Set a method call handler if you expect background calls from Kotlin
  _backgroundChannel.setMethodCallHandler((call) async {
    if (call.method == "callTick") {
      final int seconds = call.arguments;
      print("Tick in background isolate: $seconds seconds");
    } else if (call.method == "muteToggled") {
      final bool isMuted = call.arguments;
      print("Mic is now ${isMuted ? "muted" : "unmuted"}");
    }
  });
}