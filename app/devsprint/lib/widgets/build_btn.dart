import 'package:devsprint/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildBtn extends StatelessWidget {
  BuildBtn({super.key, required this.title, this.textColor = Colors.white, this.color = Colors.black, this.iconPath, this.onPressed,  this.pageName, required this.height, required this.width});

  Icon? iconPath;
  Widget? pageName;
  String title;
  Color? color;
  Color? textColor;
  double height;
  double width;
  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
        if(pageName != null){
          Navigator.push(context, MaterialPageRoute(builder: (_) => pageName!));
        }else if(onPressed != null){
          onPressed!();
        }
        
      },
      child: Container(
        height: height.w,
        width: width.w,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10.w), color: color),
        child: Center(
          child: Text(title,style: textThemeCustom.labelLarge?.copyWith(color: textColor)),
      )),
    );
  }
  }