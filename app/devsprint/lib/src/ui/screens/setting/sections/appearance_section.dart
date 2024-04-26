import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/services/l10n/locale_extention.dart';
import '/services/themes/theme_config_provider.dart';
import '/src/global/extention.dart';
import '/src/ui/screens/setting/widgets/font_change_dropdown.dart';
import '/src/ui/screens/setting/widgets/language_change_dropdown.dart';
import '/src/ui/screens/setting/widgets/setting_container_w.dart';
import '/src/ui/screens/setting/widgets/setting_list_tile_w.dart';
import '/src/ui/screens/setting/widgets/theme_choose_dropdown.dart';
import '/src/ui/screens/setting/widgets/theme_color_button.dart';

class AppearanceSection extends ConsumerWidget {
  const AppearanceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeSettingProvider);

    return SettingContainer(
      title: context.l10n.appearance,
      settings: [
        SettingListTile(
          title: context.l10n.language,
          icon: Icons.language,
          leading: const LanguageChangeButton(),
        ),
        SettingListTile(
          title: context.l10n.theme,
          icon: themeMode.icon,
          leading: const ThemeChooseDropdown(),
        ),
        SettingListTile(
          title: context.l10n.colorTheme,
          icon: Icons.color_lens,
          leading: const ThemeColorPickDropdown(),
        ),
        SettingListTile(
          title: context.l10n.font,
          icon: Icons.font_download,
          leading: const FontChangeDropdown(),
        ),
        SettingListTile(
          title: context.l10n.reset,
          icon: Icons.refresh,
          leading: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: context.theme.colorScheme.error,
              ),
              child: Text(context.l10n.reset)),
        ),
      ],
    );
  }
}
