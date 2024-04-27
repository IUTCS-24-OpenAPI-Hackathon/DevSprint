import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  MapView({super.key, required this.long, required this.lat, required this.name});

  double long;
  double lat;
  String name;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {

  GoogleMapController? mapController;
  Set<Marker> markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      markers.add(Marker(
        markerId: MarkerId('marker1'),
        position: LatLng(37.7749, -122.4194),
        infoWindow: InfoWindow(title: widget.name),
      ));
    });
  }


  @override
  Widget build(BuildContext context) {

    debugPrint("Name: ${widget.name}");
    debugPrint("Lat: ${widget.lat}");
    debugPrint("Long: ${widget.long}");

    return GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.lat, widget.long), // San Francisco coordinates
          zoom: 12,
        ),
        onMapCreated: _onMapCreated,
        markers: markers,
        );
  }
}