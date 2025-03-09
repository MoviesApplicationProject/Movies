import 'package:flutter/material.dart';
import 'package:movies/API/movie/fetchMovieCast.dart';
import 'package:movies/Model/cast_dm.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MovieCastWidget extends StatefulWidget {
  final int movieId;

  MovieCastWidget({required this.movieId});

  @override
  State<MovieCastWidget> createState() => _MovieCastWidgetState();
}

class _MovieCastWidgetState extends State<MovieCastWidget> {
  late AppLocalizations appLocalizations;

  @override
  Widget build(BuildContext context) {
    appLocalizations =
        AppLocalizations.of(context) ?? AppLocalizations.of(context)!;
    return FutureBuilder<List<CastDM>>(
      future: fetchMovieCast(widget.movieId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: AppColors.yellow,));
        } else if (snapshot.hasError) {
          return Center(child: Text(''));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return  Center(child: Text(appLocalizations.noCastFound));
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
              color: AppColors.grey,
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
                          : AppAssets.placeHolder,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(AppAssets.placeHolder);
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
                      "${appLocalizations.name}: ${member.name}",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      "${appLocalizations.character}: ${member.characterName}",
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
