import 'package:flutter/material.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/shared_widgets/custom_button.dart';

class MovieDetalis extends StatefulWidget {
  static const String routeName = "/movieDetalies";

//
  const MovieDetalis({super.key});

  @override
  State<MovieDetalis> createState() => _MovieDetalisState();
}

class _MovieDetalisState extends State<MovieDetalis> {
  @override
  Widget build(BuildContext context) {
    List<String> Genres = [
      "Action",
      "Sci-Fi",
      "Adventure",
      "Fantasy",
      "Horror"
    ];
    List<String> Movies = [
      AppAssets.movieDetalies,
      AppAssets.movieDetalies,
      AppAssets.movieDetalies,
      AppAssets.movieDetalies,
    ];

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              color: AppColors.white,
              Icons.arrow_back_outlined,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              icon: ImageIcon(
                color: AppColors.white,
                AssetImage(AppIcons.saveIcon),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Stack(
              children: [
                Positioned(
                  height: MediaQuery.of(context).size.height * 0.82,
                  child: Image.asset(
                    AppAssets.movieDetalies,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.82,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          AppColors.black.withOpacity(0.9),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.70,
                  child: Center(child: Image.asset(AppIcons.videoButton)),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Doctor Strange in the Multiverse of Madness",
                    style: Theme.of(context).textTheme.labelLarge,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: EdgeInsets.all(16),
                    child: Text(
                      "2022",
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  CustomButton(
                    title: "Watch",
                    onClick: () {},
                    color: AppColors.red,
                    textColor: AppColors.white,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    child: Row(
                      children: [
                        buildRatesIcon(AppIcons.lovedIcon),
                        buildRatesIcon(AppIcons.timeIcon),
                        buildRatesIcon(AppIcons.starIcon),
                      ],
                    ),
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(0),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Screen Shots",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  buildScreenShot(AppAssets.screenShot1),
                  buildScreenShot(AppAssets.screenShot2),
                  buildScreenShot(AppAssets.screenShot3),
                  Text(
                    "Similar",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(flex: 1, child: buildSimilarMovies(context)),
                  //     Expanded(flex: 1, child: buildSimilarMovies(context)),
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     Expanded(flex: 1, child: buildSimilarMovies(context)),
                  //     Expanded(flex: 1, child: buildSimilarMovies(context)),
                  //   ],
                  // ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            childAspectRatio: 0.67),
                    itemCount: Movies.length,
                    itemBuilder: (context, index) {
                      return buildSimilarMovies(context, Movies[index]);
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Summary",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse.—Blazer346",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Cast",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  buildCastWidget(context),
                  buildCastWidget(context),
                  buildCastWidget(context),
                  buildCastWidget(context),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Genres",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 5,
                      childAspectRatio: 2,
                    ),
                    itemCount: Genres.length,
                    itemBuilder: (context, index) {
                      return buildGenres(Genres[index]);
                    },
                  )
                ],
              ),
            )
          ],
        ));
  }

  Container buildCastWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(11),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.1,
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
                borderRadius: BorderRadius.circular(10), // نصف قطر الحواف = 10
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  AppAssets.onBoarding4,
                  fit: BoxFit.fill,
                ),
              ),
            )),
        Expanded(flex: 1, child: Container()),
        Expanded(
            flex: 32,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Name : Hayley Atwell",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  "Characther : Captain Certen",
                  style: Theme.of(context).textTheme.labelMedium,
                )
              ],
            ))
      ]),
    );
  }

  Stack buildSimilarMovies(BuildContext context, String image) {
    return Stack(
      children: [
        buildScreenShot(image),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
            color: AppColors.black.withOpacity(0.8),
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "7.7",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                width: 5,
              ),
              ImageIcon(
                AssetImage(AppIcons.starIcon),
                color: AppColors.yellow,
              ),
            ],
          )),
        ),
      ],
    );
  }

  Container buildScreenShot(String screenShot) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          screenShot,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Expanded buildRatesIcon(String icon) {
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
          child: ImageIcon(
            AssetImage(icon),
            color: AppColors.yellow,
          ),
        ),
      ),
    );
  }

  Expanded buildGenres(String type) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.all(8),
        height: MediaQuery.of(context).size.height * 0.04,
        decoration: BoxDecoration(
          color: AppColors.gray,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Center(
            child: Text(
          type,
          style: Theme.of(context).textTheme.bodySmall,
        )),
      ),
    );
  }
}
