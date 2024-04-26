import 'package:devsprint/presentation/stage_one/views/data_view.dart';
import 'package:devsprint/services/api/api_services.dart';
import 'package:devsprint/services/api/category_selection/category_model.dart';
import 'package:devsprint/theme/app_theme.dart';
import 'package:devsprint/theme/color_manager.dart';
import 'package:devsprint/widgets/build_loading_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class StageOneView extends StatefulWidget {
  const StageOneView({super.key});

  @override
  State<StageOneView> createState() => _StageOneViewState();
}

class _StageOneViewState extends State<StageOneView> {
  CatagoryModel? model;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    Response _response = await searchMapbox('restaurants', 'food');

    setState(() {
      model = CatagoryModel.fromJson(_response.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //     title: Text("Select Category"),
        // // backgroundColor: titleBgColor,
        // centerTitle: true,
      ),
      body: SafeArea(child: model != null ? _buildBody() : const BuildLoadingWidget()),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Text("Select Category", style: textThemeCustom.headlineMedium),
            SizedBox(height: 20.h),
            Column(
                children: List.generate(model!.listItems!.length, (index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return LocationDataView(
                      canonicalId: model!.listItems![index].canonicalId!,
                    );
                  }));
                
                },
                child: Card(
                  child: ListTile(
                    title: Text(model!.listItems![index].name!),
                    subtitle: Text(model!.listItems![index].canonicalId!),
                  ),
                ),
              );
            })),
          ],
        ),
      ),
    );
  }


}
