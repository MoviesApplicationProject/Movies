import 'package:flutter/material.dart';
import 'package:movies/API/fetchMovieCast.dart';
import 'package:movies/Model/cast_dm.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/theme/app_colors.dart';

class MovieCastWidget extends StatelessWidget {
  final int movieId;

  MovieCastWidget({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CastDM>>(
      future: fetchMovieCast(movieId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(''));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No cast found.'));
        } else {
          return Column(
            children: snapshot.data!
                .map((member) => buildCastWidget(context, member))
                .toList(),
          );
        }
      },
    );
  }

  Widget buildCastWidget(BuildContext context, CastDM member) {
    return member != ""
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 11, vertical: 5),
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.gray,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(children: [
              Expanded(
                flex: 7,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      member.urlSmallImage.isNotEmpty
                          ? member.urlSmallImage
                          : 'https://via.placeholder.com/150.png',
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(AppAssets.onBoarding1);
                      },
                    ),
                  ),
                ),
              ),
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 32,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Name: ${member.name}",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      "Character: ${member.characterName}",
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  ],
                ),
              )
            ]),
          )
        : Container();
  }
}
