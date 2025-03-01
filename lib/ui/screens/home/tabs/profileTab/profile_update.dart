
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/Model/avatar.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/screens/auth/forgetpassword/forgetpassword.dart';
import 'package:movies/ui/screens/auth/login/login.dart';


class ProfileUpdate extends StatefulWidget {
  static const String routeName = "updateProfile";

  final String? token;
  int? avatarId;
  final String? userName;
  final String? phone;
  final String? email;
  //final VoidCallback? onProfileUpdated;

  ProfileUpdate({super.key, this.token, this.avatarId, this.userName, this.phone, this.email ,});

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  late String selectedAvatarAsset;
  late int selectedAvatarId;

  @override
  void initState() {
    super.initState();
    selectedAvatarAsset = Avatar.getAvatarById(widget.avatarId ?? 0);
    selectedAvatarId = widget.avatarId ?? 0;
  }

  /// Function to update avatar via API
  Future<void> updateAvatar() async {
    if (widget.token == null || widget.email == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Missing authentication data")),
      );
      return;
    }

    final String url = "https://route-movie-apis.vercel.app/profile";
    final Map<String, String> headers = {
      "Authorization": "Bearer ${widget.token}",
      "Content-Type": "application/json"
    };

    final Map<String, dynamic> body = {
      "email": widget.email!,
      "avaterId": selectedAvatarId,
    };

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Avatar updated successfully")),

        );
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => ProfileTab()),
        // );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update avatar")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }
  Future<void> deleteProfile() async {
    if (widget.token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Missing authentication token")),
      );
      return;
    }

    final String url = "https://route-movie-apis.vercel.app/profile";
    final Map<String, String> headers = {
      "Authorization": "Bearer ${widget.token}",
      "Content-Type": "application/json"
    };

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile deleted successfully")),
        );

        // Navigate to login screen after successful deletion
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()), // Replace with actual login screen
              (route) => false, // Clears the navigation stack
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to delete profile")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        // appBar: AppBar(
        //   title: const Text("Pick Avatar"),
        //   backgroundColor: AppColors.black,
        //   iconTheme: IconThemeData(color: AppColors.yellow),
        // ),
        appBar: AppBar(
          title: const Text("Pick Avatar"),
          backgroundColor: AppColors.black,
          iconTheme: IconThemeData(color: AppColors.yellow),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, true); // Return true to indicate an update
            },
          ),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showAvatarBottomSheet(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.gray,
                    radius: 70,
                    backgroundImage: AssetImage(selectedAvatarAsset),
                  ),
                ),
                const SizedBox(height: 50),
                buildTextField("User Name", Icons.person, widget.userName),
                const SizedBox(height: 20),
                buildTextField("Phone", Icons.phone, widget.phone),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 200),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, ForgetpasswordScreen.routeName);
                    },
                    child: Text(
                      "Reset Password",
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 200),
                buildActionButton("Delete Account", AppColors.red, AppColors.white,deleteProfile),
                const SizedBox(height: 10),
                buildActionButton("Update Account", AppColors.yellow, AppColors.black, updateAvatar),
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
      backgroundColor: AppColors.gray,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateBottomSheet) {
            return Container(
              height: 400,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Change Profile Avatar",
                    style: TextStyle(fontSize: 20, color: AppColors.white),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: Avatar.avatars.length,
                      itemBuilder: (context, index) {
                        final avatar = Avatar.avatars[index];
                        bool isSelected = avatar['asset'] == selectedAvatarAsset;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedAvatarAsset = avatar['asset'];
                              selectedAvatarId = avatar['id'];
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isSelected ? AppColors.red : AppColors.yellow,
                                width: isSelected ? 5 : 3,
                              ),
                            ),
                            padding: const EdgeInsets.all(5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                avatar['asset'],
                                fit: BoxFit.cover,
                                width: 70,
                                height: 70,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildTextField(String label, IconData icon, String? value) {
    return TextFormField(
      readOnly: true,
      initialValue: value,
      style: TextStyle(color: AppColors.white, fontSize: 14),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.gray,
        labelText: label,
        labelStyle: TextStyle(color: AppColors.white, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.gray),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.gray, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: Icon(icon, color: AppColors.white, size: 20),
      ),
    );
  }

  Widget buildActionButton(String text, Color bgColor, Color textColor, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 18),
      ),
    );
  }
}
