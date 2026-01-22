package com.umy.mystessd

import android.content.Context
import com.google.android.play.core.assetpacks.*
import com.google.android.play.core.assetpacks.model.AssetPackStatus
import com.google.android.play.core.assetpacks.model.AssetPackStorageMethod
import io.flutter.plugin.common.MethodChannel
import java.io.File

class AssetPackHelper(private val context: Context) {
    private val assetPackManager: AssetPackManager = AssetPackManagerFactory.getInstance(context)
    private val ASSET_PACK_NAME = "ai_models"

    /**
     * Mendapatkan path absolut ke file model dari asset pack
     */
    fun getModelPath(modelName: String): String? {
        val assetPackPath = assetPackManager.getPackLocation(ASSET_PACK_NAME)
        
        return if (assetPackPath != null) {
            val assetsPath = assetPackPath.assetsPath()
            "$assetsPath/$modelName"
        } else {
            null
        }
    }

    /**
     * Cek apakah asset pack sudah terinstall
     */
    fun isAssetPackReady(): Boolean {
        val location = assetPackManager.getPackLocation(ASSET_PACK_NAME)
        return location != null && location.packStorageMethod() == AssetPackStorageMethod.STORAGE_FILES
    }

    /**
     * Download asset pack (jika menggunakan on-demand delivery)
     * Untuk install-time, ini tidak diperlukan karena sudah otomatis terinstall
     */
    fun fetchAssetPack(callback: (Boolean, String?) -> Unit) {
        if (isAssetPackReady()) {
            callback(true, "Asset pack sudah tersedia")
            return
        }

        val request = assetPackManager.fetch(listOf(ASSET_PACK_NAME))
        
        val listener = object : AssetPackStateUpdateListener {
            override fun onStateUpdate(state: AssetPackState) {
                when (state.status()) {
                    AssetPackStatus.COMPLETED -> {
                        assetPackManager.unregisterListener(this)
                        callback(true, "Asset pack berhasil didownload")
                    }
                    AssetPackStatus.FAILED -> {
                        assetPackManager.unregisterListener(this)
                        callback(false, "Gagal mendownload asset pack: ${state.errorCode()}")
                    }
                    AssetPackStatus.CANCELED -> {
                        assetPackManager.unregisterListener(this)
                        callback(false, "Download asset pack dibatalkan")
                    }
                    else -> {
                        // PENDING, DOWNLOADING, TRANSFERRING, etc.
                        // Bisa ditambahkan progress listener jika diperlukan
                    }
                }
            }
        }
        
        assetPackManager.registerListener(listener)
    }

    /**
     * Mendapatkan semua path model yang tersedia
     */
    fun getAllModelPaths(): Map<String, String?> {
        return mapOf(
            "modelDNmod" to getModelPath("modelDNmod.tflite"),
            "modelMN" to getModelPath("modelMN.tflite"),
            "modelRNmod" to getModelPath("modelRNmod.tflite")
        )
    }
}
