import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/services/app_preference/preference_provider.dart';
import '/services/l10n/locale.dart';

part 'locale_provider.g.dart';

@riverpod
class L10n extends _$L10n {
  @override
  Locale? build() {
    return ref.watch(appPreferenceProvider).locale;
  }

  void update(AppLocale locale) {
    ref.read(appPreferenceProvider.notifier).update(locale: locale.locale);
  }
}
