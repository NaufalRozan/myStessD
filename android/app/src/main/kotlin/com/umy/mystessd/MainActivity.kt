package com.umy.mystessd

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.umy.mystessd/assetpack"
    private lateinit var assetPackHelper: AssetPackHelper

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        assetPackHelper = AssetPackHelper(this)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getModelPath" -> {
                    val modelName = call.argument<String>("modelName")
                    if (modelName != null) {
                        val path = assetPackHelper.getModelPath(modelName)
                        if (path != null) {
                            result.success(path)
                        } else {
                            result.error("NOT_FOUND", "Model path tidak ditemukan", null)
                        }
                    } else {
                        result.error("INVALID_ARGUMENT", "Model name harus diberikan", null)
                    }
                }
                "isAssetPackReady" -> {
                    result.success(assetPackHelper.isAssetPackReady())
                }
                "getAllModelPaths" -> {
                    result.success(assetPackHelper.getAllModelPaths())
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}

