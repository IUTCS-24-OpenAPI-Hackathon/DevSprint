
  // _buildIconAndTtile() {
  //   return SizedBox(
  //     width: double.maxFinite,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Icon(Icons.location_on, size: 100.sp, color: Colors.white),
  //         SizedBox(height: 20.h),
  //         Text(
  //           '"DevSprint App" Would like to access your location',
  //           style: TextStyle(fontSize: 20.sp, color: Colors.white),
  //           textAlign: TextAlign.center,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // _buildTakeCustomLocationFromUserWidget() {
  //   return Container(
  //     child: Padding(
  //       padding: EdgeInsets.all(30.w),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           _buildTakeLocationField(),
  //           SizedBox(height: 20.h),
  //           _buildGetDetailsButton(),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // _buildTakeLocationField() {
  //   return TextField(
  //     controller: _textlocationController,
  //     decoration: InputDecoration(
  //         hintText: "Enter Location",
  //         hintStyle: TextStyle(color: bgColor),
  //         border: OutlineInputBorder(borderSide: BorderSide(color: bgColor))),
  //   );
  // }

  // _buildGetDetailsButton() {
  //   return ElevatedButton(
  //     onPressed: () {
  //       if (_textlocationController.text.isEmpty) {
  //         Fluttertoast.showToast(msg: "Please Enter Location");
  //       } else {
  //         _getLocation();
  //       }
  //     },
  //     child: Text("Get Details"),
  //   );
  // }

  // _buildShowLocationWidget() {
  //   return Container(
  //     color: bgColor,
  //     child: Padding(
  //       padding: EdgeInsets.all(30.w),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           SizedBox(height: 20.h),
  //           Text(
  //             "Your Location",
  //             style: TextStyle(fontSize: 20.sp, color: Colors.white),
  //           ),
  //           SizedBox(height: 20.h),
  //           Text(
  //             "Latitude: ${_locationState!.position!.latitude}",
  //             style: TextStyle(fontSize: 20.sp, color: Colors.white),
  //           ),
  //           SizedBox(height: 20.h),
  //           Text(
  //             "Longitude: ${_locationState!.position!.longitude}",
  //             style: TextStyle(fontSize: 20.sp, color: Colors.white),
  //           ),
  //           SizedBox(height: 20.h),
  //         ],
  //       ),
  //     ),
  //   );
  // }