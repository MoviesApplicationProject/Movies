import 'package:flutter/material.dart';
import 'package:movies/API/profile/fetch_wish_list.dart';
import 'package:movies/API/profile/history_service.dart';
import 'package:movies/API/profile/profile_service.dart';
import 'package:movies/Model/get_profile.dart';
import 'package:movies/Model/movie.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/screens/home/tabs/profileTab/history.dart';
import 'package:movies/ui/screens/home/tabs/profileTab/wish_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'profile_header.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({super.key});

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late AppLocalizations appLocalizations;
  GetUserProfileData? userProfile;
  bool isLoading = true;
  String? token;
  late int historyCount = 0;
  late int wishListCount = 0;

  @override
  void initState() {
    super.initState();
    fetchToken();
    fetchWishListCount();
    fetchHistoryCount();
  }

  Future<void> fetchToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('auth_token');

    if (storedToken != null) {
      setState(() {
        token = storedToken;
      });
      fetchUserProfile(storedToken);
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchUserProfile(String token) async {
    GetUserProfile fetchUserProfile = GetUserProfile(baseUrl: "https://route-movie-apis.vercel.app/");
    GetUserProfileData? data = await fetchUserProfile.fetchUserProfile(token);

    if (mounted) {
      setState(() {
        userProfile = data;
        isLoading = false;
      });
    }
  }

  Future<void> fetchWishListCount() async {
    int count = await FetchWishList.getFavoriteCount();
    setState(() {
      wishListCount = count;
    });
  }

  Future<void> fetchHistoryCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("user_id");

    if (userId != null) {
      List<Movie> historyMovies = await HistoryService.getHistoryMovies(userId);
      setState(() {
        historyCount = historyMovies.length;
      });
    }
  }
  void updateHistoryCount() {
    fetchHistoryCount();
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context) ?? AppLocalizations.of(context)!;
    return Scaffold(
      body: userProfile?.data == null
          ? Center(child: CircularProgressIndicator(color: AppColors.yellow))
          : DefaultTabController(
        length: 2,
        child: Scaffold(
          body: SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProfileHeader(
                      userProfile: userProfile!,
                      wishListCount: wishListCount,
                      historyCount: historyCount,
                      appLocalizations: appLocalizations,
                      isLoading: isLoading,
                      token: token,
                      fetchUserProfile: fetchUserProfile,
                    ),
                    _buildTabBar(),
                    Expanded(
                      child: TabBarView(
                        children: [
                          FavoritesScreen(updateHistoryCount: updateHistoryCount),
                          HistoryTab(),
                        ],
                      ),
                    ),
                  ])),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: AppColors.grey,
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: AppColors.yellow,
        labelColor: AppColors.white,
        unselectedLabelColor: AppColors.white,
        indicatorWeight: 3,
        tabs: [
          Tab(
            icon: Icon(Icons.list, size: 34, color: AppColors.yellow),
            text: appLocalizations.wishList,
          ),
          Tab(
            icon: Icon(Icons.folder, size: 34, color: AppColors.yellow),
            text: appLocalizations.history,
          ),
        ],
      ),
    );
  }
}
