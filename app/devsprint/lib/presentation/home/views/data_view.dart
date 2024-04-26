import 'package:devsprint/services/location/location.dart';
import 'package:devsprint/services/location/location_state.dart';
import 'package:devsprint/theme/app_theme.dart';
import 'package:flutter/material.dart';

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

  _buildBody(){
    return Column();
  }

  _buildChooseLocation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: () {}, child: Text("Your Location")),
        ElevatedButton(onPressed: () {}, child: Text("Custom Location")),
      ],
    );
  }
}
