import 'package:devsprint/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData themeData = ThemeData(
  // colorScheme: const ColorScheme(
  //   primary: ColorManager.primary,
  //   onPrimary: ColorManager.primary,
  //   secondary: ColorManager.secondary,
  //   onSecondary: ColorManager.secondary,
  //   error: Colors.red,
  //   onError:  Colors.red,
  //   //! i don't know yet start
  //   surface: Colors.black,
  //   onSurface: Colors.black,
  //   // ! i don't know yet end
    
  //   brightness: Brightness.light,
  //   background: ColorManager.thirdColor,
  //       onBackground: ColorManager.thirdColor
  //   ) 
);

AppBarTheme appBarTheme =
    const AppBarTheme(backgroundColor: Colors.white, elevation: 0);

TextTheme textThemeCustom = TextTheme(
  displayLarge: TextStyle(
      color: ColorManager.secondary,
      fontFamily: 'Inter',
      fontSize: 93.sp,
      fontWeight: FontWeight.w900,
      letterSpacing: -1.5),
  displayMedium: TextStyle(
      color: ColorManager.secondary,
      fontFamily: 'Inter',
      fontSize: 58.sp,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5),
  displaySmall: TextStyle(
      color: ColorManager.secondary,
      fontFamily: 'Inter',
      fontSize: 47.sp,
      fontWeight: FontWeight.w400),
  headlineLarge: TextStyle(
      fontFamily: 'Inter',
      color: ColorManager.secondary,
      fontSize: 33.sp,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.25),
  headlineMedium: TextStyle(
      color: ColorManager.secondary,
      fontFamily: 'Inter',
      fontSize: 23.sp,
      fontWeight: FontWeight.w400),
  headlineSmall: TextStyle(
      fontFamily: 'Inter',
      fontSize: 19.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15),
  titleLarge: TextStyle(
      color: ColorManager.secondary,
      fontFamily: 'Inter',
      fontSize: 18.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15),
  titleMedium: TextStyle(
      color: ColorManager.secondary,
      fontFamily: 'Inter',
      fontSize: 15.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1),
  bodyLarge: TextStyle(
      color: ColorManager.secondary,
      fontFamily: 'Inter',
      fontSize: 28.sp,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5),
  bodyMedium: TextStyle(
    color: ColorManager.secondary,
    fontFamily: 'Inter',
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
  ),
  bodySmall: TextStyle(
      color: ColorManager.secondary,
      fontFamily: 'Inter',
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.25),
  labelLarge: TextStyle(
      color: ColorManager.secondary,
      fontFamily: 'Inter',
      fontSize: 14.sp,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal),
  labelMedium: TextStyle(
    color: ColorManager.secondary,
    fontFamily: 'Inter',
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  ),
  labelSmall: TextStyle(
      color: ColorManager.secondary,
      fontFamily: 'merriweather',
      fontSize: 10.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5),
);

