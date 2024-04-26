import 'dart:convert';

import 'package:devsprint/presentation/stage_one/models/user_location_result_model.dart';
import 'package:devsprint/services/api/api_services.dart';
import 'package:devsprint/services/location/location.dart';
import 'package:devsprint/services/location/location_state.dart';
import 'package:devsprint/theme/app_theme.dart';
import 'package:devsprint/widgets/build_loading_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

const titleBgColor = Colors.black;

class LocationDataView extends StatefulWidget {
  LocationDataView({super.key, required this.canonicalId});

  String canonicalId;

  @override
  State<LocationDataView> createState() => _LocationDataViewState();
}

class _LocationDataViewState extends State<LocationDataView> {
  LocationState? _locationState;

  UserLocationResultModel? _locationResultModel;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  _getLocation() async {
    LocationState _state = await LocationRepository().getLocation();
    setState(() {
      _locationState = _state;
    });
  }

  updateIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
        // backgroundColor: titleBgColor,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(20.w),
          child: 
          isLoading
          ? const BuildLoadingWidget()
          : _locationResultModel != null
              ? _buildBody()
              : _buildChooseLocation(),
        ),
      ),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            _locationResultModel!.data!.length,
            (index) {
              return Card(
                margin: EdgeInsets.only(bottom: 40.h),
                elevation: 2,
                // color: Colors.blue,
                child: Column(
                  children: [
                    Container(
                      color: Colors.black,
                      width: double.maxFinite,
                      child: Center(
                          child: Text(
                              "Section: ${_locationResultModel!.data![index].id}",
                              style: textThemeCustom.headlineMedium)),
                    ),
                    _buildLocationWidget(
                        location: _locationResultModel!
                            .data![index].weather.location),
                    SizedBox(height: 10.h),
                    _buildWeatherWidget(
                        weather: _locationResultModel!.data![index].weather),
                    SizedBox(height: 10.h),
                    _buildPropertiesWidget(
                        properties:
                            _locationResultModel!.data![index].properties),
                  ],
                ),
              );
            },
          )),
    );
  }

  _buildChooseLocation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () async {
              updateIsLoading();

              if (_locationState != null) {
                Response? _response = await searchAttractionPlaces(
                  canonicalId: widget.canonicalId,
                  long: _locationState!.position!.longitude.toString(),
                  lat: _locationState!.position!.latitude.toString(),
                );

                debugPrint(_response.toString());

                if (_response != null) {
                  UserLocationResultModel _model =
                      UserLocationResultModel.fromJson(_response.data);
                  setState(() {
                    _locationResultModel = _model;
                  });
                }

                // debugPrint(_locationState!.position!.longitude.toString());
              } else {
                // LocationState state = await LocationRepository().getLocation();
                // setState(() {
                //   _locationState = state;
                // });
                // if (state.position == null) {
                //   Fluttertoast.showToast(msg: "Location not found");
                // } else {
                //   Response? _response = await searchAttractionPlaces(
                //     canonicalId: widget.canonicalId,
                //     long: state.position!.longitude.toString(),
                //     lat: state.position!.latitude.toString(),
                //   );
                 // }

                  debugPrint("Location not found");
               
              }
  
              updateIsLoading();
            },
            child: Text("Your Location")),
        ElevatedButton(onPressed: () {}, child: Text("Custom Location")),
      ],
    );
  }

  _buildLocationWidget({required Location location}) {
    return Container(
      padding: EdgeInsets.all(20.w),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.green[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            width: double.maxFinite,
            child: Center(
                child: Text("Location", style: textThemeCustom.headlineMedium)),
          ),
          Text("Name: ${location.name}", style: textThemeCustom.labelLarge),
          Text("Country: ${location.country}",
              style: textThemeCustom.labelLarge),
          Text("Region: ${location.region}", style: textThemeCustom.labelLarge),
        ],
      ),
    );
  }

  _buildWeatherWidget({required Weather weather}) {
    return Container(
      padding: EdgeInsets.all(20.w),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.green[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            width: double.maxFinite,
            child: Center(
                child: Text("Weather", style: textThemeCustom.headlineMedium)),
          ),

          Text("Condition: ${weather.current.condition}",
              style: textThemeCustom.labelLarge),
          Text("Air Quality: ${weather.current.airQuality}",
              style: textThemeCustom.labelLarge),
          // Text("Region: ${weather.current.}", style: textThemeCustom.labelLarge),
        ],
      ),
    );
  }

  _buildPropertiesWidget({required Properties properties}) {
    return Container(
      padding: EdgeInsets.all(20.w),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.green[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            width: double.maxFinite,
            child: Center(
                child:
                    Text("Properties", style: textThemeCustom.headlineMedium)),
          ),

          Text("Address: ${properties.address}",
              style: textThemeCustom.labelLarge),
          Text("Poi Catagories: ${properties.poiCategory}",
              style: textThemeCustom.labelLarge),
          // Text("Region: ${weather.current.}", style: textThemeCustom.labelLarge),
        ],
      ),
    );
  }
}
