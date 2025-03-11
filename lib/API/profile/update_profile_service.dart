import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/ui/shared_widgets/utils/dialog_utils.dart';

class AvatarService {
  final String? token;

  AvatarService({required this.token});

  Future<void> updateAvatar({
    required BuildContext context,
    required String email,
    required String avatarId,
    required String phone,
  }) async {
    final String url = "https://route-movie-apis.vercel.app/profile";
    final Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    };

    final Map<String, dynamic> body = {
      "email": email,
      "avaterId": avatarId,
      "phone": phone
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
        showMessage(context, "Profile updated successfully",
            posButtonTitle: "Done");
      } else {
        showMessage(context, "Failed to update profile");
      }
    } catch (e) {
      showMessage(context, "Error $e", title: "Error");
    }
  }
}
