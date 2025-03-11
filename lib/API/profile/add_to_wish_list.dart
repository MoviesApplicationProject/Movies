import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/ui/shared_widgets/utils/dialog_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishList {
  static const String baseUrl = 'https://route-movie-apis.vercel.app';

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<void> addToFavorites({
    required BuildContext context,
    required int movieId,
    required String movieName,
    required double movieRating,
    required String imageURL,
    required String releaseYear,
  }) async {
    final url = Uri.parse('$baseUrl/favorites/add');

    final token = await getToken();

    if (token == null) {
      return;
    }
    try {
      showLoading(context);
      final client = http.Client();
      final response = await client.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'movieId': movieId,
          'name': movieName,
          'rating': movieRating,
          'imageURL': imageURL,
          'year': releaseYear,
        }),
      );
      hideLoading(context);
      if (response.statusCode == 308 ||
          response.statusCode == 301 ||
          response.statusCode == 302) {
        final redirectUrl = response.headers['location'];
      } else if (response.statusCode == 201) {
        showMessage(context, "Movie added to Wish list successfully!",
            posButtonTitle: "ok");
      }else if (response.statusCode == 409) {
        showMessage(context, "Movie already added to Wish List",
            posButtonTitle: "ok");
      } else {
        showMessage(context, response.statusCode.toString(),
            posButtonTitle: "ok");
      }
    } catch (e) {
      hideLoading(context);
      showMessage(context, e.toString(), posButtonTitle: "Ok");
    }
  }
}
