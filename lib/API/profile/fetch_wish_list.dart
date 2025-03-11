import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/Model/fav_movies.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchWishList {
  static const String baseUrl = 'https://route-movie-apis.vercel.app';

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<List<FavoriteMovie>> fetchFavorites() async {
    final url = Uri.parse('$baseUrl/favorites/all');
    final token = await getToken();

    if (token == null) {
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
        List<FavoriteMovie> favoriteMovies = (data['data'] as List)
            .map((movieJson) => FavoriteMovie.fromJson(movieJson))
            .toList()
            .reversed
            .toList();

        return favoriteMovies;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<int> getFavoriteCount() async {
    final url = Uri.parse('$baseUrl/favorites/all');
    final token = await getToken();

    if (token == null) {
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

        return favoriteMovies.length;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }
}
