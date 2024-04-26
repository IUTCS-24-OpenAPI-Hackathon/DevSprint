import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/services/app_preference/preference_provider.dart';
import '/services/themes/theme_extention.dart';

part 'theme_config_provider.g.dart';

@immutable
class AppFonts {
  static List<String?> list = [
    GoogleFonts.abel().fontFamily,
    GoogleFonts.aBeeZee().fontFamily,
    GoogleFonts.acme().fontFamily,
    GoogleFonts.adamina().fontFamily,
    GoogleFonts.adventPro().fontFamily,
    GoogleFonts.alike().fontFamily,
    GoogleFonts.alikeAngular().fontFamily,
    GoogleFonts.aladin().fontFamily,
    GoogleFonts.alata().fontFamily,
    GoogleFonts.alegreya().fontFamily,
    GoogleFonts.alegreyaSans().fontFamily,
    GoogleFonts.alegreyaSansSc().fontFamily,
    GoogleFonts.alegreyaSc().fontFamily,
    GoogleFonts.alice().fontFamily,
    GoogleFonts.alike().fontFamily,
    GoogleFonts.arimo().fontFamily,
    GoogleFonts.breeSerif().fontFamily,
    GoogleFonts.cabin().fontFamily,
    GoogleFonts.cairo().fontFamily,
    GoogleFonts.catamaran().fontFamily,
    GoogleFonts.cinzel().fontFamily,
    GoogleFonts.courgette().fontFamily,
    GoogleFonts.crimsonText().fontFamily,
    GoogleFonts.dancingScript().fontFamily,
    GoogleFonts.dosis().fontFamily,
    GoogleFonts.ebGaramond().fontFamily,
    GoogleFonts.exo2().fontFamily,
    GoogleFonts.hindSiliguri().fontFamily,
    GoogleFonts.ibmPlexSans().fontFamily,
    GoogleFonts.inter().fontFamily,
    GoogleFonts.josefinSans().fontFamily,
    GoogleFonts.kanit().fontFamily,
    GoogleFonts.karla().fontFamily,
    GoogleFonts.lato().fontFamily,
    GoogleFonts.merriweather().fontFamily,
    GoogleFonts.montserrat().fontFamily,
    GoogleFonts.mukta().fontFamily,
    GoogleFonts.notoSans().fontFamily,
    GoogleFonts.notoSansBengali().fontFamily,
    GoogleFonts.nunito().fontFamily,
    GoogleFonts.openSans().fontFamily,
    GoogleFonts.oswald().fontFamily,
    GoogleFonts.pacifico().fontFamily,
    GoogleFonts.playfairDisplay().fontFamily,
    GoogleFonts.poppins().fontFamily,
    GoogleFonts.ptSans().fontFamily,
    GoogleFonts.ptSerif().fontFamily,
    GoogleFonts.quicksand().fontFamily,
    GoogleFonts.raleway().fontFamily,
    GoogleFonts.roboto().fontFamily,
    GoogleFonts.robotoCondensed().fontFamily,
    GoogleFonts.robotoMono().fontFamily,
    GoogleFonts.robotoSlab().fontFamily,
    GoogleFonts.rubik().fontFamily,
    GoogleFonts.shanti().fontFamily,
    GoogleFonts.spectral().fontFamily,
    GoogleFonts.teko().fontFamily,
    GoogleFonts.titilliumWeb().fontFamily,
    GoogleFonts.ubuntu().fontFamily,
    GoogleFonts.vollkorn().fontFamily,
    GoogleFonts.workSans().fontFamily,
  ];
}

@Riverpod(keepAlive: true)
class ColorSchemeSeed extends _$ColorSchemeSeed {
  @override
  Color build() {
    final color = ref.watch(appPreferenceProvider).colorSchemeSeed;
    return color.hexToColor();
  }

  void update(Color color) {
    ref
        .read(appPreferenceProvider.notifier)
        .update(colorSchemeSeed: color.toHex());
    state = color;
  }
}

@Riverpod(keepAlive: false)
class AppFont extends _$AppFont {
  @override
  String? build() {
    return ref.watch(appPreferenceProvider).fontFamily;
  }

  void update(String? fontFamily) {
    ref.read(appPreferenceProvider.notifier).update(fontFamily: fontFamily);
  }
}

@Riverpod(keepAlive: true)
class ThemeSetting extends _$ThemeSetting {
  @override
  ThemeMode build() {
    return ref.watch(appPreferenceProvider).themeMode;
  }

  void toggleMode() {
    final setting = ref.watch(appPreferenceProvider);

    final isDarkMode = setting.themeMode == ThemeMode.dark;
    final themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;

    ref
        .read(appPreferenceProvider.notifier)
        .update(isDarkMode: isDarkMode, themeMode: themeMode);
  }

  void update(ThemeMode? themeMode) {
    ref.read(appPreferenceProvider.notifier).update(themeMode: themeMode);
  }
}
