import 'package:flutter/material.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/core/providers/theme_provider.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/screens/onBoarding_screens/explore/explore_now.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late ThemeProvider themeProvider;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushNamed(context, ExploreNowScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(),
          Center(
            child: Image.asset(AppIcons.appLogo, fit: BoxFit.fill),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
