# MyStessD - Stress Detection Application

<p align="center">
  <img src="assets/myStresD.png" alt="MyStessD Logo" width="200"/>
</p>

MyStessD adalah aplikasi mobile berbasis Flutter yang memanfaatkan teknologi Machine Learning dan Computer Vision untuk mendeteksi tingkat stres pengguna melalui analisis ekspresi wajah secara real-time. Aplikasi ini menggunakan TensorFlow Lite dan Google ML Kit untuk memberikan hasil deteksi yang akurat dan cepat.

---

## 📱 Cara Menggunakan Aplikasi

1. **Buka Aplikasi**
   - Launch aplikasi MyStessD dari perangkat Android Anda

2. **Akses Kamera**
   - Aplikasi akan meminta izin akses kamera
   - Berikan izin yang diperlukan untuk melanjutkan

3. **Deteksi Stres Real-time**
   - Arahkan kamera ke wajah Anda
   - Aplikasi akan secara otomatis mendeteksi dan menganalisis ekspresi wajah
   - Hasil deteksi tingkat stres akan ditampilkan secara real-time

4. **Upload Gambar**
   - Gunakan fitur upload untuk menganalisis foto yang sudah ada
   - Pilih gambar dari galeri
   - Aplikasi akan memproses dan menampilkan hasil deteksi

5. **Lihat Informasi**
   - Akses menu "About" untuk melihat informasi lebih lanjut tentang aplikasi

---

## 🔧 Persyaratan / Requirements

### Software Requirements

- **Flutter SDK**: >= 3.2.0 < 4.0.0
- **Dart SDK**: >= 3.2.0 < 4.0.0
- **Android Studio** atau **Visual Studio Code** dengan Flutter Extension
- **Git** untuk version control

### Hardware Requirements

#### Untuk Development:
- **OS**: Windows 10/11, macOS 10.14+, atau Linux
- **RAM**: Minimum 8GB (16GB recommended)
- **Storage**: Minimum 10GB free space
- **Processor**: Intel Core i5 atau equivalent

#### Untuk Running/Testing di Android:
- **Android Device/Emulator**:
  - Android SDK Version: 26 (Android 8.0) atau lebih tinggi
  - Target SDK: 36
  - RAM: Minimum 2GB
  - Storage: Minimum 500MB

### Dependencies Utama

```yaml
dependencies:
  flutter:
    sdk: flutter
  camera: ^0.10.5+7
  tflite_flutter: ^0.10.4
  tflite_v2: ^1.0.0
  image_picker: ^1.0.7
  google_ml_kit: ^0.20.0
  google_fonts: ^6.1.0
```

---

## 🚀 Langkah Instalasi Awal (Initial Setup)

### 1. Install Flutter SDK

**macOS:**
```bash
# Download Flutter SDK
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# Verifikasi instalasi
flutter doctor
```

