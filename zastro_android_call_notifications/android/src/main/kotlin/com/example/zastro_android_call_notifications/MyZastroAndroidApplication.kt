package com.example.zastro_android_call_notifications

import android.app.Application
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartEntrypoint


class MyZastroAndroidApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        // Initialize and cache the FlutterEngine
        val flutterEngine = FlutterEngine(this)
        flutterEngine.dartExecutor.executeDartEntrypoint(
            FlutterEngine.DartEntrypoint.createDefault()
        )

        // Cache the FlutterEngine for later use
        FlutterEngineCache.getInstance().put("flutter_engine_cache_key", flutterEngine)
    }
}
