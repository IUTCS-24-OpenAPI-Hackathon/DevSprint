import 'package:devsprint/services/api/api_services.dart';
import 'package:devsprint/services/location/location.dart';
import 'package:devsprint/services/location/location_state.dart';
import 'package:devsprint/theme/app_theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LocationDataView extends StatefulWidget {
  LocationDataView({super.key, required this.category});

  String category;

  @override
  State<LocationDataView> createState() => _LocationDataViewState();
}

class _LocationDataViewState extends State<LocationDataView> {
  LocationState? _locationState;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: _buildChooseLocation(),
        ),
      ),
    );
  }

  _buildBody() {
    return Column(
      children: [],
    );
  }

  _buildChooseLocation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () async {
              if (_locationState != null) {
                Response _response = await searchAttractionPlaces(
                  category: widget.category,
                  long: _locationState!.position!.longitude.toString(),
                  lat: _locationState!.position!.latitude.toString(),
                );

                debugPrint(_response.data.toString());
              }
              {
                LocationState state = await LocationRepository().getLocation();
                setState(() {
                  _locationState = state;
                });
                if (state.position == null) {
                  Fluttertoast.showToast(msg: "Location not found");
                } else {
                  Response _response = await searchAttractionPlaces(
                    category: widget.category,
                    long: state.position!.longitude.toString(),
                    lat: state.position!.latitude.toString(),
                  );

                  debugPrint(_response.data.toString());
                }
              }
            },
            child: Text("Your Location")),
        ElevatedButton(onPressed: () {}, child: Text("Custom Location")),
      ],
    );
  }
}
