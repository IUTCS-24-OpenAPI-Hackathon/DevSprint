// import 'package:flutter/material.dart';

// class SearchScreen extends StatefulWidget {
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   String _selectedArea = "";

//   Future<void> _geocodeAndSearch(String areaName) async {
//     final address = await Geocoder.local.findPlaces(areaName);
//     if (address.isNotEmpty) {
//       final coordinates = address.first.coordinates;
//       setState(() {
//         _selectedArea = areaName;
//         // Update your search logic here based on coordinates
//       });
//     } else {
//       // Handle cases where the area is not found
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search'),
//       ),
//       body: Column(
//         children: [
//           // Auto-suggestion dropdown (optional)
//           // SearchWidget(
//           //   hintText: "Enter city, district, etc.",
//           //   onChanged: (value) => _geocodeAndSearch(value),
//           // ),
//           TextField(
//             controller: _searchController,
//             decoration: InputDecoration(
//               hintText: "Enter city, district, etc.",
//             ),
//             onChanged: (value) => _geocodeAndSearch(value),
//           ),
//           Text("Selected Area: $_selectedArea"),
//           // Your existing search results UI
//         ],
//       ),
//     );
//   }
// }
