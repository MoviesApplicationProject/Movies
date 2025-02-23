import 'package:flutter/material.dart';
import 'package:movies/API/featchMovieSuggestions.dart';
import 'package:movies/Model/movie.dart';

class MovieSuggestionsGrid extends StatelessWidget {
  final int movieId;

  const MovieSuggestionsGrid({Key? key, required this.movieId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: fetchMovieSuggestions(movieId: movieId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No suggestions found.'));
        }

        // نحصل على القائمة ونقوم بتحديد أول 4 أفلام (إذا كانت القائمة أكبر)
        final suggestions = snapshot.data!;
        final moviesToShow =
            suggestions.length >= 4 ? suggestions.sublist(0, 4) : suggestions;
//
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 أفلام في الصف
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.67,
          ),
          itemCount: moviesToShow.length,
          itemBuilder: (context, index) {
            final movie = moviesToShow[index];
            return _buildMovieItem(context, movie);
          },
        );
      },
    );
  }

  Widget _buildMovieItem(BuildContext context, Movie movie) {
    return GestureDetector(
      onTap: () {
        // هنا يمكنك التنقل إلى شاشة تفاصيل الفيلم، أو أي إجراء آخر
        // مثال:
        // Navigator.pushNamed(context, '/movieDetails', arguments: movie);
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(
                movie.backgroundImage,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                movie.title,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
