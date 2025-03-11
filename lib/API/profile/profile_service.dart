import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/Model/get_profile.dart';

class GetUserProfile {
  String baseUrl;

  GetUserProfile({required this.baseUrl});

  Future<GetUserProfileData?> fetchUserProfile(String token) async {
    final url = Uri.parse('$baseUrl/profile');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return GetUserProfileData.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}