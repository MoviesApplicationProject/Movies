import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movies/ui/shared_widgets/utils/dialog_utils.dart';

Future<int> fetchLikeCount(int movieId, BuildContext context) async {
  final url = 'https://yts.mx/api/v2/movie_details.json?movie_id=$movieId';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['movie']['like_count'] ?? 0;
    }
  } catch (e) {
    showMessage(context, "Error finding like count for movie");
  }

  return 0;
}
