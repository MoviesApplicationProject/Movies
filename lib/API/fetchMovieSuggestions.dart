import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/Model/movie.dart';

Future<List<Movie>> fetchMovieSuggestions({required int movieId}) async {
  final url = 'https://yts.mx/api/v2/movie_suggestions.json?movie_id=$movieId';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    List<dynamic> moviesJson = data['data']['movies'] ?? [];
    return moviesJson.map((json) => Movie.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load related movies: ${response.statusCode}');
  }
}
