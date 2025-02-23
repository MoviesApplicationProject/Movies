import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/Model/movie.dart';

Future<List<Movie>> fetchMovieSuggestions({required int movieId}) async {
  // نستخدم movieId للبحث عن اقتراحات لفيلم معين
  final url = Uri.parse(
      'https://yts.mx/api/v2/movie_suggestions.json?movie_id=$movieId');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    // نفترض أن البيانات تحت المفتاح 'data' ثم 'movies'
    final List suggestionsJson = data['data']['movies'];
    return suggestionsJson.map((json) => Movie.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load movie suggestions');
  }
}