**Windows:**
- Download Flutter SDK dari [flutter.dev](https://flutter.dev/docs/get-started/install)
- Extract ke folder pilihan (contoh: C:\src\flutter)
- Tambahkan Flutter ke PATH environment variable
- Run `flutter doctor` di Command Prompt

**Linux:**
```bash
sudo snap install flutter --classic
flutter doctor
```

### 2. Setup Android Development Environment

1. **Install Android Studio**
   - Download dari [developer.android.com](https://developer.android.com/studio)
   - Install Android SDK, Android SDK Platform, dan Android Virtual Device

2. **Accept Android Licenses**
   ```bash
   flutter doctor --android-licenses
   ```

3. **Verifikasi Setup**
   ```bash
   flutter doctor -v
   ```

### 3. Clone Repository

```bash
git clone <repository-url>
cd myStessD
```

### 4. Install Dependencies

```bash
# Get Flutter packages
flutter pub get

# Generate launcher icons
dart run flutter_launcher_icons
```

### 5. Setup TensorFlow Lite Models

Model-model ML sudah termasuk dalam folder `assets/`:
- `modelDNmod.tflite` - Deep Neural Network Model
- `modelMN.tflite` - MobileNet Model  
- `modelRNmod.tflite` - ResNet Model

Beserta file labels:
- `labelsDNmod.txt`
- `labelsMNmod.txt`
- `labelsRNmod.txt`

### 6. Konfigurasi Project

Pastikan file `config.json` sudah sesuai dengan kebutuhan Anda.

---

## 💻 Langkah Pengembangan Lokal (Local Development Steps)

### 1. Persiapan Environment

```bash
# Pastikan berada di direktori project
cd /path/to/myStessD

# Verify Flutter installation
flutter doctor

# Clean previous builds
flutter clean
flutter pub get
```

### 2. Running di Emulator/Device

**Menggunakan Android Emulator:**
```bash
# List available emulators
flutter emulators

# Launch emulator
flutter emulators --launch <emulator_id>

# Run app
flutter run
```

**Menggunakan Physical Device:**
```bash
# Enable USB Debugging pada device Android
# Connect device via USB

# Verify device is connected
flutter devices

# Run app
flutter run
```

### 3. Development dengan Hot Reload

```bash
# Run dalam mode debug (dengan hot reload)
flutter run

# Di terminal saat app running:
# - Press 'r' untuk hot reload
# - Press 'R' untuk hot restart
# - Press 'p' untuk toggle performance overlay
# - Press 'q' untuk quit
```

### 4. Debugging

**Menggunakan VS Code:**
1. Buka project di VS Code
2. Set breakpoints di code
3. Press F5 atau Run > Start Debugging
4. Gunakan Debug Console untuk melihat logs

**Menggunakan Android Studio:**
1. Buka project di Android Studio
2. Set breakpoints
3. Click Run > Debug 'main.dart'
4. Gunakan Debugger panel

### 5. Code Quality & Testing

```bash
# Analyze code
flutter analyze

# Format code
flutter format lib/

# Run tests (jika ada)
flutter test
```

### 6. Build untuk Testing

**Debug APK:**
```bash
flutter build apk --debug
```

**Profile APK (untuk performance testing):**
```bash
flutter build apk --profile
```

---

## 🏗️ Langkah Deploy untuk Versi Produksi (Production Deployment Steps)

### 1. Persiapan Pre-Production

#### Update Version

Edit `pubspec.yaml`:
```yaml
version: 1.0.0+1  # Format: <major>.<minor>.<patch>+<build-number>
```

#### Update App Configuration

Pastikan konfigurasi sudah sesuai untuk production:

**android/app/build.gradle:**
```gradle
defaultConfig {
    applicationId "com.example.emotion_detection_app"
    minSdkVersion 26
    targetSdkVersion 36
    versionCode 1
    versionName "1.0.0"
}
```

**AndroidManifest.xml:**
- Verify app permissions
- Remove debug configurations
- Set proper app label: "MyStessD"

### 2. Code Optimization

```bash
# Clean project
flutter clean

# Get dependencies
flutter pub get

# Analyze code untuk issues
flutter analyze

# Fix formatting
flutter format lib/
```

### 3. Build Release APK

#### Build Standard APK (Universal)

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

#### Build Split APKs (Optimized untuk ukuran)

```bash
flutter build apk --split-per-abi
```

Output files:
- `app-armeabi-v7a-release.apk` (32-bit ARM)
- `app-arm64-v8a-release.apk` (64-bit ARM)
- `app-x86_64-release.apk` (64-bit x86)

### 4. Build Android App Bundle (AAB)

Recommended untuk Google Play Store:

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

### 5. Setup App Signing (untuk Production)

#### Generate Keystore

```bash
keytool -genkey -v -keystore ~/myStessD-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias mystessd
```

#### Configure Signing

Buat file `android/key.properties`:
```properties
storePassword=<password>
keyPassword=<password>
keyAlias=mystessd
storeFile=/path/to/myStessD-key.jks
```

Update `android/app/build.gradle`:
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    ...
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}
```

### 6. Testing Production Build

```bash
# Install release APK ke device
flutter install --release

# Test semua fitur aplikasi
# - Camera functionality
# - Image picker
# - ML model inference
# - UI/UX flow
```

### 7. Deploy ke Google Play Store

#### Persiapan:

1. **Buat Developer Account** di [Google Play Console](https://play.google.com/console)
2. **Siapkan Assets**:
   - App icon (512x512 px)
   - Feature graphic (1024x500 px)
   - Screenshots (minimum 2)
   - Privacy policy URL
   - App description

#### Upload Process:

1. Login ke Google Play Console
2. Create New App
3. Fill in app details:
   - App name: MyStessD
   - Default language: Indonesian
   - App type: Application
   - Category: Health & Fitness / Productivity

4. Upload AAB file:
   - Go to Production > Create new release
   - Upload `app-release.aab`
   - Fill release notes
   - Review and rollout

5. Content Rating:
   - Complete questionnaire
   - Get rating

6. Pricing & Distribution:
   - Set price (Free/Paid)
   - Select countries
   - Accept terms

7. Submit for Review

### 8. Post-Deployment

#### Monitor Performance:
```bash
# Check app bundle size
flutter build appbundle --release --analyze-size
```

#### Update Strategy:
- Gunakan semantic versioning (MAJOR.MINOR.PATCH)
- Increment versionCode untuk setiap release
- Maintain changelog

#### Rollback Plan:
- Keep previous APK/AAB files
- Google Play Console allows rollback to previous versions
- Test thoroughly before releasing updates

---

## 📂 Struktur Project

```
myStessD/
├── android/              # Android native code & configuration
├── ios/                  # iOS native code & configuration
├── lib/                  # Dart source code
│   ├── main.dart        # Entry point aplikasi
│   ├── constans.dart    # Constants & configuration
│   └── pages/           # UI screens
│       ├── home_page.dart
│       └── about_page.dart
├── assets/              # Assets (images, models, labels)
│   ├── modelDNmod.tflite
│   ├── modelMN.tflite
│   ├── modelRNmod.tflite
│   ├── labelsDNmod.txt
│   ├── labelsMNmod.txt
│   ├── labelsRNmod.txt
│   └── myStresD.png
├── plugins/             # Custom Flutter plugins
│   └── tflite_v2/
├── pubspec.yaml         # Project dependencies
├── config.json          # App configuration
└── README.md           # Project documentation
```

---

## 🛠️ Troubleshooting

### Common Issues

**Issue: Build Failed - Missing Classes**
```bash
# Solution: Pastikan ProGuard rules sudah benar
# Check android/app/proguard-rules.pro
```

**Issue: Camera Permission Denied**
```bash
# Solution: Pastikan AndroidManifest.xml memiliki camera permission
<uses-permission android:name="android.permission.CAMERA" />
```

**Issue: ML Model Not Loading**
```bash
# Solution: Verify assets sudah di-list di pubspec.yaml
flutter clean
flutter pub get
```

**Issue: Gradle Build Timeout**
```bash
# Solution: Increase heap size di android/gradle.properties
org.gradle.jvmargs=-Xmx4096M
```

---

## 📝 License

[Tambahkan informasi lisensi di sini]

---

## 👥 Contributors

- [Tambahkan nama kontributor]

---

## 📧 Contact

Untuk pertanyaan atau dukungan, silakan hubungi:
- Email: [email@example.com]
- Website: [website-url]

---

## 🙏 Acknowledgments

- Flutter Team untuk framework yang luar biasa
- Google ML Kit untuk ML capabilities
- TensorFlow Lite untuk model inference
- Semua contributors dan testers

---

**Catatan**: Dokumentasi ini akan terus diperbarui seiring dengan perkembangan aplikasi.
