import 'package:flutter/material.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/screens/onBoarding_screens/explore/explore_now.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, ExploreNowScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between items
        crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
        children: [
          const SizedBox(), // Empty space at the top
          Center(
            child: Image.asset(AppIcons.appLogo, fit: BoxFit.fill), // Center logo
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20), // Add padding to the bottom
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
              children: [
                Image.asset(AppIcons.routeLogo),
              ],
            ),
          ),
        ],
      ),
    )
    ;
  }
}
