import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String apiUrl = 'https://route-movie-apis.vercel.app/auth/register';

  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  }) async {
    final Map<String, dynamic> userData = {
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'phone': phone,
      'avatarId': 1,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(userData),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        print('Error: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Connection error: $e');
      return false;
    }
  }
}
