import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<CastMember>> fetchMovieCast(int movieId) async {
  final url = Uri.parse(
      'https://yts.mx/api/v2/movie_details.json?movie_id=$movieId&with_images=true&with_cast=true');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final cast = data['data']['movie']['cast'] as List<dynamic>;
    return cast.map((member) => CastMember.fromJson(member)).toList();
  } else {
    throw Exception('Failed to load movie cast');
  }
}

class CastMember {
  final String name;
  final String characterName;
  final String urlSmallImage;

  CastMember({
    required this.name,
    required this.characterName,
    required this.urlSmallImage,
  });

  factory CastMember.fromJson(Map<String, dynamic> json) {
    return CastMember(
      name: json['name'] ?? '',
      characterName: json['character_name'] ?? '',
      urlSmallImage: json['url_small_image'] ?? '',
    );
  }
}
