import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/providers/theme_provider.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/screens/auth/login/login.dart';
import 'package:movies/ui/shared_widgets/custom_button.dart';
import 'package:movies/ui/shared_widgets/custom_gradient.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String routeName = "/onBoarding";

  const OnBoardingScreen({super.key});

  @override
  OnBoardingScreenState createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  late ThemeProvider themeProvider;
  late AppLocalizations appLocalizations;
  final PageController pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    appLocalizations =
        AppLocalizations.of(context) ?? AppLocalizations.of(context)!;

    // Onboarding data with color, title, and description
    final List<Map<String, dynamic>> onboardingData = [
      {
        "image": AppAssets.onBoarding1,
        "title": appLocalizations.onBoardingTitle1,
        "color": AppColors.blue,
        "description": appLocalizations.onBoardingDescription1
      },
      {
        "image": AppAssets.onBoarding2,
        "title": appLocalizations.onBoardingTitle2,
        "color": AppColors.burgundy,
        "description": appLocalizations.onBoardingDescription2
      },
      {
        "image": AppAssets.onBoarding3,
        "title": appLocalizations.onBoardingTitle3,
        "color": AppColors.purple,
        "description": appLocalizations.onBoardingDescription3
      },
      {
        "image": AppAssets.onBoarding4,
        "title": appLocalizations.onBoardingTitle4,
        "color": AppColors.wineRed,
        "description": appLocalizations.onBoardingDescription4
      },
      {
        "image": AppAssets.onBoarding5,
        "title": appLocalizations.onBoardingTitle5,
        "color": AppColors.darkGray,
        "description": ""
      },
    ];

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return buildScreen(context, onboardingData, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildScreen(
      BuildContext context, List<Map<String, dynamic>> onboardingData, int index) {
    return Stack(
      children: [
        Image.asset(
          onboardingData[index]["image"]!,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        CustomGradient(color: onboardingData[index]["color"]),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: buildBottomCard(context, onboardingData[index]),
        ),
      ],
    );
  }

  Widget buildBottomCard(BuildContext context, Map<String, dynamic> data) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.black, // Card background
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Adjusts card size
        children: [
          Text(
            data["title"]!,
            style:Theme.of(context).textTheme.bodyLarge
          ),
          const SizedBox(height: 16),
          if(currentIndex != 4)
            Text(
            data["description"]!,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.white, fontSize: 20, fontWeight: FontWeight.w400),),
          if(currentIndex != 4)
            const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomButton(
                title: currentIndex < 4 ? appLocalizations.next : appLocalizations.finish,
                onClick: () {
                  if (currentIndex < 4) {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    Navigator.pushReplacementNamed(
                        context, LoginScreen.routeName);
                  }
                },
              ),
              if (currentIndex > 0)
                SizedBox(height: 16,),
              if (currentIndex > 0)
                FilledButton(
                  onPressed: () {
                    pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,);},
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  ),child: Text(appLocalizations.back),)
            ],
          ),
        ],
      ),
    );
  }
}
