import 'package:flutter/material.dart';
import 'package:movies/API/fetchMovieSuggestions.dart';
import 'package:movies/Model/movie.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/shared_widgets/movie_design.dart';

class Suggestion extends StatelessWidget {

  final Movie movie;

  const Suggestion({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
        future: fetchMovieSuggestions(movieId: movie.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: AppColors.yellow,));
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return const Center(
                child: Text('No related movies found.'));
          }
          final relatedMovies = snapshot.data!;
          final moviesToShow = relatedMovies.length >= 4
              ? relatedMovies.sublist(0, 4)
              : relatedMovies;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.67,
            ),
            itemCount: moviesToShow.length,
            itemBuilder: (context, index) {
              final movie = moviesToShow[index];

              // Print the image URL for debugging purposes
              print('Movie image URL: ${movie
                  .mediumCoverImage}'); // Check if the URL is valid

              return MovieDesign(movie: movie);
            },
          );
        })
    ;
  }

}
