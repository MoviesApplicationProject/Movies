import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies/core/providers/locale_provider.dart';
import 'package:movies/core/providers/theme_provider.dart';
import 'package:movies/core/theme/app_theme.dart';
import 'package:movies/ui/screens/auth/forgetpassword/forgetpassword.dart';
import 'package:movies/ui/screens/auth/login/login.dart';
import 'package:movies/ui/screens/auth/register/register.dart';
import 'package:movies/ui/screens/home/home.dart';
import 'package:movies/ui/screens/movieDetalis/movie_detalis.dart';
import 'package:movies/ui/screens/onBoarding_screens/explore/explore_now.dart';
import 'package:movies/ui/screens/onBoarding_screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
      ),
    ], child: MyApp()),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
  late LocaleProvider localeProvider;
  late ThemeProvider themeProvider;



  @override
  Widget build(BuildContext context) {
    localeProvider = Provider.of<LocaleProvider>(context);
    themeProvider = Provider.of<ThemeProvider>(context);



    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(localeProvider.locale),
      debugShowCheckedModeBanner: false,
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        ExploreNowScreen.routeName: (_) => ExploreNowScreen(),
        LoginScreen.routeName : (_) => LoginScreen(),
        RegisterScreen.routeName : (_) => RegisterScreen(),
        ForgetpasswordScreen.routeName : (_) => ForgetpasswordScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        MovieDetalis.routeName: (_) => MovieDetalis(),
      },
      initialRoute: MovieDetalis.routeName,
      theme: AppTheme.generalTheme,
    );
  }
}
