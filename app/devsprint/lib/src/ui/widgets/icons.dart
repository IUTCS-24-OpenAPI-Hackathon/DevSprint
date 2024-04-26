import 'package:flutter/material.dart';

class IIcon extends StatelessWidget {
  const IIcon(
    this.icon, {
    super.key,
    this.color,
    this.size = 24.0,
    this.fontAwesome = false,
  });

  final IconData? icon;
  final Color? color;
  final double size;
  final bool fontAwesome;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color,
      size: fontAwesome ? (size * 0.90) : size,
    );
  }
}
