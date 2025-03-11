import 'package:flutter/material.dart';
import 'package:movies/API/movie/fetch_liked.dart';
import 'package:movies/Model/movie.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/core/theme/app_colors.dart';

class RateIcons extends StatelessWidget {
  final Movie movie;

  const RateIcons({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(0),
      child: Row(
        children: [
          FutureBuilder<int>(
            future: fetchLikeCount(movie.id, context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return buildRatesIcon(AppIcons.lovedIcon, '...', context);
              } else if (snapshot.hasError) {
                return buildRatesIcon(AppIcons.lovedIcon, '0', context);
              } else {
                return buildRatesIcon(AppIcons.lovedIcon, snapshot.data.toString(), context);
              }
            },
          ),
          buildRatesIcon(AppIcons.timeIcon, movie.runtime.toString(), context),
          buildRatesIcon(AppIcons.starIcon, movie.rating.toString(), context),
        ],
      ),
    );
  }

  Expanded buildRatesIcon(String icon, String text, BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.all(8),
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            ImageIcon(
              AssetImage(icon),
              color: AppColors.yellow,
            ),
          ],
        )),
      ),
    );
  }
}
