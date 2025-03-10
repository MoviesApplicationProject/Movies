import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:movies/core/utils/dialog_utils.dart';

class GoogleService {
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      showLoading(context);
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      hideLoading(context);

      if (googleUser == null) {
        showMessage(context, "Sign-In Aborted");
        print("Google Sign-In Aborted by User.");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final String? idToken = googleAuth.idToken;
      if (idToken == null) {
        showMessage(context, "Failed");
        throw Exception("Failed to get ID Token from Google");
      }

      print("Google ID Token: $idToken");

      final response = await http.post(
        Uri.parse("https://your-api.com/auth/google-login"),
        // استبدلها بـ API الخاصة بك
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "idToken": idToken, // نرسل ID Token للـ API
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        showMessage(context, "Login Successful");
        print("Login Successful! API Token: ${data['token']}");
      } else {
        showMessage(context, "Failed to login");
        print("Failed to login via API: ${response.body}");
      }
    } catch (e) {
      hideLoading(context);
      showMessage(context, "Error");
      print("Error: $e");
    }
  }
}
