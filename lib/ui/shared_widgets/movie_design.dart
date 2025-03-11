import 'package:flutter/material.dart';
import 'package:movies/API/profile/history_service.dart';
import 'package:movies/Model/movie.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/screens/movieDetalis/movie_detalis.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieDesign extends StatelessWidget {
  final Movie movie;

  const MovieDesign({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? userId = prefs.getString("user_id");

          if (userId == null) {
            return;
          }

          await HistoryService.addMovieToHistory(userId, movie);
          Navigator.of(context).pushNamed(
            MovieDetails.routeName,
            arguments: movie,
          );
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                movie.mediumCoverImage,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Row(
                  children: [
                    ImageIcon(
                      AssetImage(AppIcons.starIcon),
                      color: AppColors.yellow,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${movie.rating}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}