import 'package:flutter/material.dart';
import 'package:movies/API/auth/logout_service.dart';
import 'package:movies/API/profile/fetch_wish_list.dart';
import 'package:movies/API/profile/history_service.dart';
import 'package:movies/API/profile/profile_service.dart';
import 'package:movies/Model/avatar.dart';
import 'package:movies/Model/get_profile.dart';
import 'package:movies/Model/movie.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/screens/home/tabs/profileTab/profile_update.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies/ui/screens/home/tabs/profileTab/wish_list.dart';
import 'package:movies/ui/shared_widgets/custom_button.dart';
import 'package:movies/ui/shared_widgets/movie_design.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late int historyCount;
  List<Movie> historyMovies = [];
  late int wishListCount=0;

  @override
  void initState() {
    super.initState();
    fetchToken();
    fetchHistory();
    fetchWishListCount();

  }

  Future<void> fetchToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('auth_token');

    if (storedToken != null) {
      print('Retrieved Token: $storedToken');
      setState(() {
        token = storedToken;
      });
      fetchUserProfile(storedToken);
    } else {
      print('No token found!');
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

  Future<void> fetchHistory() async {
    print("🔄 Fetching history...");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("user_id");
    print("🔍 Stored user_id in SharedPreferences: $userId");

    if (userId == null) {
      print("⚠️ No user_id found! Cannot fetch history.");
      return;
    }

    List<Movie> history = await HistoryService.getHistoryMovies(userId);

    setState(() {
      historyMovies = history;
      historyCount = history.length;
      isLoading = false;
    });

    print("✅ History loaded: ${historyMovies.map((m) => m.title).toList()}");
  }

  Future<void> fetchWishListCount() async {
    int count = await FetchWishList.getFavoriteCount();
    setState(() {
      wishListCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations =
        AppLocalizations.of(context) ?? AppLocalizations.of(context)!;
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
                    Container(
                        color: AppColors.grey,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
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
                                      wishListCount,
                                        appLocalizations.wishList,
                                      )),
                                Expanded(
                                  flex: 2,
                                  child: customWidget(
                                      historyCount,
                                      appLocalizations.history,
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
                                                      user: userProfile),
                                            ),
                                          ).then((value) {
                                            if (value == true) {
                                            fetchUserProfile(
                                                  token!); // إعادة تحميل بيانات المستخدم عند العودة
                                            }
                                          });
                                      } else {
                                        print(
                                            "Token is null, cannot proceed to Profile Update");
                                      }
                                    },
                                      title: appLocalizations.editProfile,
                                    )),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: CustomButton(
                                  title: appLocalizations.exit,
                                  onClick: () {
                                    LogoutService().logoutUser(context);
                                  },
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
                        color: AppColors.grey,
                        child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: AppColors.yellow,
                          // Active tab indicator color
                          labelColor: AppColors.white,
                          // Active tab text color
                          unselectedLabelColor: AppColors.white,
                          // Inactive tab text color
                          indicatorWeight: 3,
                          // Makes the indicator more visible
                          tabs: [
                            Tab(
                            icon: Icon(Icons.list,
                                size: 34, color: AppColors.yellow),
                              text: appLocalizations.wishList,
                            ),
                          Tab(
                            icon: Icon(Icons.folder,
                                size: 34, color: AppColors.yellow),
                              text: appLocalizations.history,
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          FavoritesScreen(),
                            isLoading
                                ? Center(
                                    child:
                                        CircularProgressIndicator()) // ✅ في حالة التحميل
                                : historyMovies.isEmpty
                                    ? Center(
                                        child: Image.asset(
                                          AppAssets.movieHistory,
                                          color: AppColors.white,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.13,
                                        ),
                                      )
                                    : GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: 0.7,
                                          crossAxisSpacing: 16,
                                          mainAxisSpacing: 16,
                                        ),
                                        itemCount: historyMovies.length,
                                        itemBuilder: (context, index) {
                                          print(
                                              "🎬 Displaying movie: ${historyMovies[index].title}");
                                          return MovieDesign(
                                              movie: historyMovies[index]);
                                        },
                                      ),
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
