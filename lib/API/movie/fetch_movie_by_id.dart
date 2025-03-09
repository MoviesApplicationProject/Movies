import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/Model/movie.dart';

Future<Movie> fetchMovieById(int movieId) async {
  final String url =
      "https://yts.mx/api/v2/movie_details.json?movie_id=$movieId";

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final Map<String, dynamic> movieData = jsonData["data"]["movie"];
      return Movie.fromJson(movieData);
    } else {
      throw Exception("Failed to load movie data");
    }
  } catch (error) {
    throw Exception("Error fetching movie: $error");
  }
}
