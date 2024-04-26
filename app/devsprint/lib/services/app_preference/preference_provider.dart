import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/services/app_preference/default_preference.dart';
import '/services/local_storage/local_storage_provider.dart';
import '/services/local_storage/shared_preferences.dart';
import 'app_preference.dart' as pref_;

part 'preference_provider.g.dart';

@Riverpod(keepAlive: true)
class AppPreference extends _$AppPreference {
  final String _key = 'app_settings';

  @override
  pref_.AppPreference build() {
    return pref_.AppPreference(
      colorSchemeSeed: DefaultPreference.defaultColorSchemeSeed,
      fontFamily: DefaultPreference.defaultFontFamily,
      locale: DefaultPreference.defaultLocale,
      themeMode: DefaultPreference.defaultThemeMode,
    );
  }

  Future<void> load() async {
    final pref = await ref.read(sharedPreferencesProvider.future);
    final localStorage = LocalStorage(pref);

    final result = await localStorage.read<Json>(_key);
    if (result == null) return;

    final appSettings = pref_.AppPreference.fromJson(result);
    state = appSettings;
  }

  void update({
    ThemeMode? themeMode,
    bool? isDarkMode,
    Locale? locale,
    String? colorSchemeSeed,
    String? fontFamily,
  }) {
    pref_.AppPreference appSettings = pref_.AppPreference(
      themeMode: themeMode ?? state.themeMode,
      locale: locale ?? state.locale,
      colorSchemeSeed: colorSchemeSeed ?? state.colorSchemeSeed,
      fontFamily: fontFamily ?? state.fontFamily,
    );

    _save(appSettings);
  }

  void _save(pref_.AppPreference appSettings) {
    state = appSettings;
    ref.read(localStorageProvider).save<Json>(_key, appSettings.toJson());
  }
}
