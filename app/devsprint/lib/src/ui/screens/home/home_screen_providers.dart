import 'dart:math';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/services/logger.dart';

part 'home_screen_providers.g.dart';

@riverpod
class Count extends _$Count {
  @override
  int build() {
    return 0;
  }

  void increment() {
    state++;
    AppLogger().logger.i('Count incremented to $state');
  }

  void decrement() {
    state--;
  }
}

@riverpod
(Color, Color) countColors(CountColorsRef ref) {
  final count = ref.watch(countProvider);

  Color getUniqueColor(int number) {
    final random = Random(number);
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  Color getContrastingColor(Color backgroundColor) {
    final brightness = ThemeData.estimateBrightnessForColor(backgroundColor);
    final isDarkBackground = brightness == Brightness.dark;

    return isDarkBackground ? Colors.white : Colors.black;
  }

  final backgroundColor = getUniqueColor(count);
  final foregroundColor = getContrastingColor(backgroundColor);

  return (backgroundColor, foregroundColor);
}
