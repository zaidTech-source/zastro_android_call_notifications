package com.example.zastro_android_call_notifications

import android.content.Context
import android.util.Log
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartCallback
import io.flutter.plugin.common.JSONMethodCodec
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.view.FlutterCallbackInformation
import java.util.concurrent.atomic.AtomicBoolean

class CallBackgroundExecutor : MethodChannel.MethodCallHandler {

    companion object {
        private const val TAG = "CallBackgroundExecutor"
        private const val PREFS_KEY = "call_plugin_prefs"
        private const val CALLBACK_KEY = "callback_handle"

        private var instance: CallBackgroundExecutor? = null

        fun getInstance(): CallBackgroundExecutor {
            if (instance == null) instance = CallBackgroundExecutor()
            return instance!!
        }

        fun setCallbackDispatcher(context: Context, handle: Long) {
            context.getSharedPreferences(PREFS_KEY, Context.MODE_PRIVATE)
                .edit().putLong(CALLBACK_KEY, handle).apply()
        }
    }

    private var engine: FlutterEngine? = null
    private var channel: MethodChannel? = null
    private val isInitialized = AtomicBoolean(false)

    fun startIsolate(context: Context) {
        if (isInitialized.get()) return

        val prefs = context.getSharedPreferences(PREFS_KEY, Context.MODE_PRIVATE)
        val handle = prefs.getLong(CALLBACK_KEY, 0L)

        val callbackInfo = FlutterCallbackInformation.lookupCallbackInformation(handle)
        if (callbackInfo == null) {
            Log.e(TAG, "Invalid Dart callback handle.")
            return
        }

        val bundlePath = FlutterInjector.instance().flutterLoader().findAppBundlePath()
        val dartCallback = DartCallback(context.assets, bundlePath, callbackInfo)

        engine = FlutterEngine(context).apply {
            channel = MethodChannel(
                dartExecutor.binaryMessenger,
                "com.zastro/call_background",
                JSONMethodCodec.INSTANCE
            )
            channel!!.setMethodCallHandler(this@CallBackgroundExecutor)
            dartExecutor.executeDartCallback(dartCallback)
        }
    }

    fun sendCallTick(duration: Int) {
        channel?.invokeMethod("onCallTimerTick", listOf(duration))
    }

    fun sendCallEnded() {
        channel?.invokeMethod("onCallEnded", null)
    }

    fun sendMuteToggled(isMuted: Boolean) {
        channel?.invokeMethod("onMicToggled", listOf(isMuted))
    }

    fun setCallbackDispatcher(context: Context, handle: Long) {
        val prefs = context.getSharedPreferences("call_callback_prefs", Context.MODE_PRIVATE)
        prefs.edit().putLong("callback_dispatcher_handle", handle).apply()
    }
    fun getCallbackDispatcher(context: Context): Long {
        val prefs = context.getSharedPreferences("call_callback_prefs", Context.MODE_PRIVATE)
        return prefs.getLong("callback_dispatcher_handle", 0L)
    }


    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "BackgroundExecutor.initialized") {
            isInitialized.set(true)
            result.success(true)
        } else {
            result.notImplemented()
        }
    }
}
