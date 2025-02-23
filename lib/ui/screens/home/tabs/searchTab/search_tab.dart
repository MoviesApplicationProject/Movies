import 'package:flutter/material.dart';
import 'package:movies/core/assets/app_assets.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  List<String> Movies = [
    AppAssets.movieDetalies,
    AppAssets.movieDetalies,
    AppAssets.movieDetalies,
    AppAssets.movieDetalies,
  ];
  String userText = "";

  OutlineInputBorder border =
      OutlineInputBorder(borderRadius: BorderRadius.circular(10));

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
//       Column(
//         children: [
//       TextField(
//       decoration: InputDecoration(
//       border: border,
//           enabledBorder: border,
//           focusedBorder: border,
//           labelText: "Search",
//           labelStyle: const TextStyle(color: Colors.white, fontSize: 16),
//           prefixIcon: Container(
//               margin: const EdgeInsets.symmetric(vertical: 14),
//               child: ImageIcon(AssetImage(AppIcons.browseIcon),))),
//     cursorColor: AppColors.white,
//     style: const TextStyle(color: Colors.white, fontSize: 16),
//     onChanged: (string) {
//     userText = string;
//     setState(() {});
//     },
//     ),
//           GridView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             padding: EdgeInsets.all(0),
//             gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 8,
//                 childAspectRatio: 0.67),
//             itemCount: Movies.length,
//             itemBuilder: (context, index) {
//               return buildSimilarMovies(context, Movies[index]);
//             },
//           ),
//         ],
//       );
//
//   }
//   Widget buildSurasListView() {
//     List<String> filteredMovies = [];
//     filteredMovies = Movies.suras.where((sura) {
//       return sura.nameAr.contains(userText) ||
//           sura.nameEn.toLowerCase().contains(userText.toLowerCase());
//     }).toList();
//     return ListView.separated(
//       itemCount: filteredMovies.length,
//       physics: ClampingScrollPhysics(),
//       shrinkWrap: true,
//       itemBuilder: (context, index) {
//         return buildSimilarMovies(context, Movies[index]);
//       },
//       separatorBuilder: (context, index) => Divider(),
//     );
//   }
//   Stack buildSimilarMovies(BuildContext context, String image) {
//     return Stack(
//       children: [
//         buildScreenShot(image),
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
//           width: MediaQuery.of(context).size.width * 0.2,
//           height: MediaQuery.of(context).size.height * 0.05,
//           decoration: BoxDecoration(
//             color: AppColors.black.withOpacity(0.8),
//             borderRadius: BorderRadius.all(Radius.circular(18)),
//           ),
//           child: Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "7.7",
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   ImageIcon(
//                     AssetImage(AppIcons.starIcon),
//                     color: AppColors.yellow,
//                   ),
//                 ],
//               )),
//         ),
//       ],
//     );
//   }
//
// }
