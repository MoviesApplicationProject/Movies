import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/get_profile.dart';

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
        print('Failed to load user profile: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }
}
