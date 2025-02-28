import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/Model/movie.dart';

class Genres {
  static const String baseUrl = 'https://yts.mx/api/v2/list_movies.json';

  Future<List<Movie>> fetchMovies({String genre = ''}) async {
    final url = Uri.parse('$baseUrl?genre=$genre&limit=20');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<dynamic> movieJsonList = jsonResponse['data']['movies'] ?? [];

      return movieJsonList.map((movieJson) => Movie.fromJson(movieJson)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }


  Future<List<String>> fetchGenres() async {
    final url = Uri.parse('$baseUrl?limit=50');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<dynamic> movieJsonList = jsonResponse['data']['movies'] ?? [];

      List<Movie> movies = movieJsonList.map((movieJson) => Movie.fromJson(movieJson)).toList();

      Set<String> genres = {};
      for (var movie in movies) {
        if (movie.genres.isNotEmpty) {
          genres.addAll(movie.genres);
        }
      }

      return genres.toList();
    } else {
      throw Exception('Failed to load genres');
    }
  }
}
