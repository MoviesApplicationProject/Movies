// import 'package:flutter/material.dart';
// import 'package:movies/API/api_service.dart';
// import 'package:movies/Model/movie.dart';
// import 'package:movies/core/assets/app_icons.dart';
// import 'package:movies/core/theme/app_colors.dart';
// import 'package:movies/ui/shared_widgets/custom_button.dart';
//
// class MovieDetalis extends StatefulWidget {
//   static const String routeName = "/movieDetalies";
//
//   const MovieDetalis({super.key});
//
//   @override
//   State<MovieDetalis> createState() => _MovieDetalisState();
// }
//
// class _MovieDetalisState extends State<MovieDetalis> {
//   late Future<List<Movie>> futureMovies;
//
//   @override
//   void initState() {
//     super.initState();
//     // جلب الأفلام من API
//     futureMovies = fetchMovies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(
//             color: AppColors.white,
//             Icons.arrow_back_outlined,
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: ImageIcon(
//               color: AppColors.white,
//               AssetImage(AppIcons.saveIcon),
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<Movie>>(
//         future: futureMovies,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No movies found.'));
//           } else {
//             // في المثال ده هنستخدم أول فيلم في القائمة لعرض تفاصيله
//             final movie = snapshot.data!.first;
//             return ListView(
//               padding: EdgeInsets.zero,
//               children: [
//                 Stack(
//                   children: [
//                     Positioned(
//                       height: MediaQuery.of(context).size.height * 0.82,
//                       child: Image.network(
//                         movie.largeCoverImage, // استخدام صورة من الـ API
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Positioned.fill(
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * 0.82,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.bottomCenter,
//                             end: Alignment.topCenter,
//                             colors: [
//                               AppColors.black.withOpacity(0.9),
//                               Colors.transparent,
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: MediaQuery.of(context).size.height * 0.70,
//                       child: Center(child: Image.asset(AppIcons.videoButton)),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         movie.titleLong,
//                         style: Theme.of(context).textTheme.labelLarge,
//                         textAlign: TextAlign.center,
//                       ),
//                       Container(
//                         margin: const EdgeInsets.all(16),
//                         child: Text(
//                           movie.year.toString(),
//                           style: Theme.of(context).textTheme.headlineLarge,
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       CustomButton(
//                         title: "Watch",
//                         onClick: () {},
//                         color: AppColors.red,
//                         textColor: AppColors.white,
//                       ),
//                       const SizedBox(height: 16),
//                       // مثال لعرض تقييم الفيلم
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           buildRatesIcon(AppIcons.lovedIcon),
//                           buildRatesIcon(AppIcons.timeIcon),
//                           buildRatesIcon(AppIcons.starIcon),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         "Summary",
//                         textAlign: TextAlign.start,
//                         style: Theme.of(context).textTheme.labelLarge,
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         "Rating: ${movie.rating}\nRuntime: ${movie.runtime} minutes",
//                         style: Theme.of(context).textTheme.bodySmall,
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         "Genres",
//                         textAlign: TextAlign.start,
//                         style: Theme.of(context).textTheme.labelLarge,
//                       ),
//                       // لو كان عندك genres من الـ API، يمكنك عرضهم هنا. مثال:
//                       Wrap(
//                         spacing: 8,
//                         children: movie.genres.map((genre) {
//                           return Chip(
//                             label: Text(genre),
//                             backgroundColor: AppColors.gray,
//                           );
//                         }).toList(),
//                       ),
//                       // باقي العناصر مثل Cast, Similar Movies ... إلخ
//                       // يمكن إضافتها بنفس الطريقة بناءً على بيانات الـ API
//                     ],
//                   ),
//                 )
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   Expanded buildRatesIcon(String icon) {
//     return Expanded(
//       flex: 1,
//       child: Container(
//         margin: const EdgeInsets.all(8),
//         height: MediaQuery.of(context).size.height * 0.06,
//         decoration: BoxDecoration(
//           color: AppColors.gray,
//           borderRadius: const BorderRadius.all(Radius.circular(18)),
//         ),
//         child: Center(
//           child: ImageIcon(
//             AssetImage(icon),
//             color: AppColors.yellow,
//           ),
//         ),
//       ),
//     );
//   }
// }
