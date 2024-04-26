import 'package:devsprint/presentation/home/views/data_view.dart';
import 'package:devsprint/services/api/category_selection/api_services.dart';
import 'package:devsprint/services/api/category_selection/category_model.dart';
import 'package:devsprint/theme/app_theme.dart';
import 'package:devsprint/theme/color_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
      body: SafeArea(child: model != null ? _buildBody() : _buildGetData()),
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
                      category: model!.listItems![index].name!,
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

  _buildGetData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: LoadingAnimationWidget.horizontalRotatingDots(
            color: ColorManager.secondary,
            size: 80.w,
          ),
        ),
      ],
    );
  }
}
