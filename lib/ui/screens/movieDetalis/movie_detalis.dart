import 'package:flutter/material.dart';
import 'package:movies/API/api_service.dart';
import 'package:movies/API/featchMovieSuggestions.dart';
import 'package:movies/Model/movie.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/screens/movieDetalis/cast.dart';
import 'package:movies/ui/screens/movieDetalis/movie_screenshoots.dart';
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
              onPressed: () {
                Navigator.of(context).pop();
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
                // في المثال ده هنستخدم أول فيلم في القائمة لعرض تفاصيله
                return ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          height: MediaQuery.of(context).size.height * 0.82,
                          child: Image.network(
                            movie.largeCoverImage, // استخدام صورة من الـ API
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
                          child:
                              Center(child: Image.asset(AppIcons.videoButton)),
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
                              style: Theme.of(context).textTheme.headlineLarge,
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
                          Container(
                            child: Row(
                              children: [
                                buildRatesIcon(AppIcons.lovedIcon,
                                    movie.likeCount.toString()),
                                buildRatesIcon(AppIcons.timeIcon,
                                    movie.runtime.toString()),
                                buildRatesIcon(
                                    AppIcons.starIcon, movie.rating.toString()),
                              ],
                            ),
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(0),
                          ),
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
                          FutureBuilder<List<Movie>>(
                              future: fetchMovieSuggestions(movieId: movie.id),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
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
                                    print('Movie image URL: ${movie.mediumCoverImage}'); // Check if the URL is valid

                                    return InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          MovieDetails.routeName,
                                          arguments: movie,
                                        );
                                      },
                                      child: buildSimilarMovies(context, movie),
                                    );
                                  },
                                );
                              }),
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
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                )
                              : Container(),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            movie.summary.toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Cast",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          MovieCastWidget(
                              movieId: movie.id),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Genres",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.all(0),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 2,
                              childAspectRatio: 2,
                            ),
                            itemCount: movie.genres.length,
                            itemBuilder: (context, index) {
                              return buildGenres(movie.genres[index]);
                            },
                          )
                        ],
                      ),
                    )
                  ],
                );
              }
            }));
  }
  static Container buildScreenShot(String screenShot) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(screenShot)),
    );
  }

  Expanded buildRatesIcon(String icon, String text) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.all(8),
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          color: AppColors.gray,
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "$text",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            ImageIcon(
              AssetImage(icon),
              color: AppColors.yellow,
            ),
          ],
        )),
      ),
    );
  }

  Expanded buildGenres(String type) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.all(8),
        height: MediaQuery.of(context).size.height * 0.04,
        decoration: BoxDecoration(
          color: AppColors.gray,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Center(
            child: Text(
          type,
          style: Theme.of(context).textTheme.bodySmall,
        )),
      ),
    );
  }

  Stack buildSimilarMovies(BuildContext context, Movie movie) {
    return Stack(
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
                  movie.rating.toString(),
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
    );
  }
}
