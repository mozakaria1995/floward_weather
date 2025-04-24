package com.example.floward_weather

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.HashMap
import android.util.Log
import android.os.Handler
import android.os.Looper

class MainActivity : FlutterActivity() {
    private val PROFILE_CHANNEL = "com.floward.weather/profile"
    private val FEEDBACK_CHANNEL = "com.floward.weather/feedback"
    private val TAG = "FlowardWeather"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, PROFILE_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getProfileData" -> {
                    try {
                        val profileData = HashMap<String, Any>().apply {
                            put("name", "Mohamed Zakaria")
                            put("email", "mo.zakaria95@gmail.com")
                            put("location", "Cairo , Egypt")
                            put("member_since", "January 2023")
                            put("os", "Android")
                            put("avatar_url", "https://randomuser.me/api/portraits/men/32.jpg")
                        }
                        
                        result.success(profileData)
                    } catch (e: Exception) {
                        result.error("PROFILE_ERROR", "Failed to get profile data", e.toString())
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, FEEDBACK_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "submitFeedback" -> {
                    try {
                        val arguments = call.arguments as? Map<String, Any>
                        val feedback = arguments?.get("feedback") as? String
                        
                        if (feedback.isNullOrEmpty()) {
                            result.error("INVALID_ARGUMENTS", "Missing feedback data", null)
                            return@setMethodCallHandler
                        }
                        
                        Log.d(TAG, "Received feedback from Flutter: $feedback")
                        
                        Handler(Looper.getMainLooper()).postDelayed({
                            result.success(true)
                        }, 1000)
                        
                    } catch (e: Exception) {
                        Log.e(TAG, "Error processing feedback: ${e.message}")
                        result.error("FEEDBACK_ERROR", "Failed to process feedback", e.toString())
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
