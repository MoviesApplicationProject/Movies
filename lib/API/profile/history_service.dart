import 'dart:convert';

import 'package:movies/Model/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {
  static Future<void> addMovieToHistory(String userId, Movie movie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = "history_movies_$userId";

    List<String> historyList = prefs.getStringList(key) ?? [];

    // ✅ التأكد من أن الفيلم غير موجود بالفعل في القائمة
    bool exists = historyList.any((m) {
      Map<String, dynamic> decodedMovie = jsonDecode(m);
      return decodedMovie["id"] == movie.id;
    });

    if (!exists) {
      historyList.insert(
          0, jsonEncode(movie.toJson())); // إضافة الفيلم في المقدمة
      await prefs.setStringList(key, historyList);
      await prefs.reload(); // تحديث SharedPreferences
      print("✅ Movie added: ${movie.title}");
    } else {
      print("⚠️ Movie already exists in history: ${movie.title}");
    }

    print("🔍 Updated history list: ${historyList.length} movies");
  }

  static Future<List<Movie>> getHistoryMovies(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedMovies =
        prefs.getStringList("history_movies_$userId") ?? [];

    print("🔍 Raw stored movies: $storedMovies");

    List<Movie> movies = storedMovies.map((movieString) {
      Map<String, dynamic> movieMap = jsonDecode(movieString);
      return Movie.fromJson(movieMap);
    }).toList();

    print("✅ Parsed movies: ${movies.map((m) => m.title).toList()}");
    return movies;
  }
}
