import 'package:flutter/material.dart';
import 'package:movies/API/movie/fetchGenres.dart';
import 'package:movies/Model/movie.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/shared_widgets/movie_design.dart';

class BrowseTab extends StatefulWidget {
  final String? genre ;

  const BrowseTab({super.key , this.genre});

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
          if (widget.genre != null && genres.contains(widget.genre)) {
            selectedGenre = widget.genre!;
          } else {
            selectedGenre = genreList.isNotEmpty ? genreList.first : '';
          }
          _isGenresLoaded = true;
          if (selectedGenre.isNotEmpty) {
            fetchMoviesByGenre(selectedGenre);
          }
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
                              return MovieDesign(movie: movie);
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

}
