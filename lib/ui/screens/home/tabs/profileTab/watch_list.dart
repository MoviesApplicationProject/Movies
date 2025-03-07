import 'package:flutter/material.dart';
import 'package:movies/API/fetch_watch_list.dart';
import 'package:movies/Model/movie.dart'; // استيراد Movie
import 'package:movies/ui/shared_widgets/movie_design.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  Future<List<Movie>>? favoriteMoviesFuture;

  @override
  void initState() {
    super.initState();
    favoriteMoviesFuture = FetchWatchList.fetchFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Movie>>(
        future: favoriteMoviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.yellow),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No favorite movies found'),
            );
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // عدد الأعمدة في الشبكة
              childAspectRatio: 0.7, // نسبة العرض إلى الارتفاع لكل عنصر
              crossAxisSpacing: 16, // المسافة الأفقية بين العناصر
              mainAxisSpacing: 16, // المسافة الرأسية بين العناصر
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var movie = snapshot.data![index];
              return MovieDesign(movie: movie); // تمرير كائن Movie
            },
          );
        },
      ),
    );
  }
}
