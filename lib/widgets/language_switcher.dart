import 'package:flutter/material.dart';
import 'package:mystessd/main.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get current locale
    final currentLocale = Localizations.localeOf(context);

    // Determine which flag to show based on current locale
    String currentFlag = currentLocale.languageCode == 'id' ? '🇮🇩' : '🇬🇧';

    return PopupMenuButton<Locale>(
      icon: Text(
        currentFlag,
        style: TextStyle(fontSize: 24),
      ),
      onSelected: (Locale locale) {
        MyApp.setLocale(context, locale);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
        const PopupMenuItem<Locale>(
          value: Locale('en'),
          child: Row(
            children: [
              Text('🇬🇧 '),
              SizedBox(width: 8),
              Text('English'),
            ],
          ),
        ),
        const PopupMenuItem<Locale>(
          value: Locale('id'),
          child: Row(
            children: [
              Text('🇮🇩 '),
              SizedBox(width: 8),
              Text('Bahasa Indonesia'),
            ],
          ),
        ),
      ],
    );
  }
}
