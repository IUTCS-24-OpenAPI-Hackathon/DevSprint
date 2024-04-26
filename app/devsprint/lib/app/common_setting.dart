import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppFlavor {
  development('Development'),
  production('Production');

  final String name;
  const AppFlavor(this.name);
}

class GlobalSettings {
  static AppFlavor appFlavor = AppFlavor.production;
  static const themeMode = ThemeMode.system;
  static Locale? locale;
  static Color colorSchemeSeed = Colors.indigo;
  static String? fontFamily = GoogleFonts.ubuntu().fontFamily;
}

void registerErrorHandlers() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };

  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint(error.toString());
    return true;
  };

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('An error occurred'),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}
