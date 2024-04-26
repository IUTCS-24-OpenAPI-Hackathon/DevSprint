import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/services/l10n/locale_provider.dart';
import '/services/router.dart';
import '/services/themes/theme_config_provider.dart';
import '/services/themes/themes_provider.dart';

class AuroraApp extends ConsumerWidget {
  const AuroraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = ref.watch(themesProvider);

    return MaterialApp.router(
      routerConfig: ref.watch(goRouterProvider),
      theme: themeData.$1,
      darkTheme: themeData.$2,
      themeMode: ref.watch(themeSettingProvider),
      locale: ref.watch(l10nProvider),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
