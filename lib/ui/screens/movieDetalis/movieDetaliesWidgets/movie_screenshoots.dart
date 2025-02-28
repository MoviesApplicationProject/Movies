import 'package:flutter/material.dart';
import 'package:movies/API/fetchMovieScreenshots.dart';
import 'package:movies/core/theme/app_colors.dart';

class MovieScreenshots extends StatelessWidget {
  final int movieId;

  MovieScreenshots({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: fetchMovieScreenshots(movieId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: AppColors.yellow));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No screenshots available.'));
        } else {
          return buildScreenshotsList(snapshot.data!);
        }
      },
    );
  }

  Widget buildScreenshotsList(List<String> screenshots) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: screenshots.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                screenshots[index],
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
              ),
            ),
          );
        },
      ),
    );
  }
}
