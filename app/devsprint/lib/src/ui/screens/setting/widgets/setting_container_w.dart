import 'package:flutter/material.dart';

import '/src/global/extention.dart';
import 'setting_list_tile_w.dart';

class SettingContainer extends StatelessWidget {
  SettingContainer({
    super.key,
    required this.title,
    required this.settings,
    this.width,
    this.height,
    this.color,
    this.borderColor,
    this.borderRadius,
    this.borderWidth = 1,
    this.edgePadding = const EdgeInsets.all(12),
  }) {
    assert(settings.isNotEmpty, 'settings must not be empty');
    assert(edgePadding.isNonNegative, 'edgePadding must be non-negative');
    assert(borderWidth >= 0, 'borderWidth must be non-negative');
  }

  final String title;
  final List<SettingListTile> settings;
  final EdgeInsetsGeometry edgePadding;

  final double? width, height, borderRadius;
  final double borderWidth;
  final Color? color;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edgePadding,
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  title,
                  style: context.textTheme.titleMedium,
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                constraints: BoxConstraints(
                  maxWidth: 500,
                  maxHeight: height ?? double.infinity,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(borderRadius ?? 16),
                  border: Border.all(
                    color: borderColor ?? context.colorScheme.outline,
                    width: borderWidth,
                  ),
                ),
                child: Column(
                  children: settings,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
