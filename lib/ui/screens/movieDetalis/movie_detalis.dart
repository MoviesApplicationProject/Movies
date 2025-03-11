import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies/API/api_service.dart';
import 'package:movies/API/profile/is_favorite.dart';
import 'package:movies/API/profile/add_to_wish_list.dart';
import 'package:movies/API/profile/remove_from_wishList.dart';
import 'package:movies/Model/movie.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/ui/screens/movieDetalis/movie_body.dart';
import 'package:movies/Model/fav_movies.dart';

class MovieDetails extends StatefulWidget {
  static const String routeName = "/movieDetails";
  const MovieDetails({super.key});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late Future<List<Movie>> futureMovies;
  late AppLocalizations appLocalizations;
  bool isFavorite = false;
  bool isFavoriteChecked = false;
  late Movie movie;

  @override
  void initState() {
    super.initState();
    futureMovies = fetchMovies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkIfFavorite();
    });
  }

  Future<void> checkIfFavorite() async {
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is FavoriteMovie) {
      movie = convertFavoriteMovieToMovie(args);
    } else if (args is Movie) {
      movie = args;
    }

    bool favoriteStatus = await IsFavoriteMovie.isFavorite(movie.id);
    setState(() {
      isFavorite = favoriteStatus;
      isFavoriteChecked = true;
    });
  }

  Movie convertFavoriteMovieToMovie(FavoriteMovie favoriteMovie) {
    return Movie(
      id: int.parse(favoriteMovie.movieId),
      title: favoriteMovie.name,
      rating: favoriteMovie.rating,
      year: int.parse(favoriteMovie.year),
      mediumCoverImage: favoriteMovie.imageURL,
      largeCoverImage: favoriteMovie.imageURL,
      url: '',
      imdbCode: '',
      titleEnglish: '',
      titleLong: '',
      slug: '',
      runtime: 0,
      genres: [],
      summary: '',
      descriptionFull: '',
      synopsis: '',
      ytTrailerCode: '',
      language: '',
      mpaRating: '',
      backgroundImage: '',
      backgroundImageOriginal: '',
      smallCoverImage: '',
      state: '',
      dateUploaded: '',
      dateUploadedUnix: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    appLocalizations = AppLocalizations.of(context)!;

    if (args is FavoriteMovie) {
      movie = convertFavoriteMovieToMovie(args);
    } else if (args is Movie) {
      movie = args;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            color: AppColors.white,
            Icons.arrow_back_ios_rounded,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          if (isFavoriteChecked)
            IconButton(
              icon: ImageIcon(
                const AssetImage(AppIcons.saveIcon),
                color: isFavorite ? AppColors.yellow : AppColors.white,
              ),
              onPressed: () async {
                if (isFavorite) {
                  await RemoveFromWishList.removeFromFavorites(movie.id, context);
                  setState(() {
                    isFavorite = false;
                  });
                } else {
                  await WishList.addToFavorites(
                    movieId: movie.id,
                    movieName: movie.title,
                    movieRating: movie.rating,
                    imageURL: movie.mediumCoverImage,
                    releaseYear: movie.year.toString(),
                    context: context,
                  );
                  setState(() {
                    isFavorite = true;
                  });
                }
              },
            )
          else
            IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.transparent),
              onPressed: null,
            ),
        ],
      ),
      body: FutureBuilder<List<Movie>>(
        future: futureMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.yellow));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(appLocalizations.noMovieFound));
          } else {
            return MovieBody(movie: movie);
          }
        },
      ),
    );
  }
}
