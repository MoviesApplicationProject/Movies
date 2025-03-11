import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';

class CustomGradient extends StatelessWidget {
  final Color color;

  const CustomGradient({super.key, this.color = AppColors.black});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              color.withOpacity(0.5),
              color.withOpacity(1),
            ],
            stops: [0.5, 1.0],
          ),
        ),
      )

    );
  }
}
