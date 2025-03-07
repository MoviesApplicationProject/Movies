import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/Model/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchWatchList {
  static const String baseUrl = 'https://route-movie-apis.vercel.app';

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<List<Movie>> fetchFavorites() async {
    final url = Uri.parse('$baseUrl/favorites/all');
    final token = await getToken();

    if (token == null) {
      print('User is not logged in. Token is missing.');
      return [];
    }

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('Fetched favorite movies successfully!');

        // تحويل JSON إلى كائنات Movie
        return (data['data'] as List)
            .map((movieJson) => Movie.fromJson(movieJson))
            .toList();
      } else {
        print('Failed to fetch favorite movies: ${response.statusCode}');
        print('Response body: ${response.body}');
        return [];
      }
    } catch (e) {
      print('An error occurred: $e');
      return [];
    }
  }
}
