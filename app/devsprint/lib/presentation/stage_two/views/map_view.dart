import 'package:devsprint/services/location/location.dart';
import 'package:devsprint/services/location/location_state.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationSearch extends StatefulWidget {
  const LocationSearch({Key? key}) : super(key: key);

  @override
  State<LocationSearch> createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  GoogleMapController? _mapController;

  // Replace with your actual Google Maps API key
  final String _apiKey = "AIzaSyBKivueJv_YehqxAwpsrOcMzGGKPS15grE";



  LocationState? _userLocation;


  @override
  void initState() {
    super.initState();
    _getLocation();
  }


  _getLocation()async{
    LocationState state = await LocationRepository().getLocation();

    setState(() {
      _userLocation = state;
    });

  }




Future<List<Placemark>> _searchLocation(String searchTerm) async {
  final url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$searchTerm&key=$_apiKey";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final results = data["results"] as List;

    // return results.map((result) {
    //   final geometry = result["geometry"];
    //   final location = geometry["location"];

    //   return Placemark(
    //     name: result["name"],
    //     latitude: location["lat"],
    //     longitude: location["lng"],
    //   );
      
    // }).toList();

          final geometry = results[0]["geometry"];
      final location = geometry["location"];

    return await placemarkFromCoordinates(location["lat"], location["lng"]);

  } else {
    // Handle API errors
    return [];
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location Search"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _countryController,
                    decoration: const InputDecoration(labelText: "Country"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(labelText: "City, Division, etc."),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => _searchLocation(
                "${_searchController.text}, ${_countryController.text}"),
            child: const Text("Search"),
          ),
          Expanded(
            child: GoogleMap(
              markers: 
                {
                  Marker(
                 
                 markerId: const MarkerId("Sydney"),
            position: LatLng(-33.86, 151.20),
            infoWindow: InfoWindow(
               title: "Sydney",
               snippet: "Capital of New South Wales",
            ),
                   )
                }
              ,
              initialCameraPosition: CameraPosition(target: 
              _userLocation == null ? const LatLng(0, 0) :
              LatLng(_userLocation!.position!.longitude, _userLocation!.position!.latitude), zoom: 2),
              onMapCreated: (controller) => _mapController = controller,
            ),
          ),
        ],
      ),
    );
  }
}
