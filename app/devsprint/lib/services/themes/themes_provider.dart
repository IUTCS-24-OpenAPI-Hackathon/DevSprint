import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'theme_config_provider.dart';

part 'themes_provider.g.dart';

@Riverpod(keepAlive: false)
class Themes extends _$Themes {
  @override
  (ThemeData, ThemeData) build() {
    final colorSchemeSeed = ref.watch(colorSchemeSeedProvider);
    final font = ref.watch(appFontProvider);

    final light = ThemeData(
      useMaterial3: true,
      colorSchemeSeed: colorSchemeSeed,
      fontFamily: font,
      brightness: Brightness.light,
    );

    final dark = ThemeData(
      useMaterial3: true,
      colorSchemeSeed: colorSchemeSeed,
      fontFamily: font,
      brightness: Brightness.dark,
    );

    return (light, dark);
  }
}
