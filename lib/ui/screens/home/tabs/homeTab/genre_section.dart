import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies/API/history_service.dart';
import 'package:movies/Model/movie.dart';
import 'package:movies/ui/screens/home/home.dart';
import 'package:movies/ui/screens/movieDetalis/movie_detalis.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GenreSection extends StatefulWidget {
  final String genre;
  final List<Movie> movies;

  const GenreSection({required this.genre, required this.movies});

  @override
  State<GenreSection> createState() => _GenreSectionState();
}

class _GenreSectionState extends State<GenreSection> {
  late AppLocalizations appLocalizations;

  @override
  Widget build(BuildContext context) {
    appLocalizations =
        AppLocalizations.of(context) ?? AppLocalizations.of(context)!;
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.genre,
                  style: Theme.of(context).textTheme.headlineLarge
                ),
               InkWell(
                 child:  Text(
                   '${appLocalizations.seeMore} >',
                   style: Theme.of(context).textTheme.labelSmall,
                 ),

                 onTap: () {
                    Navigator.pushNamed(context, HomeScreen.routeName , arguments:{ "indexArg" : 2 , "genres" : widget.genre } ,);
                 },
               )
              ],
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * .32,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  final movie = widget.movies[index];
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InkWell(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        String? userId = prefs.getString("user_id");

                        if (userId == null) {
                          print(
                              "🚨 Error: user_id is NULL, cannot add movie to history!");
                          return;
                        }

                        await HistoryService.addMovieToHistory(userId, movie);
                        Navigator.of(context).pushNamed(
                            MovieDetails.routeName,
                            arguments: movie,
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .4,
                              height: MediaQuery.of(context).size.height * .3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(movie.mediumCoverImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 8,
                                    left: 8,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            movie.rating.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                  );
                },
              )
          ),
        ],
      );
  }
}
