import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Model/get_user_profile_data.dart';


class UserProfileService {

  String apiUrl = "https://route-movie-apis.vercel.app/profile";

  // UserProfileService({ required this.apiUrl});

  Future<GetUserProfileData?> fetchUserProfile() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return GetUserProfileData.fromJson(data);
      } else {
        print("Failed to load user profile: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error fetching user profile: $e");
      return null;
    }
  }
}
