import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/aurora.dart';
import 'app/common_setting.dart';
import 'services/l10n/locale.dart';

void main() {
  registerErrorHandlers();

  GlobalSettings.appFlavor = AppFlavor.development;
  GlobalSettings.locale = AppLocale.bnBD.locale;
  GlobalSettings.colorSchemeSeed = Colors.red;

  runApp(
    const ProviderScope(
      child: AuroraApp(),
    ),
  );
}
