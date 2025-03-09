import 'dart:convert';

import 'package:http/http.dart' as http;

Future<int> fetchLikeCount(int movieId) async {
  final url = 'https://yts.mx/api/v2/movie_details.json?movie_id=$movieId';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['movie']['like_count'] ?? 0;
    }
  } catch (e) {
    print("Error fetching like_count for movie $movieId: $e");
  }

  return 0;
}
