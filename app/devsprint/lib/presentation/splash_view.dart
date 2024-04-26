import 'package:devsprint/presentation/home/views/home_view.dart';
import 'package:devsprint/theme/app_theme.dart';
import 'package:devsprint/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {


 @override
  void initState() { 
    super.initState();
    splashScreen();
  }


  splashScreen()async{
    await Future.delayed(const Duration(seconds: 3));
    
    if(context.mounted){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeView()));
    }
  }

  @override
  Widget build(BuildContext context) {

    // FirebaseAuth.instance.signOut();
    
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          _buildSplashScreen()
        
        ],
      ),
    ));
  }

  _buildSplashScreen() {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: const BoxDecoration(color: ColorManager.thirdColor),
      child: Stack(children: [
        Align(
            alignment: Alignment.center,
            child: Text("DevSprint", style: textThemeCustom.headlineLarge)),
                
                Positioned(
                  bottom: 30.h,
                  left: 0,
                  right: 0,
                  child: Center(child: Text("IUT 11'th National CSE Fest", style: textThemeCustom.labelSmall?.copyWith(color: Colors.black),))),
        Positioned(
            bottom: 70.h,
            left: 0,
            right: 0,
            child: Center(
              child: LoadingAnimationWidget.horizontalRotatingDots(
                color: ColorManager.secondary,
                size: 80.w,
              ),
            ))
      ]),
    );
  }
}