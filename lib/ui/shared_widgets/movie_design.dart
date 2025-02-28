import 'package:flutter/material.dart';
import 'package:movies/Model/movie.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/screens/movieDetalis/movie_detalis.dart';

class MovieDesign extends StatelessWidget {
  final Movie movie;

  const MovieDesign({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          MovieDetails.routeName,
          arguments: movie,
        );
      },
      child: Stack(
        children: [
          // Check if the movie image URL is not null or empty before loading
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: movie.mediumCoverImage.isNotEmpty
                ? Image.network(
              movie.mediumCoverImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(Icons.error, color: Colors.red),
                ); // Show error icon if the image fails to load
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            )
                : Center(
              child: Icon(Icons.broken_image, color: Colors.grey),
            ), // Show broken image icon if URL is empty or null
          ),
          // Rating Badge at the top-left
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
                    AssetImage(AppIcons.starIcon),
                    color: AppColors.yellow,
                    size: 16,
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
