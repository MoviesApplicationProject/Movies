import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/Model/movie.dart';

Future<List<Movie>> fetchMovies() async {
  final response =
      await http.get(Uri.parse('https://yts.mx/api/v2/list_movies.json'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List moviesJson = data['data']['movies'];

    return moviesJson.map((movie) => Movie.fromJson(movie)).toList();
  } else {
    throw Exception('Failed to load movies');
  }
}
