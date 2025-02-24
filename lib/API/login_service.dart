import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  static const String apiUrl = 'https://route-movie-apis.vercel.app/auth/login';

  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(loginData),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['data'];
      } else {
        return null;
      }
    } catch (e) {
      print('Error during login: $e');
      return null;  // Error during request
    }
  }
}
