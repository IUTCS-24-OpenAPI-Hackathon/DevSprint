import 'package:flutter/material.dart';

import '/app/common_setting.dart';

extension on Color {
  String _toHex() {
    return '#${value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }
}

@immutable
class DefaultPreference {
  const DefaultPreference._();

  static const defaultThemeMode = GlobalSettings.themeMode;
  static Locale? defaultLocale = GlobalSettings.locale;
  static String defaultColorSchemeSeed =
      GlobalSettings.colorSchemeSeed._toHex();
  static String? defaultFontFamily = GlobalSettings.fontFamily;
}
