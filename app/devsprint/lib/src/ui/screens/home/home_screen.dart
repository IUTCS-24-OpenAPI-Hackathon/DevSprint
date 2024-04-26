import 'dart:ffi';

import 'package:devsprint/src/services/location/location_repo.dart';
import 'package:devsprint/src/services/location/models/locatin_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

const bgColor = Color(0xff054167);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LocationState? _locationState;

  final _textlocationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  _getLocation() async {
    LocationState lState = await LocationRepository().getLocation();

    if (lState.position == null) {
      // Fluttertoast.showToast(
      //     msg: "Location is not granted, Please Click again");
    } else {
      setState(() {
        _locationState = lState;
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: Scaffold(
        body: SafeArea(
            child: Container(
          color: bgColor,
          width: double.maxFinite,
          child: Stack(
            fit: StackFit.expand,
            children: [
              buildFloatingSearchBar(),
            ],
          ),
        )),
      ),
    );
  }

Widget buildFloatingSearchBar() {
  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  return FloatingSearchBar(
    hint: 'Search...',
    scrollPadding: EdgeInsets.only(top: 16.h, bottom: 56.h),
    transitionDuration: const Duration(milliseconds: 800),
    transitionCurve: Curves.easeInOut,
    physics: const BouncingScrollPhysics(),
    axisAlignment: isPortrait ? 0.0 : -1.0,
    openAxisAlignment: 0.0,
    width: isPortrait ? 600.w : 500.w,
    debounceDelay: const Duration(milliseconds: 500),
    onQueryChanged: (query) {
      // Call your model, bloc, controller here.
    },
    // Specify a custom transition to be used for
    // animating between opened and closed stated.
    transition: CircularFloatingSearchBarTransition(),
    actions: [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: const Icon(Icons.place),
          onPressed: () {},
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ],
    builder: (context, transition) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Colors.white,
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: []
          ),
        ),
      );
    },
  );
}


}