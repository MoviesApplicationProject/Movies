import 'dart:convert';

import 'package:movies/Model/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {
  static Future<void> addMovieToHistory(String userId, Movie movie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = "history_movies_$userId";

    List<String> historyList = prefs.getStringList(key) ?? [];

    bool exists = historyList.any((m) {
      Map<String, dynamic> decodedMovie = jsonDecode(m);
      return decodedMovie["id"] == movie.id;
    });

    if (!exists) {
      historyList.insert(0, jsonEncode(movie.toJson()));
      await prefs.setStringList(key, historyList);
      await prefs.reload();
    }
  }

  static Future<List<Movie>> getHistoryMovies(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedMovies =
        prefs.getStringList("history_movies_$userId") ?? [];

    List<Movie> movies = storedMovies.map((movieString) {
      Map<String, dynamic> movieMap = jsonDecode(movieString);
      return Movie.fromJson(movieMap);
    }).toList();

    return movies;
  }
}
