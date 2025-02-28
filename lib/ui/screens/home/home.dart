import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/core/providers/theme_provider.dart';
import 'package:movies/ui/screens/home/tabs/browseTab/browse_tab.dart';
import 'package:movies/ui/screens/home/tabs/homeTab/home_tab.dart';
import 'package:movies/ui/screens/home/tabs/profileTab/profile_tab.dart';
import 'package:movies/ui/screens/home/tabs/searchTab/search_tab.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late ThemeProvider themeProvider;
  late AppLocalizations appLocalizations;
  late String genre = "" ;


  int currentIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      if (args["indexArg"] is int && args["indexArg"] >= 0 && args["indexArg"] < 4) {
        currentIndex = args["indexArg"];
      }

      genre = args["genres"];
    }
  }



  @override
  Widget build(BuildContext context) {

    List<Widget> tabs = [
      HomeTab(),
      SearchTab(),
      BrowseTab(genre : genre),
      ProfileTab(),
    ];


    themeProvider = Provider.of<ThemeProvider>(context);

    themeProvider = Provider.of<ThemeProvider>(context);
    appLocalizations = AppLocalizations.of(context)!;


    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              currentIndex: currentIndex,
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(AppIcons.homeIcon),
                  ),
                  label: appLocalizations.home,
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(AppIcons.searchIcon),
                  ),
                  label: appLocalizations.search,
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(AppIcons.browseIcon),
                  ),
                  label: appLocalizations.browse,
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(AppIcons.profileIcon),
                  ),
                  label: appLocalizations.profile,
                ),
              ],
            ),
            body: tabs[currentIndex]));
  }
}
