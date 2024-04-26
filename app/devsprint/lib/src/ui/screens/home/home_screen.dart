import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '/services/l10n/locale_extention.dart';
import '/services/router.dart';
import '/src/global/global.dart';
import '/src/ui/widgets/icons.dart';
import 'home_screen_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(countProvider);
    final colors = ref.watch(countColorsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.appName),
        actions: [
          IconButton(
            icon: const IIcon(
              FontAwesomeIcons.gear,
              fontAwesome: true,
            ),
            onPressed: () {
              context.pushNamed(AppRoutes.settings.name);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ref.read(countProvider.notifier).increment,
        child: const IIcon(
          FontAwesomeIcons.plus,
          fontAwesome: true,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: colors.$1,
              minRadius: 160,
              child: Animate(
                effects: const [FadeEffect(), ScaleEffect()],
                key: ValueKey(count),
                child: Text(
                  '$count',
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontSize: 100,
                    color: colors.$2,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: context.colorScheme.secondary,
                        offset: const Offset(2, 2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
