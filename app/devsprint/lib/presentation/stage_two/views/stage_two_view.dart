import 'package:devsprint/widgets/build_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StageTwoView extends StatefulWidget {
  const StageTwoView({Key? key}) : super(key: key);

  @override
  State<StageTwoView> createState() => _StageTwoViewState();
}

class _StageTwoViewState extends State<StageTwoView> {
  final TextEditingController _locationController = TextEditingController();
  List<String> _suggestions = [];

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location Search"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTextField(),
          SizedBox(height: 20.h),
          BuildBtn(title: "Search", height: 45.h, width: double.maxFinite)
        ],
            ),
      ),
 
    ); }


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
      onChanged: (value) {},
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
