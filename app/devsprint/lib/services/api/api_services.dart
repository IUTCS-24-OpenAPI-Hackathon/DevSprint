import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

// Assuming you have a Dio instance

Future<Response> searchMapbox(String query, String category) async {
  final dio = Dio();
  String accessToken =
      'pk.eyJ1Ijoic2VhcmNoLW1hY2hpbmUtdXNlci0xIiwiYSI6ImNrNnJ6bDdzdzA5cnAza3F4aTVwcWxqdWEifQ.RFF7CVFKrUsZVrJsFzhRvQ'; // Replace with your actual access token

  try {
    final response = await dio.get(
      'https://api.mapbox.com/search/searchbox/v1/list/category',
      queryParameters: {
        'access_token': accessToken,
      },
    );

    if (response.statusCode == 200) {
      // Handle successful response
      return response;
    } else {
      // Handle API errors (non-200 status codes)
      throw Exception('API error: ${response.statusCode}');
    }
  } on DioException catch (error) {
    // Handle network or other Dio-related errors
    if (error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      throw Exception('Network timeout');
    } else {
      rethrow; // Rethrow other errors for further handling
    }
  } catch (error) {
    // Handle unexpected errors
    throw Exception('An error occurred: $error');
  }
}

Future<Response?> searchAttractionPlaces(
    {required String canonicalId,
    required String long,
    required String lat}) async {
  final dio = Dio();

  try {
    final response = await dio
        .get('https://devsprint-iut.whitedesert-62c03125.australiaeast.azurecontainerapps.io/api/v1/fetch-by-radius/', data: {
      "radious_km": 10000,
      "canonical_id": "services",
      "longitude": -122.084,
      "latitude": 37.4219983
    });
    debugPrint(response.data.toString());
    return response;
  } catch (error) {
    debugPrint(error.toString());
  }

}



Future<Response?> searchByOthers({required String locationName, required double long, required double lat}) async {
  final dio = Dio();


  try {
    // final latLong = await getLatLongFromAddress(address: locationName);

    // debugPrint(latLong.toString());

    final response = await dio
        .get('https://devsprint-iut.whitedesert-62c03125.australiaeast.azurecontainerapps.io/api/v1/fetch-by-others/', data: {
          "limit": 1,
          "radious_km": 90,
          "search_location_name": locationName,
          "longitude": long,
          "latitude": lat
    });
     
    // debugPrint(response.toString());
    debugPrint("\n\n\n");

    return response;
  } catch (error) {
    debugPrint(error.toString());
  }

}


Future<Map?> getLatLongFromAddress({required String address}) async {

  final dio = Dio();

  try {
     // API endpoint
      String url = 'https://geocode.maps.co/search?q=${address.toString()}&api_key=65dc1f5e2a4ec260001640ome36909c';
      
      // Make GET request
      Response response = await dio.get(url);

      // debugPrint(response.data.toString());

    if (response.statusCode == 200) {
      final data = response.data;

      // print(data);
      return {'lat': data[0]['lat'], 'long': data[0]['lon']};
    } else {
      // Handle API errors
      print('API request failed with status code: ${response.statusCode}');
    }
  } catch (e) {
    // Handle exceptions
    print('Exception occurred: $e');
  }



}



