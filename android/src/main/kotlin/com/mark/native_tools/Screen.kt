package com.mark.native_tools

import android.os.PowerManager
import android.view.WindowManager
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import java.lang.Exception

class Screen : MethodChannel.MethodCallHandler, ActivityAware {

    lateinit var _binding: ActivityPluginBinding

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "keepOn" -> controlScreenOn(call, result)
            else -> result.notImplemented()
        }
    }

    //------  MAIN FUNCTION  ------=
    /// prevent screen going into sleep
    private fun controlScreenOn(call: MethodCall, result: MethodChannel.Result) {
        val param = call.arguments as Map<*, *>
        val toOn = param["on"]
        val window = _binding.activity.window
        try {
            when (toOn) {
                true -> window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
                false -> window.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
            }
            result.success(ResponseResult(isOkey = true, message = "").toMap())
        } catch (e: Exception) {
            result.success(ResponseResult(isOkey = false, message = e.toString()).toMap())
        }
    }


    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        _binding = binding
    }

    override fun onDetachedFromActivity() {}

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        _binding = binding
    }


}