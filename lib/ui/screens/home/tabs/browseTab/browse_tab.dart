import 'package:flutter/material.dart';
import 'package:movies/API/api_service.dart';
import 'package:movies/API/fetchGenres.dart';
import 'package:movies/Model/movie.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/screens/movieDetalis/movie_detalis.dart'; // Make sure you import the MovieDetails route

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  late Future<List<Movie>> movies;
  List<String> genres = [];
  String selectedGenre = '';
  bool _isGenresLoaded = false;
  bool _isMoviesLoading = true;

  @override
  void initState() {
    super.initState();
    if (!_isGenresLoaded) {
      Genres().fetchGenres().then((genreList) {
        genreList.sort();
        setState(() {
          genres = genreList;
          selectedGenre = genreList.first;
          _isGenresLoaded = true;
          fetchMoviesByGenre(selectedGenre);
        });
      });
    }
  }

  void fetchMoviesByGenre(String genre) {
    setState(() {
      _isMoviesLoading = true;
      selectedGenre = genre;
      movies = Genres().fetchMovies(genre: genre).then((movieList) {
        setState(() {
          _isMoviesLoading = false;
        });
        return movieList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: genres.length,
                  itemBuilder: (context, index) {
                    final genre = genres[index];
                    final isSelected = selectedGenre == genre;

                    return GestureDetector(
                      onTap: () {
                        fetchMoviesByGenre(genre);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.yellow : Colors.transparent,
                          border: Border.all(
                            color: AppColors.yellow,
                            width: 2.0, // Border width
                          ),
                          borderRadius: BorderRadius.circular(16), // Rounded corners
                        ),
                        child: Center(
                          child: Text(
                            genre,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? AppColors.black : AppColors.yellow,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20), // Spacing
              Expanded(
                child: _isMoviesLoading
                    ? const Center(child: CircularProgressIndicator(color: AppColors.yellow,)) // Show loading spinner for movies
                    : FutureBuilder<List<Movie>>(
                  future: movies,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: CircularProgressIndicator(color: AppColors.yellow,));
                    }
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var movie = snapshot.data![index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              MovieDetails.routeName,
                              arguments: movie,
                            );
                          },
                          child: Card(
                            child: buildSimilarMovies(
                              context,
                              movie.mediumCoverImage,
                              movie.rating.toString(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack buildSimilarMovies(BuildContext context, String image, String rating) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                const SizedBox(width: 4),
                Text(
                  rating,
                  style: const TextStyle(
                    color: AppColors.white,
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
