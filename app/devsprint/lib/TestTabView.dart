import 'package:devsprint/services/api/api_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TestTabView extends StatelessWidget {
  const TestTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(onPressed: ()async{

            // Response? response =   await searchByOthers();

          }, child: Text("Click me")),
        ],
      ),
    );
  }
}