import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import '../services/asset_pack_service.dart';

/// Contoh cara menggunakan Play Asset Delivery dengan TFLite
class ModelLoaderExample extends StatefulWidget {
  const ModelLoaderExample({super.key});

  @override
  State<ModelLoaderExample> createState() => _ModelLoaderExampleState();
}

class _ModelLoaderExampleState extends State<ModelLoaderExample> {
  Interpreter? _interpreter;
  String _status = 'Belum dimuat';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkAssetPackStatus();
  }

  /// Cek status asset pack saat widget pertama kali dimuat
  Future<void> _checkAssetPackStatus() async {
    final isReady = await AssetPackService.isAssetPackReady();
    setState(() {
      _status = isReady
          ? 'Asset pack siap, tap tombol untuk load model'
          : 'Asset pack belum tersedia';
    });
  }

  /// Load model dari asset pack
  Future<void> _loadModel() async {
    setState(() {
      _isLoading = true;
      _status = 'Memuat model...';
    });

    try {
      // 1. Cek apakah asset pack sudah ready
      final isReady = await AssetPackService.isAssetPackReady();
      if (!isReady) {
        throw Exception('Asset pack belum tersedia');
      }

      // 2. Dapatkan path model dari asset pack
      final modelPath =
          await AssetPackService.getModelPath('modelDNmod.tflite');
      if (modelPath == null) {
        throw Exception('Model tidak ditemukan di asset pack');
      }

      debugPrint('Loading model from: $modelPath');

      // 3. Load model menggunakan TFLite
      _interpreter = await Interpreter.fromFile(File(modelPath));

      setState(() {
        _status = 'Model berhasil dimuat dari:\n$modelPath';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _status = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  /// Load semua model sekaligus
  Future<void> _loadAllModels() async {
    setState(() {
      _isLoading = true;
      _status = 'Memuat semua model...';
    });

    try {
      final allPaths = await AssetPackService.getAllModelPaths();

      StringBuffer sb = StringBuffer('Model paths:\n\n');
      allPaths.forEach((name, path) {
        sb.writeln('$name: ${path ?? "tidak ditemukan"}');
      });

      setState(() {
        _status = sb.toString();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _status = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asset Pack Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(_status),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _checkAssetPackStatus,
              child: const Text('Cek Status Asset Pack'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _isLoading ? null : _loadModel,
              child: const Text('Load Model DNmod'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _isLoading ? null : _loadAllModels,
              child: const Text('Lihat Semua Path Model'),
            ),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
