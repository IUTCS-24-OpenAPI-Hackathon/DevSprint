import 'package:devsprint/presentation/stage_one/models/user_location_result_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/properties_model.dart' as pm;

class MapView extends StatefulWidget {
  MapView({super.key, required this.codList, required this.name});

  List<pm.Coordinates> codList;
  
  String name;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  

  GoogleMapController? mapController;

  Set<Marker> markers = {};


  void _onMapCreated(GoogleMapController controller) {
    
    mapController = controller;

    for (var i = 0; i < widget.codList.length; i++) {
      debugPrint("${widget.codList[i].lat} ${widget.codList[i].long}");

      markers.add(Marker(
        
        markerId: MarkerId(widget.codList[i].lat.toString()),
        position: LatLng(widget.codList[i].lat, widget.codList[i].long),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: widget.name),
      ));
    }

    setState(() {}); // Update the state with the modified markers set


  }


  @override
  Widget build(BuildContext context) {

    debugPrint(widget.codList.length.toString());

    return GoogleMap(
      
        initialCameraPosition: CameraPosition(

          target: LatLng(widget.codList[0].lat, widget.codList[0].long), // San Francisco coordinates
          zoom: 12,
        ),
        onMapCreated: (value){
          _onMapCreated(value);
        },
        markers: markers,
        
        );
  }
}