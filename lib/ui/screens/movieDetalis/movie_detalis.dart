import 'package:flutter/material.dart';
import 'package:movies/API/api_service.dart';
import 'package:movies/Model/movie.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/screens/movieDetalis/suggestion.dart';
import 'package:movies/ui/shared_widgets/custom_button.dart';

class MovieDetalis extends StatefulWidget {
  static const String routeName = "/movieDetalies";

  const MovieDetalis({super.key});

  @override
  State<MovieDetalis> createState() => _MovieDetalisState();
}

class _MovieDetalisState extends State<MovieDetalis> {
  late Future<List<Movie>> futureMovies;

  @override
  void initState() {
    super.initState();
    // جلب الأفلام من API
    futureMovies = fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Movie;

    List<String> Movies = [
      AppAssets.movieDetalies,
      AppAssets.movieDetalies,
      AppAssets.movieDetalies,
      AppAssets.movieDetalies,
    ];

    List<String> Genres = [
      "Action",
      "Sci-Fi",
      "Adventure",
      "Fantasy",
      "Horror"
    ];

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
                                buildRatesIcon(AppIcons.lovedIcon),
                                buildRatesIcon(AppIcons.timeIcon),
                                buildRatesIcon(AppIcons.starIcon),
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
                          buildScreenShot(movie.largeCoverImage),
                          buildScreenShot(movie.largeCoverImage),
                          buildScreenShot(movie.largeCoverImage),
                          Text(
                            "Similar",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          // GridView.builder(
                          //   shrinkWrap: true,
                          //   physics: NeverScrollableScrollPhysics(),
                          //   padding: EdgeInsets.all(0),
                          //   gridDelegate:
                          //   const SliverGridDelegateWithFixedCrossAxisCount(
                          //       crossAxisCount: 2,
                          //       crossAxisSpacing: 8,
                          //       childAspectRatio: 0.67),
                          //   itemCount: Movies.length,
                          //   itemBuilder: (context, index) {
                          //     return buildSimilarMovies(context, Movies[index]);
                          //   },
                          // ),
                          MovieSuggestionsGrid(
                            movieId: movie.id,
                          ),

                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Summary",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
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
                          buildCastWidget(context),
                          buildCastWidget(context),
                          buildCastWidget(context),
                          buildCastWidget(context),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Genres",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          // GridView.builder(
                          //   shrinkWrap: true,
                          //   physics: NeverScrollableScrollPhysics(),
                          //   padding: EdgeInsets.all(0),
                          //   gridDelegate:
                          //   const SliverGridDelegateWithFixedCrossAxisCount(
                          //     crossAxisCount: 3,
                          //     crossAxisSpacing: 8,
                          //     mainAxisSpacing: 5,
                          //     childAspectRatio: 2,
                          //   ),
                          //   itemCount: movie.genres.length,
                          //   itemBuilder: (context, index) {
                          //     return buildGenres(movie.genres[index]);
                          //   },
                          // )
                        ],
                      ),
                    )
                  ],
                );
              }
            }));
  }

  Container buildCastWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(11),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.1,
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(children: [
        Expanded(
            flex: 7,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // نصف قطر الحواف = 10
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  AppAssets.onBoarding4,
                  fit: BoxFit.fill,
                ),
              ),
            )),
        Expanded(flex: 1, child: Container()),
        Expanded(
            flex: 32,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Name : Hayley Atwell",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  "Characther : Captain Certen",
                  style: Theme.of(context).textTheme.labelMedium,
                )
              ],
            ))
      ]),
    );
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

  Expanded buildRatesIcon(String icon) {
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
          child: ImageIcon(
            AssetImage(icon),
            color: AppColors.yellow,
          ),
        ),
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
}