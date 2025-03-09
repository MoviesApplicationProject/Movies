import 'package:flutter/material.dart';
import 'package:movies/Model/movie.dart';
import 'package:movies/core/theme/app_colors.dart';

class GenresWidget extends StatelessWidget {
  final Movie movie;

  const GenresWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 0,
        mainAxisSpacing: 2,
        childAspectRatio: 2,
      ),
      itemCount: movie.genres.length,
      itemBuilder: (context, index) {
        return buildGenres(movie.genres[index], context);
      },
    );
  }

  Widget buildGenres(String type, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height * 0.04,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Center(
          child: Text(
        type,
        style: Theme.of(context).textTheme.bodySmall,
      )),
    );
  }
}
