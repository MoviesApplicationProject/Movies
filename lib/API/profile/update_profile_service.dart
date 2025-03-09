import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/core/utils/dialog_utils.dart';

class AvatarService {
  final String? token;

  AvatarService({required this.token});

  Future<void> updateAvatar({
    required String email,
    required String avatarId,
    required BuildContext context,
  }) async {
    final String url = "https://route-movie-apis.vercel.app/profile";
    final Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    };

    final Map<String, dynamic> body = {
      "email": email,
      "avaterId": avatarId,
    };

    try {
      showLoading(context);
      final response = await http.patch(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );
      hideLoading(context);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Avatar updated successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update avatar")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }
}
