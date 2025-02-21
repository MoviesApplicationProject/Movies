import 'package:flutter/material.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/core/theme/app_colors.dart';

class MovieDetalis extends StatefulWidget {
  static const String routeName = "/movieDetalies";

  const MovieDetalis({super.key});

  @override
  State<MovieDetalis> createState() => _MovieDetalisState();
}

class _MovieDetalisState extends State<MovieDetalis> {
  @override
  Widget build(BuildContext context) {
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              height: MediaQuery.of(context).size.height * 0.82,
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
                    Colors.black.withOpacity(0.9),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
