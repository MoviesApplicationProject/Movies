import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/Model/fav_movies.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchWishList {
  static const String baseUrl = 'https://route-movie-apis.vercel.app';

  // دالة لجلب التوكن
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // دالة لجلب قائمة الأفلام المفضلة
  static Future<List<FavoriteMovie>> fetchFavorites() async {
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

        List<FavoriteMovie> favoriteMovies = (data['data'] as List)
            .map((movieJson) => FavoriteMovie.fromJson(movieJson))
            .toList();

        print('Number of favorite movies: ${favoriteMovies.length}');
        return favoriteMovies;
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

  // دالة لجلب عدد الأفلام في قائمة المفضلة فقط
  static Future<int> getFavoriteCount() async {
    final url = Uri.parse('$baseUrl/favorites/all');
    final token = await getToken();

    if (token == null) {
      print('User is not logged in. Token is missing.');
      return 0;
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

        List<FavoriteMovie> favoriteMovies = (data['data'] as List)
            .map((movieJson) => FavoriteMovie.fromJson(movieJson))
            .toList();

        return favoriteMovies.length; // إرجاع عدد الأفلام
      } else {
        print('Failed to fetch favorite movies: ${response.statusCode}');
        return 0;
      }
    } catch (e) {
      print('An error occurred: $e');
      return 0;
    }
  }
}
