import 'package:flutter/material.dart';

enum AppLocale {
  enUS(Locale('en', 'US'), 'English'),
  bnBD(Locale('bn', 'BD'), 'বাংলা');

  final Locale locale;
  final String title;
  const AppLocale(this.locale, this.title);

  static const List<AppLocale> list = [enUS, bnBD];

  static AppLocale fromLocale(Locale? locale) {
    return list.firstWhere((e) => e.locale == locale, orElse: () => enUS);
  }

  static AppLocale fromString(String locale) {
    return list.firstWhere((e) => e.locale.languageCode == locale,
        orElse: () => enUS);
  }
}
