// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class BuildBtn extends StatelessWidget {
//   BuildBtn({super.key, required this.iconPath, this.onPressed,  this.pageName, required this.height, required this.width});

//   String iconPath;
//   Widget? pageName;
//   double height;
//   double width;
//   Function()? onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return Bounce(
//       onPressed: () {
        
//         if(pageName != null){
//           Navigator.push(context, MaterialPageRoute(builder: (_) => pageName!));
//         }else if(onPressed != null){
//           onPressed!();
//         }
        
//       },
//       duration: const Duration(milliseconds: 300),
//       child: Container(
//         height: height.w,
//         width: width.w,
//         decoration:
//             BoxDecoration(image: DecorationImage(image: AssetImage(iconPath), fit: BoxFit.contain)),
//       ),
//     );
//   }
//   }