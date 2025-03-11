import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies/API/movie/fetch_movie_suggestions.dart';
import 'package:movies/Model/movie.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/shared_widgets/movie_design.dart';

class Suggestion extends StatefulWidget {
  final Movie movie;

  const Suggestion({super.key, required this.movie});

  @override
  State<Suggestion> createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  late AppLocalizations appLocalizations;

  @override
  Widget build(BuildContext context) {
    appLocalizations =
        AppLocalizations.of(context) ?? AppLocalizations.of(context)!;
    return FutureBuilder<List<Movie>>(
        future: fetchMovieSuggestions(movieId: widget.movie.id),
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
            return  Center(
                child: Text(appLocalizations.noMovieFound));
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

              return MovieDesign(movie: movie);
            },
          );
        })
    ;
  }
}
