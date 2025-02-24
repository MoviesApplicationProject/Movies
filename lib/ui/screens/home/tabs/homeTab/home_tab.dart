import 'package:flutter/material.dart';
import 'package:movies/API/api_service.dart';
import 'package:movies/Model/movie.dart';
import 'package:movies/ui/screens/movieDetalis/movie_detalis.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late Future<List<Movie>> futureMovies;

  @override
  void initState() {
    super.initState();
    futureMovies = fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('YTS Movies')),
      body: FutureBuilder<List<Movie>>(
        future: futureMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No movies found.'));
          }
          final movies = snapshot.data ?? [];
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return ListTile(
                leading: Image.network(movie.smallCoverImage,
                    width: 50, height: 75, fit: BoxFit.cover),
                title: Text(movie.title),
                subtitle: Text('Rating: ${movie.rating}'),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    MovieDetails.routeName,
                    arguments: movie,
                  );
                  print('Download: ${movie.torrents}');
                },
              );
            },
          );
        },
      ),
    );
  }
}
