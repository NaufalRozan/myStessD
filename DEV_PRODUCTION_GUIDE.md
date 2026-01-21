# Development vs Production - Model Loading

## 🔄 Model Loading Strategy

Aplikasi ini menggunakan **dual-mode loading** untuk model AI:

### 📱 Production (AAB di Play Store)
- Model di-load dari **Play Asset Delivery (asset pack)**
- Path: `android/ai_models/src/main/assets/*.tflite`
- Ukuran AAB lebih kecil (< 200 MB)

### 💻 Development (local testing)
- Model di-load dari **assets reguler**
- Path: `assets/*.tflite`
- Untuk testing di emulator/debug mode

## ⚙️ Cara Kerja

```dart
// Kode mencoba load dari asset pack dulu
modelPath = await AssetPackService.getModelPath('modelDNmod.tflite');

// Jika gagal (development mode), fallback ke assets
if (modelPath == null) {
  await Tflite.loadModel(model: "assets/modelDNmod.tflite", ...);
}
```

## 🛠️ Setup Development

Sebelum testing lokal, copy model ke assets:

```bash
# Copy model dari asset pack ke assets
cp android/ai_models/src/main/assets/*.tflite assets/

# Run app
flutter run
```

## 📦 Build Production

Sebelum build AAB, hapus model dari assets (opsional):

```bash
# Hapus model dari assets (untuk menghemat ukuran)
rm assets/model*.tflite

# Build AAB
flutter build appbundle --release

# Restore model untuk development lagi
cp android/ai_models/src/main/assets/*.tflite assets/
```

## ✅ Best Practice

**Untuk Development:**
- ✓ Model ada di `assets/` folder
- ✓ Testing lebih cepat (langsung load dari assets)
- ✓ Berfungsi di emulator

**Untuk Production Build:**
- ✓ Model bisa dihapus dari `assets/` (hemat 181 MB)
- ✓ Model tetap tersedia via asset pack
- ✓ AAB size < 200 MB

## 📝 Notes

- Asset pack **hanya berfungsi** setelah app di-install dari Play Store
- Untuk local APK install (sideload), gunakan assets reguler
- Development mode otomatis fallback ke assets jika asset pack tidak tersedia
