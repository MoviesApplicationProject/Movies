import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/Model/movie.dart';

class SearchAPI {
  static Future<List<Movie>> fetchMovies(String query) async {
    if (query.isEmpty) {
      return [];
    }

    try {
      final url = 'https://yts.mx/api/v2/list_movies.json?query_term=$query&limit=20';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> movies = data['data']['movies'] ?? [];

        return movies.map((movieMap) => Movie.fromJson(movieMap)).toList();
      } else {
        throw Exception('Failed to fetch movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching movies: $e');
    }
  }
}
