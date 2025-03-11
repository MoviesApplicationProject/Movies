import 'package:flutter/material.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/screens/onBoarding_screens/on_boarding/onboarding_screen.dart';
import 'package:movies/ui/shared_widgets/custom_button.dart';
import 'package:movies/ui/shared_widgets/custom_gradient.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExploreNowScreen extends StatelessWidget {
  static const String routeName = "/ExploreNowScreen";
  late AppLocalizations appLocalizations;

  ExploreNowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    appLocalizations =
        AppLocalizations.of(context) ?? AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
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
                    appLocalizations.setupTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    appLocalizations.setupDescription,
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
