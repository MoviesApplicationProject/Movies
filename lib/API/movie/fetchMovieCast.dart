import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/Model/cast_dm.dart';

Future<List<CastDM>> fetchMovieCast(int movieId) async {
  final url = Uri.parse(
      'https://yts.mx/api/v2/movie_details.json?movie_id=$movieId&with_images=true&with_cast=true');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final cast = data['data']['movie']['cast'] as List<dynamic>;
    return cast.map((member) => CastDM.fromJson(member)).toList();
  } else {
    throw Exception('Failed to load movie cast');
  }
}

