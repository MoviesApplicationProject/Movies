import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/core/utils/dialog_utils.dart';
import 'package:movies/ui/screens/auth/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteService {
  static const String baseUrl = "https://route-movie-apis.vercel.app/profile";

  Future<void> deleteProfile(BuildContext context) async {
    try {
      showLoading(context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authToken = prefs.getString('auth_token');

      hideLoading(context);
      if (authToken == null) {
        return;
      }

      final response = await http.delete(
        Uri.parse(baseUrl),
        headers: {
          'Authorization': 'Bearer ${authToken.trim()}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await prefs.remove('auth_token');

        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.routeName,
          (route) => false,
        );
      } else {
        showMessage(context, response.statusCode.toString(), title: "Error");
      }
    } catch (e) {
      hideLoading(context);
      showMessage(context, e.toString(), title: "Error");
    }
  }
}
