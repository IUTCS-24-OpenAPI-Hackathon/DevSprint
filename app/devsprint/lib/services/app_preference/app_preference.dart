import 'dart:convert';

import 'package:flutter/material.dart';

class AppPreference {
  final ThemeMode themeMode;
  final Locale? locale;
  final String? fontFamily;
  final String colorSchemeSeed;

  const AppPreference(
      {required this.themeMode,
      this.locale,
      this.fontFamily,
      required this.colorSchemeSeed});

  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode.index,
      'locale': locale?.toLanguageTag(),
      'colorSchemeSeed': colorSchemeSeed,
      'fontFamily': fontFamily,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory AppPreference.fromJson(Map<String, dynamic> map) {
    return AppPreference(
      themeMode: ThemeMode.values[map['themeMode']],
      locale: map['locale'] != null
          ? Locale.fromSubtags(languageCode: map['locale'])
          : null,
      colorSchemeSeed: map['colorSchemeSeed'],
      fontFamily: map['fontFamily'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppPreference &&
        other.themeMode == themeMode &&
        other.locale == locale &&
        other.fontFamily == fontFamily &&
        other.colorSchemeSeed == colorSchemeSeed;
  }

  @override
  int get hashCode {
    return themeMode.hashCode ^
        locale.hashCode ^
        fontFamily.hashCode ^
        colorSchemeSeed.hashCode;
  }

  @override
  String toString() {
    return 'AppPreference(themeMode: $themeMode, locale: $locale, fontFamily: $fontFamily, colorSchemeSeed: $colorSchemeSeed)';
  }
}
