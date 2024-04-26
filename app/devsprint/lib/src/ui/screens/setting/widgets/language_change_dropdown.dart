import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/services/l10n/locale.dart';
import '/services/l10n/locale_provider.dart';

class LanguageChangeButton extends ConsumerWidget {
  const LanguageChangeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(l10nProvider);

    return DropdownButton<AppLocale>(
      borderRadius: BorderRadius.circular(20),
      value: AppLocale.fromLocale(locale),
      underline: const SizedBox.shrink(),
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
      onChanged: (value) {
        if (value != null) {
          ref.read(l10nProvider.notifier).update(value);
        }
      },
      items: AppLocale.list.map((e) {
        return DropdownMenuItem(
          value: e,
          child: Text(e.title),
        );
      }).toList(),
    );
  }
}
