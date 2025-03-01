import 'dart:convert';
import 'package:http/http.dart' as http;

class DeleteProfileApi {
  final String baseUrl;

  DeleteProfileApi({required this.baseUrl});

  Future<String> deleteProfile(String token) async {
    final url = Uri.parse('$baseUrl/profile');

    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['message'];
    } else {
      throw Exception('Failed to delete profile: ${response.body}');
    }
  }
}
