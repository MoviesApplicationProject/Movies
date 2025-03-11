import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movies/ui/screens/auth/login/login.dart';
import 'package:movies/ui/shared_widgets/utils/dialog_utils.dart';

class RegisterService {
  static const String apiUrl = 'https://route-movie-apis.vercel.app/auth/register';

  Future<bool> registerUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avaterId,
  }) async {
    final Map<String, dynamic> userData = {
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'phone': phone,
      'avaterId': avaterId,
    };

    try {
      showLoading(context);
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(userData),
      );
      hideLoading(context);

      if (response.statusCode == 201) {
        showMessage(context, "Registration successful", posButtonTitle: "Done");

        Navigator.pushNamed(context, LoginScreen.routeName);
        return true;
      } else {
        final responseData = json.decode(response.body);
        String errorMessage;

        if (responseData['message'] is List) {
          errorMessage = (responseData['message'] as List).join("\n");
        } else if (responseData['message'] is String) {
          errorMessage = responseData['message'];
        } else {
          errorMessage = "Error , Please try again";
        }

        showMessage(
          context,
          errorMessage,
          title: "Error",
          posButtonTitle: "Try again",
        );
        return false;
      }
    } catch (e) {
      hideLoading(context);

      showMessage(
        context,
        "$e",
        title: "Network Error",
        posButtonTitle: "Try again",
      );

      return false;
    }
  }
}
