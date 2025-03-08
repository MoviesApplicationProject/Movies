import 'package:flutter/material.dart';
import 'package:movies/API/api_service.dart';
import 'package:movies/API/fetchGenres.dart';
import 'package:movies/Model/movie.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/screens/home/tabs/homeTab/genre_section.dart';
import 'package:movies/ui/shared_widgets/movie_design.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late AppLocalizations appLocalizations;
  late Future<List<Movie>> movies;
  List<String> genres = [];
  String selectedGenre = '';
  bool _isGenresLoaded = false;
  bool _isMoviesLoading = true;
  late Future<List<Movie>> futureMovies;
  PageController _pageController = PageController(initialPage: 5, viewportFraction: 0.5);
  double currentPage = 5.0;

  Map<String, List<Movie>> genreMoviesCache = {};

  @override
  void initState() {
    super.initState();
    futureMovies = fetchMovies();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!;
      });
    });
    _fetchGenresAndMovies();
  }

  Future<void> _fetchGenresAndMovies() async {
    try {
      List<String> genreList = await Genres().fetchGenres();
      genreList.sort();

      setState(() {
        genres = genreList;
        selectedGenre = genreList.first;
        _isGenresLoaded = true;
      });

      for (String genre in genreList) {
        List<Movie> movieList = await Genres().fetchMovies(genre: genre);
        setState(() {
          genreMoviesCache[genre] = movieList;
        });
      }

      setState(() {
        _isMoviesLoading = false;
      });
    } catch (error) {
      setState(() {
        _isMoviesLoading = false;
      });
      print("Error fetching genres or movies: $error");
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations =
        AppLocalizations.of(context) ?? AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: _isMoviesLoading
            ? Center(child: CircularProgressIndicator(color: AppColors.yellow))
            : SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<Movie>>(
                future: futureMovies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(color: AppColors.yellow));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text(appLocalizations.noMovieFound));
                  }
                  final movies = snapshot.data ?? [];

                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.69,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            movies[currentPage.round()].mediumCoverImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.black.withOpacity(0.9),
                                  AppColors.black.withOpacity(0.5),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: [0.5, 1, 1.0],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 30,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Image(
                              image: AssetImage(AppAssets.available),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Image(
                              image: AssetImage(AppAssets.watch),
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.38,
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: movies.length,
                              itemBuilder: (context, index) {
                                final movie = movies[index];
                                double distanceFromCenter = (currentPage - index).abs();
                                double scaleFactor = (1 - distanceFromCenter * 0.2).clamp(0.4, 1.0);
                                double widthFactor = (1 - distanceFromCenter * 0.03).clamp(0.4, 1.0);
                                return Center(
                                  child: Transform.scale(
                                    scale: scaleFactor,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.7 * widthFactor,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 0),
                                        child: MovieDesign(movie: movie),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              if (_isGenresLoaded && !_isMoviesLoading)
                Column(
                  children: genres.map((genre) {
                    final movies = genreMoviesCache[genre];
                    return GenreSection(genre: genre, movies: movies!);
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
