// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:jelly/theme/app_theme.dart';
// import 'package:jelly/theme/color_manager.dart';

// class BuildTitleText extends StatelessWidget {
//   BuildTitleText({super.key, required this.text, required this.size});

//   String text;
//   double size;

//   @override
//   Widget build(BuildContext context) {
//     return Text(text.toUpperCase(), style: textThemeCustom.headlineLarge?.copyWith(
//     color: ColorManager.primaryTextColor,
//     fontSize: size.sp,
//     shadows: [
//       Shadow(
//         offset: Offset(-1.5, -1.5),
//         color: ColorManager.strokeColor,
//       ),
//       Shadow(
//         offset: Offset(1.5, -1.5),
//         color: ColorManager.strokeColor,
//       ),
//       Shadow(
//         offset: Offset(1.5, 1.5),
//         color: ColorManager.strokeColor,
//       ),
//       Shadow(
//         offset: Offset(-1.5, 1.5),
//         color: ColorManager.strokeColor,
//       ),
//     ],
//   ));
// }
//   }