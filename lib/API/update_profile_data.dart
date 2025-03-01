
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> updateProfile(String token, String email, int avatarId) async {
  // API URL
  final String url = "https://route-movie-apis.vercel.app/profile";

  // Headers including the Authorization token
  final Map<String, String> headers = {
    "Authorization": "Bearer $token",
    "Content-Type": "application/json"
  };

  // Print avatar ID before update
  print("Current Avatar ID: $avatarId");

  // Body data
  final Map<String, dynamic> body = {
    "email": email,
    "avaterId": avatarId,
  };

  try {
    // Sending PATCH request
    final response = await http.patch(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    // Handling the response
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print("Success: ${responseData["message"]}");

      // Print avatar ID after update
      print("Updated Avatar ID: $avatarId");
    } else {
      print("Failed: ${response.body}");
    }
  } catch (e) {
    print("Error: $e");
  }
}
