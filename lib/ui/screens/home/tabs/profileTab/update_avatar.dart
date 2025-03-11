//
// import 'package:flutter/material.dart';
// import 'package:movies/Model/avatar.dart';
// import 'package:movies/Model/get_profile.dart';
// import 'package:movies/core/theme/app_colors.dart';
//
//
// class UpdateAvatar extends StatefulWidget {
//   final String token;
//   final GetUserProfileData user;
//    String selectedAvatarAsset;
//    int selectedAvatarId;
//
//   UpdateAvatar({super.key , required this.token , required this.user ,required this.selectedAvatarAsset , required this.selectedAvatarId});
//
//   @override
//   State<UpdateAvatar> createState() => _UpdateAvatarState();
// }
//
// class _UpdateAvatarState extends State<UpdateAvatar> {
//   late String selectedAvatarAsset;
//   late int selectedAvatarId;
//
//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//     });
//     selectedAvatarAsset =
//         Avatar.getAvatarById(widget.user!.data!.avaterId ?? 0);
//     selectedAvatarId = widget.user!.data!.avaterId ?? 0;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         showAvatarBottomSheet(context);
//       },
//       child: Container(
//         margin: EdgeInsets.all(35),
//         child: Center(
//           child: CircleAvatar(
//             backgroundColor: AppColors.grey,
//             radius: 70,
//             backgroundImage: AssetImage(widget.selectedAvatarAsset),
//           ),
//         ),
//       ),
//     );
//   }
//   void showAvatarBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: AppColors.grey,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//       ),
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setStateBottomSheet) {
//             return Container(
//               height: 400,
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const SizedBox(height: 20),
//                   Expanded(
//                     child: GridView.builder(
//                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 10,
//                       ),
//                       itemCount: Avatar.avatars.length,
//                       itemBuilder: (context, index) {
//                         final avatar = Avatar.avatars[index];
//                         bool isSelected = avatar['asset'] == widget.selectedAvatarAsset;
//
//                         return GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               setStateBottomSheet(() {
//                                 widget.selectedAvatarAsset = avatar['asset'];
//                                 widget.selectedAvatarId = avatar['id'];
//                               });
//                             });
//                             Navigator.pop(context);
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: isSelected
//                                   ? AppColors.yellow.withOpacity(0.6)
//                                   : Colors.transparent,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                 color: AppColors.yellow,
//                                 width: 3,
//                               ),
//                             ),
//                             padding: const EdgeInsets.all(5),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(8),
//                               child: Image.asset(
//                                 avatar['asset'],
//                                 fit: BoxFit.cover,
//                                 width: 70,
//                                 height: 70,
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//   }
//
