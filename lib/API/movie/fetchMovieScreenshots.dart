import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<String>> fetchMovieScreenshots(int movieId) async {
  final response = await http.get(Uri.parse(
      'https://yts.mx/api/v2/movie_details.json?movie_id=$movieId&with_images=true&with_cast=true'));

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body)['data']['movie'];

    List<String> screenshots = [];
    if (jsonResponse['large_screenshot_image1'] != null) {
      screenshots.add(jsonResponse['large_screenshot_image1']);
    }
    if (jsonResponse['large_screenshot_image2'] != null) {
      screenshots.add(jsonResponse['large_screenshot_image2']);
    }
    if (jsonResponse['large_screenshot_image3'] != null) {
      screenshots.add(jsonResponse['large_screenshot_image3']);
    }

    return screenshots;
  } else {
    throw Exception('Failed to load movie screenshots');
  }
}
