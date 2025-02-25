import 'package:flutter/material.dart';
import 'package:movies/Model/movie.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/core/theme/app_colors.dart';

class Rateicons extends StatelessWidget {
  final Movie movie;

  const Rateicons({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          buildRatesIcon(
              AppIcons.lovedIcon, movie.likeCount.toString(), context),
          buildRatesIcon(AppIcons.timeIcon, movie.runtime.toString(), context),
          buildRatesIcon(AppIcons.starIcon, movie.rating.toString(), context),
        ],
      ),
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(0),
    );
  }

  Expanded buildRatesIcon(String icon, String text, BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.all(8),
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          color: AppColors.gray,
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "$text",
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
