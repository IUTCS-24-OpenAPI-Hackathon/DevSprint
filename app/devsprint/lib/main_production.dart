import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/aurora.dart';
import 'app/common_setting.dart';

void main() {
  registerErrorHandlers();

  runApp(
    const ProviderScope(
      child: AuroraApp(),
    ),
  );
}
