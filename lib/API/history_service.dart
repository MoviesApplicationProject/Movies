import 'dart:convert';

import 'package:movies/Model/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {
  static const String key = "history_movies";

  static Future<void> addMovieToHistory(Movie movie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> historyList = prefs.getStringList(key) ?? [];

    historyList.remove(movie);

    historyList.insert(0, jsonEncode(movie.toJson()));

    await prefs.setStringList(key, historyList);
    print("✅ Movie added to history: ${movie.id}");
  }

  static Future<List<Movie>> getHistoryMovies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? historyList = prefs.getStringList(key);

    if (historyList == null || historyList.isEmpty) {
      print("❌ No movies in history!");
      return [];
    }

    print("📌 Retrieved movie JSON list: $historyList");

    try {
      // تحويل JSON إلى كائنات `Movie`
      List<Movie> movies = historyList.map((jsonMovie) {
        return Movie.fromJson(jsonDecode(jsonMovie));
      }).toList();

      print("✅ Loaded movies from history: ${movies.length}");
      return movies;
    } catch (e) {
      print("🚨 Error fetching history movies: $e");
      return [];
    }
  }
}
