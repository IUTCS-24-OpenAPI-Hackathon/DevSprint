import 'package:flutter/material.dart';

class ColorManager {
  static const Color primary = Color(0xffffa600);
  static const Color secondary = Color(0xff00a2ea);
  static const Color secondaryLight = Color.fromARGB(255, 130, 187, 211);
  static const Color thirdColor = Color(0xfff7dfc2);
  static const Color thirdColorDark = Color.fromARGB(255, 243, 192, 129);
  static Color transparent = Colors.white.withOpacity(0.5);
  static const Color primaryTextColor = Color(0xff37FE33);
  static const Color strokeColor = Color(0xff000000);
  static const Color errorColor = Colors.red;
  static const bgColor = Color.fromARGB(255, 254, 237, 245);
  static const textColor = Color(0xff8E761A);

  static List<CustomGradientColor> gradientColor = [
    CustomGradientColor(Color(0xffff6033), Color(0xfff31189)),
    CustomGradientColor(Color(0xfffeeaff), Color(0xffffc6f9))
  ];
}

class CustomGradientColor {
  Color first;
  Color second;
  CustomGradientColor(this.first, this.second);
}

const bkashColor = Color(0xFFf52e77);
