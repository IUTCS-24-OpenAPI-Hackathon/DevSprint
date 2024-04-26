import 'package:devsprint/presentation/home/home_provider.dart';
import 'package:devsprint/presentation/home/views/home_view.dart';
import 'package:devsprint/presentation/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => HomeProvider()),
  ],
  child: DevPrint(),
  ));
}

class DevPrint extends StatefulWidget {
  const DevPrint({super.key});

  @override
  State<DevPrint> createState() => _DevPrintState();
}

class _DevPrintState extends State<DevPrint> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'DevPrint',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: const SplashView(),
    );
  }
}