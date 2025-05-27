import 'package:flutter/services.dart';

void callCallbackDispatcher() {
  const MethodChannel backgroundChannel = MethodChannel('com.zastro/call_background');

  backgroundChannel.setMethodCallHandler((call) async {
    switch (call.method) {
      case 'onCallTimerTick':
        final seconds = call.arguments[0];
        print('Timer tick: $seconds seconds');
        break;
      case 'onCallEnded':
        print('Call ended');
        break;
      case 'onMicToggled':
        final isMuted = call.arguments[0];
        print('Mic muted: $isMuted');
        break;
    }
  });

  backgroundChannel.invokeMethod('BackgroundExecutor.initialized');
}
