import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/Model/fav_movies.dart';
import 'package:movies/core/utils/dialog_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoveFromWishList {
  static const String baseUrl = 'https://route-movie-apis.vercel.app';

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<void> removeFromFavorites(int movieId, BuildContext context) async {
    final url = Uri.parse('$baseUrl/favorites/remove/$movieId');
    final token = await getToken();

    if (token == null) {
      print('User is not logged in. Token is missing.');
      return;
    }

    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('Movie removed from favorites: ${data['message']}');

        showMessage(context, "Movie removed from Wish list successfully!",
            posButtonTitle: "ok");
      } else {
        print('Failed to remove movie from favorites: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('An error occurred while removing the movie from favorites: $e');
    }
  }
}
