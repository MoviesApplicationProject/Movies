import 'package:flutter/material.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/screens/onBoarding_screens/on_boarding/onboarding_screen.dart';
import 'package:movies/ui/shared_widgets/custom_button.dart';
import 'package:movies/ui/shared_widgets/custom_gradient.dart';

class ExploreNowScreen extends StatelessWidget {
  static const String routeName = "/ExploreNowScreen";

  ExploreNowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Main Image
            Positioned.fill(
              child: Image.asset(
                AppAssets.explore,
                fit: BoxFit.cover,
              ),
            ),
            CustomGradient(),

            Positioned(
              bottom: 100,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  Text(
                    "Find Your Next Favorite Movie Here",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                      color: Colors.white, // Ensure it's visible over the background
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Get access to a huge library of movies to suit all tastes. You will surely like it.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightGray,
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: CustomButton(
                title: "Explore Now",
                onClick: () {
                  Navigator.pushReplacementNamed(context, OnBoardingScreen.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
