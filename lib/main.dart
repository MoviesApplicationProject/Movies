import 'package:flutter/material.dart';
import 'package:movies/ui/screens/onBoarding_screens/explore/explore_now.dart';
import 'package:movies/ui/screens/onBoarding_screens/on_boarding/onboarding_screen.dart';
import 'package:movies/ui/screens/onBoarding_screens/splash/splash_screen.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});



  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
      // locale: Locale(localeProvider.locale),
      debugShowCheckedModeBanner: false,
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        ExploreNowScreen.routeName: (_) => ExploreNowScreen(),

      },
      initialRoute: SplashScreen.routeName,

    );
  }
}
