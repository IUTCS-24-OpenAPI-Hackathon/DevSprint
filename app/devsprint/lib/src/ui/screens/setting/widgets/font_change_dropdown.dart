import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/services/themes/theme_config_provider.dart';

class FontChangeDropdown extends ConsumerWidget {
  const FontChangeDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final font = ref.watch(appFontProvider);

    return DropdownButton<String>(
        icon: const SizedBox.shrink(),
        borderRadius: BorderRadius.circular(20),
        value: font,
        underline: const SizedBox.shrink(),
        alignment: Alignment.center,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
        onChanged: (value) {
          ref.read(appFontProvider.notifier).update(value);
        },
        items: AppFonts.list
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(
                  (e?.replaceAll('_regular', '') ?? '').trim(),
                  textAlign: TextAlign.end,
                  style: TextStyle(fontFamily: e),
                ),
              ),
            )
            .toList());
  }
}
