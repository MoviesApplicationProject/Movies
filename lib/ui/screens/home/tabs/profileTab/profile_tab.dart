import 'package:flutter/material.dart';
import 'package:movies/API/fetch_wish_list.dart';
import 'package:movies/API/get_user_profile_data.dart';
import 'package:movies/Model/avatar.dart';
import 'package:movies/Model/fav_movies.dart';
import 'package:movies/Model/get_profile.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/screens/home/tabs/profileTab/profile_update.dart';
import 'package:movies/ui/screens/home/tabs/profileTab/wish_list.dart';
import 'package:movies/ui/shared_widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({super.key, this.historyCount = 0, this.wishListCount = 0});

  int historyCount;
  int wishListCount;
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  GetUserProfileData? userProfile;
  bool isLoading = true;
  String? token;

  @override
  void initState() {
    super.initState();
    fetchToken();
    fetchWishListCount();
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
    GetUserProfile fetchUserProfile =
    GetUserProfile(baseUrl: "https://route-movie-apis.vercel.app/");
    GetUserProfileData? data = await fetchUserProfile.fetchUserProfile(token);

    if (mounted) {
      setState(() {
        userProfile = data;
        isLoading = false;
      });
    }
  }

  Future<void> fetchWishListCount() async {
    List<FavoriteMovie> favoriteMovies = await FetchWishList.fetchFavorites();

    if (mounted) {
      setState(() {
        widget.wishListCount = favoriteMovies.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray,
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: AppColors.yellow,))
          : userProfile?.data == null
          ? Center(child: Text("Failed to load profile"))
          : DefaultTabController(
        length: 2, // Only two tabs now
        child: Scaffold(
          body: SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: AppColors.gray,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: CircleAvatar(
                                    radius: 55,
                                    child: Image.asset(
                                      Avatar.getAvatarById(
                                          userProfile!.data!.avaterId ?? 0),
                                      height: 118,
                                      width: 118,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 2,
                                    child: customWidget(
                                      widget.wishListCount,
                                      "Wish List",
                                    )),
                                Expanded(
                                  flex: 2,
                                  child: customWidget(
                                    widget.historyCount,
                                    "History",
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  Text(userProfile!.data!.name ?? 'N/A',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium),
                                ],
                              ),
                            ),
                            Row(children: [
                              Expanded(
                                  flex: 2,
                                  child: CustomButton(
                                    onClick: () {
                                      if (token != null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfileUpdate(
                                                    token: token,
                                                    avatarId: userProfile!
                                                        .data!.avaterId,
                                                    userName: userProfile!
                                                        .data!.name,
                                                    phone: userProfile!
                                                        .data!.phone,
                                                    email: userProfile!
                                                        .data!.email,
                                                  )),
                                        ).then((value) {
                                          if (value == true) {
                                            fetchUserProfile(
                                                token!); // Refresh the screen
                                          }
                                        });
                                      } else {
                                        print(
                                            "Token is null, cannot proceed to Profile Update");
                                      }
                                    },
                                    title: "Edit Profile",
                                  )),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: CustomButton(
                                    title: "Exit",
                                    onClick: () {},
                                    color: AppColors.red,
                                    textColor: AppColors.white,
                                  )),
                            ]),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: AppColors.gray,
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: AppColors.yellow,
                        labelColor: AppColors.white,
                        unselectedLabelColor: AppColors.white,
                        indicatorWeight: 3,
                        tabs: [
                          Tab(
                            icon: Icon(Icons.list,
                                size: 34, color: AppColors.yellow),
                            text: "Wish List",
                          ),
                          Tab(
                            icon: Icon(Icons.folder,
                                size: 34, color: AppColors.yellow),
                            text: "History",
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          FavoritesScreen(),
                          Center(
                              child: Image.asset(AppAssets.movieHistory,
                                  color: AppColors.white,
                                  width:
                                  MediaQuery.of(context).size.width *
                                      0.3,
                                  height:
                                  MediaQuery.of(context).size.height *
                                      0.13)),
                        ],
                      ),
                    ),
                  ])),
        ),
      ),
    );
  }

  Widget customWidget(int counter, String text) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Column(
        children: [
          Text("$counter", style: Theme.of(context).textTheme.headlineMedium),
          Text(text, style: Theme.of(context).textTheme.headlineMedium),
        ],
      ),
    );
  }
}
