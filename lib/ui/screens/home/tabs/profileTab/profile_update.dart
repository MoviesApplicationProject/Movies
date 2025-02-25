import 'package:flutter/material.dart';

import '../../../../../core/assets/app_assets.dart';
import '../../../../../core/theme/app_colors.dart';

class ProfileUpdate extends StatefulWidget {

  static const String routeName= "updateProfile";
  const ProfileUpdate({super.key});
  

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  @override
  Widget build(BuildContext context) {
    final String userName = ModalRoute.of(context)!.settings.arguments as String;

    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: Text("Pike Avatar"),
        backgroundColor: AppColors.black, // Set background color if needed
        iconTheme: IconThemeData(color: AppColors.yellow), // Change back arrow color
      ),
      body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

              children: [
                // Clickable Avatar
                GestureDetector(
                  onTap: () {
                    showAvatarBottomSheet(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.gray,
                    radius: 70,
                    child: Image.asset(
                      AppAssets.avatar3,
                      height: 118,
                      width: 118,
                      //fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // Username Field
                TextField(
                  style: TextStyle(color: AppColors.white, fontSize: 14, fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.gray,
                    labelText: userName,
                    labelStyle: TextStyle(color: AppColors.white, fontSize: 14, fontWeight: FontWeight.normal),
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.gray),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.gray, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.person, color: AppColors.white, size: 20),
                  ),
                ),
                const SizedBox(height: 20),

                // Phone Field
                TextField(
                  style: TextStyle(color: AppColors.white, fontSize: 14, fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.gray,
                    labelText: "011013022125",
                    labelStyle: TextStyle(color: AppColors.white, fontSize: 14, fontWeight: FontWeight.normal),
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.gray),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.gray, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.phone, color: AppColors.white, size: 20),
                  ),
                ),
                const SizedBox(height: 10),

                // text button
                Padding(
                  padding: const EdgeInsets.only(right: 200),
                  child: TextButton(
                      onPressed: (){},
                      child: Text("Reset Password" , style: TextStyle(color: AppColors.white , fontWeight: FontWeight.normal),)),
                ),
                const SizedBox(height: 200),


                // Delete Button
                ElevatedButton(
                  onPressed: () {
                    // Handle delete action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    "Delete Account",
                    style: TextStyle(color: AppColors.white, fontSize: 18 ,fontWeight: FontWeight.normal) ,
                  ),
                ),
                const SizedBox(height: 10),

                // Update data button
                ElevatedButton(
                  onPressed: () {
                    // Handle delete action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    "Delete Account",
                    style: TextStyle(color: AppColors.black, fontSize: 18,fontWeight: FontWeight.normal) ,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),


    );
  }
  void showAvatarBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.gray, // Make background yellow
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all( Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: 400,
          width: 350,// Adjust height as needed
          child: Column(
            children: [
              Text(
                "Change Profile Avatar",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: AppColors.white,
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}
