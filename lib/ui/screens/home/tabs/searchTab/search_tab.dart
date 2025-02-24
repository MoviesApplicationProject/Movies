import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/Model/movie.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/screens/movieDetalis/movie_detalis.dart';
import 'package:movies/ui/shared_widgets/custom_text_field.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  List<Movie> allMovies = [];
  List<Movie> filteredMovies = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchMovies({String query = ''}) async {
    if (query.isEmpty) {
      setState(() {
        filteredMovies = [];
      });
      return;
    }
    try {
      final url =
          'https://yts.mx/api/v2/list_movies.json?query_term=$query&limit=20';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> movies = data['data']['movies'] ?? [];

        setState(() {
          List<Movie> allMovies =
              movies.map((movieMap) => Movie.fromJson(movieMap)).toList();
          filteredMovies = allMovies;
        });
      } else {
        print('Failed to fetch movies: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching movies: $e');
    }
  }

  void onSearchChanged(String query) {
    fetchMovies(query: query);
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
                  rating,
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CustomTextField(
            controller: searchController,
            hint: "Search",
            prefixIcon: const ImageIcon(AssetImage(AppIcons.searchIcon)),
            onChange: onSearchChanged,
          ),
          SizedBox(
            height: 16,
          ),
          if (searchController.text.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(AppAssets.emptySearch),
                    ),
                  ],
                ),
              ),
            )
          else if (filteredMovies.isEmpty && searchController.text.isNotEmpty)
            Expanded(
              child: Center(
                child: Text(
                  'No movies found.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            )
          else
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: filteredMovies.length,
                itemBuilder: (context, index) {
                  final movie = filteredMovies[index];
                  return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          MovieDetalis.routeName,
                          arguments: movie,
                        );
                      },
                      child: Card(
                        child: buildSimilarMovies(
                          context,
                          movie.largeCoverImage,
                          movie.rating.toString(),
                        ),
                      ));
                },
              ),
            )
        ],
      ),
    ));
  }
}
