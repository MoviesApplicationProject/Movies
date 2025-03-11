import 'package:flutter/material.dart';
import 'package:movies/Model/fav_movies.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/core/theme/app_colors.dart';

class WishListMovieCard extends StatelessWidget {
  final FavoriteMovie movie;
  final VoidCallback onMovieSelected;

  const WishListMovieCard({
    super.key,
    required this.movie,
    required this.onMovieSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onMovieSelected,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.network(
              movie.imageURL,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(
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
                    const AssetImage(AppIcons.starIcon),
                    color: AppColors.yellow,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "${movie.rating}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
