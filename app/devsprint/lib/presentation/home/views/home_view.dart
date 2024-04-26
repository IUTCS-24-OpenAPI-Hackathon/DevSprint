import 'package:devsprint/presentation/stage_one/views/data_view.dart';
import 'package:devsprint/presentation/stage_one/views/stage_one_view.dart';
import 'package:devsprint/TestTabView.dart';
import 'package:devsprint/presentation/stage_two/views/map_view.dart';
import 'package:devsprint/presentation/stage_two/views/stage_two_view.dart';
import 'package:devsprint/services/api/api_services.dart';
import 'package:devsprint/services/api/category_selection/category_model.dart';
import 'package:devsprint/theme/app_theme.dart';
import 'package:devsprint/theme/color_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //       title: Text("Select Category"),
      //   // backgroundColor: titleBgColor,
      //   centerTitle: true,
      // ),
      body: SafeArea(child: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStageButton(stage: 'Stage One', widget: StageOneView()),
            SizedBox(height: 10.h),
            _buildStageButton(stage: 'Stage Two', widget: StageTwoView()),
            SizedBox(height: 10.h),
            _buildStageButton(stage: 'Stage Three', widget: TestTabView()),
            SizedBox(height: 10.h),
          ],
        ),
      )),
    );
  }

_buildStageButton({required String stage, required Widget widget}){
  return ElevatedButton(onPressed: (){
    Navigator.push(context, MaterialPageRoute(builder: (_) => widget));
  }, child: Text(stage, style: textThemeCustom.labelLarge));
}


}
