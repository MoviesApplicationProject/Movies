import 'package:flutter/material.dart';
import 'package:movies/API/add_to_watch_list.dart';
import 'package:movies/API/api_service.dart';
import 'package:movies/Model/movie.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/screens/movieDetalis/movieDetaliesWidgets/cast.dart';
import 'package:movies/ui/screens/movieDetalis/movieDetaliesWidgets/genres_widget.dart';
import 'package:movies/ui/screens/movieDetalis/movieDetaliesWidgets/movie_screenshoots.dart';
import 'package:movies/ui/screens/movieDetalis/movieDetaliesWidgets/rate_icons.dart';
import 'package:movies/ui/screens/movieDetalis/movieDetaliesWidgets/suggestion.dart';
import 'package:movies/ui/shared_widgets/custom_button.dart';

class MovieDetails extends StatefulWidget {
  static const String routeName = "/movieDetalies";

  const MovieDetails({super.key});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late Future<List<Movie>> futureMovies;

  @override
  void initState() {
    super.initState();
    futureMovies = fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              color: AppColors.white,
              Icons.arrow_back_outlined,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              icon: ImageIcon(
                color: AppColors.white,
                AssetImage(AppIcons.saveIcon),
              ),
              onPressed: () async {
                await WatchList.addToFavorites(
                  movieId: movie.id,
                  movieName: movie.title,
                  movieRating: movie.rating,
                  imageURL: movie.mediumCoverImage,
                  releaseYear: movie.year.toString(),
                );
              },
            ),
          ],
        ),
        body: FutureBuilder<List<Movie>>(
            future: futureMovies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No movies found.'));
              } else {
                return ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          height: MediaQuery.of(context).size.height * 0.82,
                          child: Image.network(
                            movie.largeCoverImage.isNotEmpty
                                ? movie.largeCoverImage
                                : movie.mediumCoverImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.82,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  AppColors.black.withOpacity(0.9),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.70,
                          child: Center(
                              child: Image.asset(AppIcons.videoButton)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            movie.title,
                            style: Theme.of(context).textTheme.labelLarge,
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            margin: const EdgeInsets.all(16),
                            child: Text(
                              movie.year.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          CustomButton(
                            title: "Watch",
                            onClick: () {},
                            color: AppColors.red,
                            textColor: AppColors.white,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          RateIcons(movie: movie),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Screen Shots",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          MovieScreenshots(movieId: movie.id),
                          Text(
                            "Similar",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Suggestion(movie: movie),
                          movie.descriptionFull != ""
                              ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Summary",
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                movie.descriptionFull.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall,
                              ),
                            ],
                          )
                              : Container(),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Cast",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          MovieCastWidget(movieId: movie.id),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Genres",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          GenresWidget(movie: movie),
                        ],
                      ),
                    )
                  ],
                );
              }
            }));
  }
}
