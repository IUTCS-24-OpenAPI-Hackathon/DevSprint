import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/services/startup.dart';
import '/src/ui/screens/home/home_screen.dart';
import '/src/ui/screens/setting/setting_screen.dart';

part 'router.g.dart';

enum AppRoutes {
  initial,
  home,
  settings,
}

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final appStartupState = ref.watch(appStartupProvider);

  return GoRouter(
    redirect: (context, state) {
      if (appStartupState.isLoading || appStartupState.hasError) {
        return '/startup';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/startup',
        pageBuilder: (context, state) => NoTransitionPage(
          child: AppStartupWidget(onLoaded: (_) => const SizedBox.shrink()),
        ),
      ),
      GoRoute(
        path: '/',
        name: AppRoutes.initial.name,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: HomeScreen()),
      ),
      GoRoute(
        path: '/settings',
        name: AppRoutes.settings.name,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: SettingsScreen()),
      ),
    ],
  );
}
