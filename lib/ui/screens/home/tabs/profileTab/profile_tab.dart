// import 'package:flutter/material.dart';
// import 'package:movies/core/assets/app_assets.dart';
// import 'package:movies/core/assets/app_icons.dart';
// import 'package:movies/core/theme/app_colors.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:movies/ui/screens/home/tabs/profileTab/profile_update.dart';
//
// class ProfileTab extends StatefulWidget {
//   ProfileTab({super.key, this.historyCount = 0, this.wishListCount = 0, this.userName});
//
//   final int historyCount;
//   final int wishListCount;
//   final String? userName; // Can be null
//
//   @override
//   State<ProfileTab> createState() => _ProfileTabState();
// }
//
// class _ProfileTabState extends State<ProfileTab> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//     // return DefaultTabController(
//     //   length: 2, // Only two tabs now
//     //   child: Scaffold(
//     //     backgroundColor: AppColors.gray,
//     //     body: SafeArea(
//     //       child: Padding(
//     //         padding: const EdgeInsets.all(6.0),
//     //         child: Column(
//     //           children: [
//     //             /// Profile Section
//     //             Row(
//     //               children: [
//     //                 Padding(
//     //                   padding: const EdgeInsets.only(top: 40),
//     //                   child: Column(
//     //                     children: [
//     //                       CircleAvatar(
//     //                         backgroundColor: AppColors.gray,
//     //                         radius: 70,
//     //                         child: Image.asset(
//     //                           AppAssets.avatar3,
//     //                           height: 118,
//     //                           width: 118,
//     //                           fit: BoxFit.contain,
//     //                         ),
//     //                       ),
//     //                       Text(
//     //                         widget.userName ?? "User Name", // Defaults to "Guest User" if null
//     //                         style: const TextStyle(
//     //                           color: AppColors.white,
//     //                           fontWeight: FontWeight.w700,
//     //                           fontSize: 18,
//     //                         ),
//     //                       ),
//     //                     ],
//     //                   ),
//     //                 ),
//     //                 const SizedBox(width: 15),
//     //                 counterTextAndCounter(widget.wishListCount, "Wish List", 22, 32),
//     //                 const SizedBox(width: 20),
//     //                 counterTextAndCounter(widget.historyCount, "History", 22, 32),
//     //               ],
//     //             ),
//     //             const SizedBox(height: 15),
//     //
//     //             /// Buttons Section
//     //             Row(
//     //               children: [
//     //                 ElevatedButton(
//     //                   onPressed: () {
//     //                     Navigator.pushNamed(
//     //                       context,
//     //                       ProfileUpdate.routeName,
//     //                       arguments: "User Name ",
//     //                     );
//     //                   },
//     //                   style: ElevatedButton.styleFrom(
//     //                     backgroundColor: AppColors.yellow,
//     //                     shape: RoundedRectangleBorder(
//     //                       borderRadius: BorderRadius.circular(12),
//     //                     ),
//     //                     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//     //                     minimumSize: const Size(230, 56),
//     //                   ),
//     //                   child: Text(
//     //                     "Edit Profile",
//     //                     style: GoogleFonts.roboto(
//     //                       color: AppColors.black,
//     //                       fontSize: 18,
//     //                     ),
//     //                     textAlign: TextAlign.center,
//     //                   ),
//     //                 ),
//     //                 const SizedBox(width: 10),
//     //                 ElevatedButton(
//     //                   onPressed: () {},
//     //                   style: ElevatedButton.styleFrom(
//     //                     backgroundColor: AppColors.red,
//     //                     shape: RoundedRectangleBorder(
//     //                       borderRadius: BorderRadius.circular(12),
//     //                     ),
//     //                     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//     //                     minimumSize: const Size(130, 56),
//     //                   ),
//     //                   child: Row(
//     //                     children: [
//     //                       Text(
//     //                         "Exit",
//     //                         style: GoogleFonts.roboto(
//     //                           color: AppColors.white,
//     //                           fontSize: 18,
//     //                         ),
//     //                       ),
//     //                       const SizedBox(width: 10),
//     //                       ImageIcon(
//     //                         AssetImage(AppIcons.exit),
//     //                         color: AppColors.white,
//     //                         size: 22,
//     //                       ),
//     //                     ],
//     //                   ),
//     //                 ),
//     //               ],
//     //             ),
//     //             const SizedBox(height: 10),
//     //
//     //
//     //             Container(
//     //               width: double.infinity,
//     //               decoration: const BoxDecoration(
//     //                 border: Border(
//     //                   bottom: BorderSide(color: AppColors.gray, width: 2), // Removes white line
//     //                 ),
//     //               ),
//     //               child: const TabBar(
//     //                 indicatorColor: AppColors.yellow, // Active tab indicator color
//     //                 labelColor: AppColors.white, // Active tab text color
//     //                 unselectedLabelColor: AppColors.white, // Inactive tab text color
//     //                 indicatorWeight: 3, // Makes the indicator more visible
//     //                 tabs: [
//     //                   Tab(
//     //                     icon: Icon(Icons.list, size: 34, color: AppColors.yellow),
//     //                     text: "Wish List",
//     //                   ),
//     //                   Tab(
//     //                     icon: Icon(Icons.folder, size: 34, color: AppColors.yellow),
//     //                     text: "History",
//     //                   ),
//     //                 ],
//     //               ),
//     //             ),
//     //
//     //             /// TabBarView for two tabs
//     //             Expanded(
//     //               child: TabBarView(
//     //                 children: [
//     //                   Center(child: Image.asset(AppAssets.popcorn, width: 200, height: 200)),
//     //                   Center(child: Image.asset(AppAssets.movieHistory, color: AppColors.white, width: 150, height: 150)),
//     //                 ],
//     //               ),
//     //             ),
//     //           ],
//     //         ),
//     //       ),
//     //     ),
//     //   ),
//     // );
//   }
// }
//
// /// Counter Widget
// Widget counterTextAndCounter(int counter, String text, double textSize, double counterSize) {
//   return Padding(
//     padding: const EdgeInsets.only(top: 60),
//     child: Column(
//       children: [
//         Text(
//           "$counter",
//           style: TextStyle(
//             color: AppColors.white,
//             fontSize: counterSize,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         Text(
//           text,
//           style: TextStyle(
//             color: AppColors.white,
//             fontSize: textSize,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ],
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:movies/API/fetch_user_profile_data.dart';
import 'package:movies/Model/get_user_profile_data.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/ui/screens/home/tabs/profileTab/profile_update.dart';



class ProfileTab extends StatefulWidget {
  ProfileTab({super.key, this.historyCount = 0, this.wishListCount = 0, this.userName});

  final int historyCount;
  final int wishListCount;
  final String? userName; // Can be null

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  GetUserProfileData? userProfile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  //  fetchUserProfile();
  //  UserProfileService();
  }

  // Future<void> fetchUserProfile() async {
  //   UserProfileService userProfileService = UserProfileService(apiUrl: "https://route-movie-apis.vercel.app/profile");
  //   GetUserProfileData? data = await userProfileService.fetchUserProfile();
  //
  //   if (mounted) {
  //     setState(() {
  //       userProfile = data;
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: AppColors.gray,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userProfile == null
          ? Center(child: Text("Failed to load profile"))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name: ${userProfile?.properties?.data?.properties?.name?.type ?? "N/A"}",
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Email: ${userProfile?.properties?.data?.properties?.email?.type ?? "N/A"}",
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Phone: ${userProfile?.properties?.data?.properties?.phone?.type ?? "N/A"}",
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileUpdate()),
                );
              },
              child: Text("Edit Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
