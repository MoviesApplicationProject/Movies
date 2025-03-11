import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/screens/home/home.dart';
import 'package:movies/ui/shared_widgets/utils/dialog_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  static const String apiUrl = 'https://route-movie-apis.vercel.app/auth/login';

  Future<void> loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password,
    };

    try {
      showLoading(context);
      Center(
          child: CircularProgressIndicator(
        color: AppColors.red,
      ));
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(loginData),
      );
      hideLoading(context);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        String token = data['data'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);

        Navigator.pushNamed(context, HomeScreen.routeName);
      } else {
        final responseData = json.decode(response.body);
        String errorMessage;
        if (responseData['message'] is List) {
          errorMessage = (responseData['message'] as List).join("\n");
        } else if (responseData['message'] is String) {
          errorMessage = responseData['message'];
        } else {
          errorMessage = "Something went wrong, please try again later.";
        }
        showMessage(context, errorMessage,
            title: "Error", posButtonTitle: "ok");
      }
    } catch (e) {
      hideLoading(context);
      showMessage(context, e.toString(), posButtonTitle: "ok");
    }
  }
}
