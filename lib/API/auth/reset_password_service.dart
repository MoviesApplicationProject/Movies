import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordService {
  static const String baseUrl = 'https://route-movie-apis.vercel.app';

  static Future<String?> resetPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final token = await _getToken();

    if (token == null) {
      return null;
    }

    final url = Uri.parse('$baseUrl/auth/reset-password');

    try {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['message'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
