import 'package:flutter/material.dart';
import 'package:movies/Model/movie.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/ui/screens/movieDetalis/movieDetaliesWidgets/cast.dart';
import 'package:movies/ui/screens/movieDetalis/movieDetaliesWidgets/genres_widget.dart';
import 'package:movies/ui/screens/movieDetalis/movieDetaliesWidgets/movie_screenshoots.dart';
import 'package:movies/ui/screens/movieDetalis/movieDetaliesWidgets/rate_icons.dart';
import 'package:movies/ui/screens/movieDetalis/movieDetaliesWidgets/suggestion.dart';
import 'package:movies/ui/shared_widgets/custom_button.dart';
import 'package:movies/ui/shared_widgets/custom_gradient.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MovieBody extends StatelessWidget {
  final Movie movie;

  const MovieBody({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return ListView(
      padding: EdgeInsets.all(0),
      children: [
        Stack(
          children: [
            Positioned(
              height: MediaQuery.of(context).size.height * 0.82,
              child: Image.network(
                movie.largeCoverImage.isNotEmpty
                    ? movie.largeCoverImage
                    : movie.mediumCoverImage,
                fit: BoxFit.cover,
              ),
            ),
            CustomGradient(),
            Container(
              height: MediaQuery.of(context).size.height * 0.70,
              child: Center(
                child: Image.asset(AppIcons.videoButton),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                movie.title,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              Container(
                margin: const EdgeInsets.all(16),
                child: Text(
                  movie.year.toString(),
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              CustomButton(
                title: appLocalizations.watch,
                onClick: () {},
                color: Colors.red,
                textColor: Colors.white,
              ),
              SizedBox(height: 16),
              RateIcons(movie: movie),
              SizedBox(height: 16),
              Text(
                appLocalizations.screenshot,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              MovieScreenshots(movieId: movie.id),
              Text(
                appLocalizations.similar,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Suggestion(movie: movie),
              if (movie.descriptionFull.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLocalizations.summary,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      movie.descriptionFull,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              SizedBox(height: 8),
              Text(
                appLocalizations.cast,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              MovieCastWidget(movieId: movie.id),
              SizedBox(height: 8),
              Text(
                appLocalizations.genres,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              GenresWidget(movie: movie),
            ],
          ),
        ),
      ],
    );
  }
}
