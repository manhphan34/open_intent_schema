package com.example.open_url_schema

import io.flutter.embedding.android.FlutterActivity
import android.content.ActivityNotFoundException
import android.content.Intent
import android.net.Uri
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.net.URLDecoder

class MainActivity: FlutterActivity() {

    companion object {
        private const val CHANNEL = "intent_scheme"
        private const val PACKAGE_SCHEME = "package="
    }
    // handle intent
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "openApplication" -> {
                    call.argument<String>("data")?.run {
                        openIntentScheme(this)
                        result.success(null)
                    }
                }

                else -> result.notImplemented()
            }
        }
    }

    // open app by intent
    private fun openIntentScheme(url: String) {
        try {
            val intent = Intent.parseUri(url, Intent.URI_INTENT_SCHEME)
            startActivity(intent)
        } catch (e: Exception) {
            // do something
        }
    }
}
