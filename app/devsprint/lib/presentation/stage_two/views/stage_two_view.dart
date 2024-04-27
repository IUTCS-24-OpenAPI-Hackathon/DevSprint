import 'package:devsprint/presentation/stage_two/models/properties_model.dart';
import 'package:devsprint/presentation/stage_two/models/search_by_others_model.dart';
import 'package:devsprint/presentation/stage_two/views/map_view.dart';
import 'package:devsprint/services/api/api_services.dart';
import 'package:devsprint/services/location/location.dart';
import 'package:devsprint/services/location/location_state.dart';
import 'package:devsprint/theme/app_theme.dart';
import 'package:devsprint/widgets/build_btn.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StageTwoView extends StatefulWidget {
  const StageTwoView({Key? key}) : super(key: key);

  @override
  State<StageTwoView> createState() => _StageTwoViewState();
}

class _StageTwoViewState extends State<StageTwoView> {
  final _locationController = TextEditingController();
  LocationState? _userLocation;
  List<String> _suggestions = [];

  List<Coordinates>? _coordinates;
  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    // Replace with your actual logic to fetch locations
    // This is a placeholder for demonstration
    _suggestions = [
      "New York City, USA",
      "London, UK",
      "Tokyo, Japan",
      "Paris, France",
      "Berlin, Germany",
    ];

    _getLocation();

  }


  _getLocation()async{
      LocationState _state = await LocationRepository().getLocation();
      setState(() {
        _userLocation = _state;
      });
  }

  updateIsLoading(){
    setState(() {
      isLoading = !isLoading;
    });
  }

Response? response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location Search"),
      ),
      body: Padding(
        padding: _coordinates == null? EdgeInsets.all(20.w): EdgeInsets.all(0),
        child: 
        _coordinates == null
          ? _buildGetDetails()
          : MapView(
            name: _locationController.text,
            codList: _coordinates!,
            
          ),
             ),
 
    ); }


_buildGetDetails(){ 
  return Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [

          // Text("Response: "+response.toString(), style: textThemeCustom.labelLarge),
          _buildTextField(),
          SizedBox(height: 20.h),
          BuildBtn(
            onPressed: 
            isLoading? (){}
            : () async{

              updateIsLoading();
              Response? _response = await searchByOthers(locationName: _locationController.text, lat: _userLocation!.position!.latitude, long: _userLocation!.position!.longitude);             
              // SearchByOthersModel _model = SearchByOthersModel.fromJson(_response!.data);
                

                List<Coordinates> cod = [];


                for(int i=0; i< _response!.data['data'][0]['properties'].length; i++){
                  Coordinates _cod = propertiesModel.fromJson( _response!.data['data'][0]['properties']).coordinates;
                  cod.add(_cod);
                }

                

              setState(() {
                _coordinates = cod;
              });

              updateIsLoading();  

            },
            isLoading: isLoading,
            title: "Search", height: 45.h, width: double.maxFinite)
        ],
            );
}



_buildTextField() {
    return  Autocomplete<String>(
    
  fieldViewBuilder: (context, controller, focusNode, onSubmitted) =>
    TextField(
      controller: controller,
      focusNode: focusNode,
      style: TextStyle(color: Colors.black),
      decoration: const InputDecoration(
        labelText: "Search Location",
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        _locationController.text = value;
      },
    ),
  optionsBuilder: (TextEditingValue textEditingValue) {
    if (textEditingValue.text.isEmpty) {
      return const Iterable<String>.empty();
    }
    return _suggestions.where((String suggestion) =>
        suggestion.toLowerCase().contains(textEditingValue.text.toLowerCase()));
  },
  optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
    return Material(
      elevation: 4.0,
      child: Container(
        color: Colors.white, // Set the background color of the dropdown
        child: ListView.builder(
          itemCount: options.length,
          itemBuilder: (BuildContext context, int index) {
            final String option = options.elementAt(index);
            return GestureDetector(
              onTap: () {
                onSelected(option);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  option,
                  style: TextStyle(
                    color: Colors.blue, // Set the color of the suggestion text
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  },
  onSelected: (String selection) {
    setState(() {
      _locationController.text = selection;
    });
  },
);
  }
}
