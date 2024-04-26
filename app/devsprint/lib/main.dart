import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/aurora.dart';
import 'app/common_setting.dart';
import 'services/logger.dart';

void main() {
  AppLogger().logger.i('Starting Aurora App');
  registerErrorHandlers();

  runApp(
    const ProviderScope(
      child: AuroraApp(),
    ),
  );
}
