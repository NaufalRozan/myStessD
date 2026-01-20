import 'package:flutter/services.dart';

/// Helper class untuk mengakses model AI dari Play Asset Delivery
class AssetPackService {
  static const MethodChannel _channel =
      MethodChannel('com.example.mystessd/assetpack');

  /// Mendapatkan path absolut ke file model
  ///
  /// [modelName] nama file model (contoh: "modelDNmod.tflite")
  /// Returns path absolut atau null jika tidak ditemukan
  static Future<String?> getModelPath(String modelName) async {
    try {
      final String? path = await _channel.invokeMethod('getModelPath', {
        'modelName': modelName,
      });
      return path;
    } on PlatformException catch (e) {
      print("Error getting model path: ${e.message}");
      return null;
    }
  }

  /// Cek apakah asset pack sudah siap digunakan
  static Future<bool> isAssetPackReady() async {
    try {
      final bool? ready = await _channel.invokeMethod('isAssetPackReady');
      return ready ?? false;
    } on PlatformException catch (e) {
      print("Error checking asset pack status: ${e.message}");
      return false;
    }
  }

  /// Mendapatkan semua path model yang tersedia
  ///
  /// Returns Map dengan key nama model dan value path-nya
  static Future<Map<String, String?>> getAllModelPaths() async {
    try {
      final Map<dynamic, dynamic>? paths =
          await _channel.invokeMethod('getAllModelPaths');
      if (paths == null) return {};

      return Map<String, String?>.from(paths);
    } on PlatformException catch (e) {
      print("Error getting all model paths: ${e.message}");
      return {};
    }
  }
}
