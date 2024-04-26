import 'dart:ui' show Color;

extension ColorToHex on Color {
  String toHex() {
    return '#${value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }
}

extension HexToColor on String {
  Color hexToColor() {
    return Color(int.parse(replaceFirst('#', '0xFF')));
  }
}
