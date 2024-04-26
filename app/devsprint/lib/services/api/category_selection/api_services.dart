import 'package:dio/dio.dart';

// Assuming you have a Dio instance

Future<Response> searchMapbox(String query, String category) async {
  final dio = Dio();
  String accessToken = 'pk.eyJ1Ijoic2VhcmNoLW1hY2hpbmUtdXNlci0xIiwiYSI6ImNrNnJ6bDdzdzA5cnAza3F4aTVwcWxqdWEifQ.RFF7CVFKrUsZVrJsFzhRvQ'; // Replace with your actual access token

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
