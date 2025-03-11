import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies/API/movie/search_service.dart';
import 'package:movies/Model/movie.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/shared_widgets/custom_text_field.dart';
import 'package:movies/ui/shared_widgets/movie_design.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  late AppLocalizations appLocalizations;
  List<Movie> allMovies = [];
  List<Movie> filteredMovies = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }


  void onSearchChanged(String query) {
    SearchAPI.fetchMovies(query).then((movies) {
      setState(() {
        filteredMovies = movies;
      });
    });
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
    appLocalizations =
        AppLocalizations.of(context) ?? AppLocalizations.of(context)!;
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CustomTextField(
            controller: searchController,
            hint: appLocalizations.search,
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
                  appLocalizations.noMovieFound,
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
                  return Card(
                      child: MovieDesign(
                    movie: movie,
                  ));
                },
              ),
            )
        ],
      ),
    ));
  }
}
