import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/services/themes/theme_config_provider.dart';
import '/services/themes/theme_extention.dart';
import '/src/global/extention.dart';

class ThemeColorPickDropdown extends ConsumerWidget {
  const ThemeColorPickDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorNames = {
      Colors.pink.toHex().hexToColor(): "pink",
      Colors.pinkAccent.toHex().hexToColor(): "pinkAccent",
      "#FFC0CB".hexToColor(): "lightPink",
      "#FFB6C1".hexToColor(): "lightPink",
      Colors.red.toHex().hexToColor(): "red",
      Colors.redAccent.toHex().hexToColor(): "redAccent",
      "#FF6347".hexToColor(): "tomato",
      "#FF0000".hexToColor(): "brightRed",
      Colors.deepOrange.toHex().hexToColor(): "deepOrange",
      Colors.deepOrangeAccent.toHex().hexToColor(): "deepOrangeAccent",
      "#FF8C00".hexToColor(): "darkOrange",
      "#FF7F50".hexToColor(): "coral",
      Colors.orange.toHex().hexToColor(): "orange",
      Colors.orangeAccent.toHex().hexToColor(): "orangeAccent",
      "#FFA500".hexToColor(): "orange",
      "#FFA07A".hexToColor(): "lightSalmon",
      Colors.amber.toHex().hexToColor(): "amber",
      Colors.amberAccent.toHex().hexToColor(): "amberAccent",
      "#FFD700".hexToColor(): "gold",
      "#FFFF00".hexToColor(): "yellow",
      Colors.yellow.toHex().hexToColor(): "yellow",
      Colors.yellowAccent.toHex().hexToColor(): "yellowAccent",
      "#FFFFE0".hexToColor(): "lightYellow",
      "#FAFAD2".hexToColor(): "lightYellow",
      Colors.lime.toHex().hexToColor(): "lime",
      Colors.limeAccent.toHex().hexToColor(): "limeAccent",
      "#32CD32".hexToColor(): "limeGreen",
      "#00FF00".hexToColor(): "green",
      Colors.lightGreen.toHex().hexToColor(): "lightGreen",
      Colors.lightGreenAccent.toHex().hexToColor(): "lightGreenAccent",
      "#90EE90".hexToColor(): "lightGreen",
      "#98FB98".hexToColor(): "paleGreen",
      Colors.green.toHex().hexToColor(): "green",
      Colors.greenAccent.toHex().hexToColor(): "greenAccent",
      "#008000".hexToColor(): "darkGreen",
      "#006400".hexToColor(): "darkGreen",
      Colors.teal.toHex().hexToColor(): "teal",
      Colors.tealAccent.toHex().hexToColor(): "tealAccent",
      "#008080".hexToColor(): "teal",
      "#00FFFF".hexToColor(): "aqua",
      Colors.cyan.toHex().hexToColor(): "cyan",
      Colors.cyanAccent.toHex().hexToColor(): "cyanAccent",
      "#00FFFF".hexToColor(): "aqua",
      "#00CED1".hexToColor(): "darkTurquoise",
      Colors.lightBlue.toHex().hexToColor(): "lightBlue",
      Colors.lightBlueAccent.toHex().hexToColor(): "lightBlueAccent",
      "#ADD8E6".hexToColor(): "lightBlue",
      "#87CEEB".hexToColor(): "skyBlue",
      Colors.blue.toHex().hexToColor(): "blue",
      Colors.blueAccent.toHex().hexToColor(): "blueAccent",
      "#0000FF".hexToColor(): "brightBlue",
      "#000080".hexToColor(): "navyBlue",
      Colors.indigo.toHex().hexToColor(): "indigo",
      Colors.indigoAccent.toHex().hexToColor(): "indigoAccent",
      "#4B0082".hexToColor(): "indigo",
      "#483D8B".hexToColor(): "darkSlateBlue",
      Colors.purple.toHex().hexToColor(): "purple",
      Colors.purpleAccent.toHex().hexToColor(): "purpleAccent",
      "#800080".hexToColor(): "purple",
      "#9370DB".hexToColor(): "mediumPurple",
      Colors.deepPurple.toHex().hexToColor(): "deepPurple",
      Colors.deepPurpleAccent.toHex().hexToColor(): "deepPurpleAccent",
      "#8B008B".hexToColor(): "darkMagenta",
      "#9400D3".hexToColor(): "darkViolet",
      Colors.blueGrey.toHex().hexToColor(): "blueGrey",
      Colors.grey.toHex().hexToColor(): "grey",
      "#808080".hexToColor(): "grey",
      "#A9A9A9".hexToColor(): "darkGrey",
      Colors.brown.toHex().hexToColor(): "brown",
      "#A52A2A".hexToColor(): "brown",
      "#FF4500".hexToColor(): "orangeRed",
      "#8B4513".hexToColor(): "saddleBrown",
      "#FFA07A".hexToColor(): "lightSalmon",
      "#FFA07A".hexToColor(): "salmonPink",
      "#FF69B4".hexToColor(): "hotPink",
      "#FF1493".hexToColor(): "deepPink",
      "#C71585".hexToColor(): "mediumVioletRed",
      "#DB7093".hexToColor(): "paleVioletRed",
      "#FF00FF".hexToColor(): "fuchsia",
      "#FF00FF".hexToColor(): "magenta",
      "#8A2BE2".hexToColor(): "blueViolet",
      "#9932CC".hexToColor(): "darkOrchid",
      "#4D455D".hexToColor(): "darkGrayishPurple",
      "#804674".hexToColor(): "darkPurple",
      "#183A1D".hexToColor(): "darkGreen",
      "#00425A".hexToColor(): "darkBlue",
      "#BFDB38".hexToColor(): "greenYellow",
      "#4E6C50".hexToColor(): "darkOliveGreen",
      "#579BB1".hexToColor(): "lightBlue",
      "#181D31".hexToColor(): "darkBlue",
    };

    String getColorName(Color color) {
      return colorNames[color] ?? "unknown";
    }

    final colors = colorNames.keys.toList();
    var colorSchemeSeed = ref.watch(colorSchemeSeedProvider);

    return DropdownButton<Color>(
      icon: const SizedBox.shrink(),
      borderRadius: BorderRadius.circular(10),
      value: colorSchemeSeed,
      onChanged: (color) {
        if (color != null) {
          ref.read(colorSchemeSeedProvider.notifier).update(color);
        }
      },
      underline: const SizedBox.shrink(),
      items: colors
          .map(
            (color) => DropdownMenuItem<Color>(
              value: color,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.5),
                child: Container(
                  height: 40,
                  width: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Center(
                      child: Text(
                        getColorName(color).capitalize(),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: color.computeLuminance() > 0.5
                                  ? Colors.black
                                  : Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.6,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
