import 'package:flutter/material.dart';
import 'package:movies/API/profile/fetch_wish_list.dart';
import 'package:movies/API/profile/history_service.dart';
import 'package:movies/Model/fav_movies.dart';
import 'package:movies/Model/movie.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/screens/movieDetalis/movie_detalis.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesScreen extends StatefulWidget {
  final Function updateHistoryCount; // المتغير الجديد

  FavoritesScreen({Key? key, required this.updateHistoryCount}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  Future<List<FavoriteMovie>>? favoriteMoviesFuture;

  @override
  void initState() {
    super.initState();
    fetchFavoriteMovies();
  }

  void fetchFavoriteMovies() {
    setState(() {
      favoriteMoviesFuture = FetchWishList.fetchFavorites() as Future<List<FavoriteMovie>>?;
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<FavoriteMovie>>(
          future: favoriteMoviesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.yellow,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Image.asset(
                  AppAssets.emptySearch,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.13,
                ),
              );
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var favoriteMovie = snapshot.data![index];
                return MovieCard(
                  movie: favoriteMovie,
                  onMovieSelected: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    String? userId = prefs.getString("user_id");

                    if (userId == null) {
                      print("🚨 Error: user_id is NULL, cannot add movie to history!");
                      return;
                    }

                    await HistoryService.addMovieToHistory(
                        userId, convertFavoriteMovieToMovie(favoriteMovie));

                    // استدعاء الـ callback لتحديث historyCount
                    widget.updateHistoryCount();

                    final result = await Navigator.of(context).pushNamed(
                      MovieDetails.routeName,
                      arguments: favoriteMovie,
                    );

                    if (result == true) {
                      fetchFavoriteMovies();
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}


class MovieCard extends StatelessWidget {
  final FavoriteMovie movie;
  final VoidCallback onMovieSelected;

  const MovieCard({
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
                    movie.rating != null ? "${movie.rating}" : "N/A",
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
