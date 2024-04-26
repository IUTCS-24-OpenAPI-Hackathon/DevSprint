// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$colorSchemeSeedHash() => r'45b8bd56a5d7d1e97dafd08076882500258650bf';

/// See also [ColorSchemeSeed].
@ProviderFor(ColorSchemeSeed)
final colorSchemeSeedProvider =
    NotifierProvider<ColorSchemeSeed, Color>.internal(
  ColorSchemeSeed.new,
  name: r'colorSchemeSeedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$colorSchemeSeedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ColorSchemeSeed = Notifier<Color>;
String _$appFontHash() => r'10b12c9b7dc8b1d57d90074751ce3c428fb712cd';

/// See also [AppFont].
@ProviderFor(AppFont)
final appFontProvider = AutoDisposeNotifierProvider<AppFont, String?>.internal(
  AppFont.new,
  name: r'appFontProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appFontHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppFont = AutoDisposeNotifier<String?>;
String _$themeSettingHash() => r'34453d165a2e74cf4b5baaebcaa9ce0304f090e3';

/// See also [ThemeSetting].
@ProviderFor(ThemeSetting)
final themeSettingProvider = NotifierProvider<ThemeSetting, ThemeMode>.internal(
  ThemeSetting.new,
  name: r'themeSettingProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$themeSettingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ThemeSetting = Notifier<ThemeMode>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
