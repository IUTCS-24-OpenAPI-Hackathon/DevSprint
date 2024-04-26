import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/services/themes/theme_config_provider.dart';

enum AvailableThemes {
  light('light', 'Light', ThemeMode.light),
  dark('dark', 'Dark', ThemeMode.dark),
  system('system', 'System', ThemeMode.system);

  final String name;
  final String title;
  final ThemeMode mode;

  const AvailableThemes(this.name, this.title, this.mode);
}

class ThemeChooseDropdown extends ConsumerWidget {
  const ThemeChooseDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeSettingProvider);

    return DropdownButton<ThemeMode>(
      icon: const SizedBox.shrink(),
      borderRadius: BorderRadius.circular(20),
      underline: Container(),
      value: currentTheme,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
      items: AvailableThemes.values
          .map<DropdownMenuItem<ThemeMode>>(
            (e) => DropdownMenuItem<ThemeMode>(
              value: e.mode,
              child: Text(e.title),
            ),
          )
          .toList(),
      onChanged: (ThemeMode? mode) {
        ref.read(themeSettingProvider.notifier).update(mode);
      },
    );
  }
}
