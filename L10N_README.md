aku ingin jika # Localization (l10n) Documentation

## Overview
This app now supports multiple languages using Flutter's l10n (localization) system:
- 🇬🇧 English (en)
- 🇮🇩 Bahasa Indonesia (id)

## How to Use

### Switching Languages
Users can switch languages in two ways:
1. **Language Switcher Icon**: Tap the globe icon (🌐) in the app bar to manually select a language
2. **System Default**: The app will automatically use your device's language setting if supported

### For Developers

#### Adding New Translations
1. Edit the ARB files in `lib/l10n/`:
   - `app_en.arb` - English translations
   - `app_id.arb` - Indonesian translations

2. Run `flutter pub get` to regenerate localization files

3. Use translations in your code:
```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// In your build method:
final l10n = AppLocalizations.of(context)!;
Text(l10n.checkStress)  // Will show "Check Stress" or "Cek Stres"
```

#### Adding a New Language
1. Create a new ARB file: `lib/l10n/app_<locale>.arb` (e.g., `app_es.arb` for Spanish)
2. Copy the structure from `app_en.arb` and translate all strings
3. Add the new locale to `lib/main.dart`:
```dart
supportedLocales: [
  Locale('en'),
  Locale('id'),
  Locale('es'),  // Add new locale here
],
```
4. Update the language switcher in `lib/widgets/language_switcher.dart`

## Files Modified
- `pubspec.yaml` - Added localization dependencies
- `l10n.yaml` - Configuration for l10n generation
- `lib/l10n/app_en.arb` - English translations
- `lib/l10n/app_id.arb` - Indonesian translations
- `lib/main.dart` - Localization delegates and locale management
- `lib/pages/home_page.dart` - Implemented localized strings
- `lib/pages/about_page.dart` - Implemented localized strings
- `lib/widgets/language_switcher.dart` - Language selection widget

## Features Localized
- ✅ App title and navigation
- ✅ Home page UI (buttons, labels, messages)
- ✅ Stress detection results
- ✅ Suggestions for stress and non-stress states
- ✅ About page content
- ✅ Reference citations
- ✅ All user-facing text

## Technical Details
- Uses Flutter's official localization package
- ARB (Application Resource Bundle) format for translations
- Automatic code generation via `flutter_gen`
- Type-safe access to translations
- Support for parameterized strings (e.g., year in copyright)
