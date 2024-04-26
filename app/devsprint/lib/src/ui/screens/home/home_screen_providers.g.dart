// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$countColorsHash() => r'5c9aaf815e2cf11565ddab65e15e840c19b3f9c2';

/// See also [countColors].
@ProviderFor(countColors)
final countColorsProvider = AutoDisposeProvider<(Color, Color)>.internal(
  countColors,
  name: r'countColorsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$countColorsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CountColorsRef = AutoDisposeProviderRef<(Color, Color)>;
String _$countHash() => r'f741fedece6252de6e3bb9c210899f327e929d5a';

/// See also [Count].
@ProviderFor(Count)
final countProvider = AutoDisposeNotifierProvider<Count, int>.internal(
  Count.new,
  name: r'countProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$countHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Count = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
