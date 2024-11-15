// MainActivity.kt
package com.example.vikas_habit_tracking

import android.os.Bundle
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall

class MainActivity: FlutterActivity() {
    // Define the channel name for communication
    private val CHANNEL = "com.example.habits/toast"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Set up the method channel to listen for method calls from Flutter
        MethodChannel(flutterEngine!!.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            // Handle the method call from Flutter
            if (call.method == "showToast") {
                val message = call.argument<String>("message")
                if (message != null) {
                    showToast(message)
                    result.success(null)  // Return success to Flutter
                } else {
                    result.error("INVALID_ARGUMENT", "Message is required", null)
                }
            } else {
                result.notImplemented()  // Handle unimplemented methods
            }
        }
    }

    // Function to show a Toast message on Android
    private fun showToast(message: String) {
        Toast.makeText(applicationContext, message, Toast.LENGTH_SHORT).show()
    }
}
