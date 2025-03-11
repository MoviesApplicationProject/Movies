import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies/API/profile/delete_service.dart';
import 'package:movies/API/profile/update_profile_service.dart';
import 'package:movies/Model/avatar.dart';
import 'package:movies/Model/get_profile.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/screens/auth/forgetpassword/resetpassword.dart';
import 'package:movies/ui/shared_widgets/custom_button.dart';
import 'package:movies/ui/shared_widgets/custom_text_field.dart';

class ProfileUpdate extends StatefulWidget {
  static const String routeName = "updateProfile";

  final String? token;
  final GetUserProfileData? user;

  const ProfileUpdate({super.key, this.token, this.user});

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  late AppLocalizations appLocalizations;
  late String selectedAvatarAsset;
  late int selectedAvatarId;
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedAvatarAsset =
        Avatar.getAvatarById(widget.user!.data!.avaterId ?? 0);
    selectedAvatarId = widget.user!.data!.avaterId ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations =
        AppLocalizations.of(context) ?? AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        appBar: AppBar(
          title: Text(appLocalizations.pickAvatar),
          backgroundColor: AppColors.black,
          iconTheme: IconThemeData(color: AppColors.yellow),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                    showAvatarBottomSheet(context);
                  },
                child: Container(
                  margin: EdgeInsets.all(35),
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: AppColors.grey,
                      radius: 70,
                      backgroundImage: AssetImage(selectedAvatarAsset),
                    ),
                  ),
                ),
              ),
              CustomTextField(
                readOnly: true,
                hint: widget.user!.data!.name.toString(),
                prefixIcon: ImageIcon(AssetImage(AppIcons.user)),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hint: widget.user!.data!.email.toString(),
                prefixIcon: ImageIcon(AssetImage(AppIcons.emailIcon)),
                controller: emailController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                  hint: widget.user!.data!.phone.toString(),
                prefixIcon: ImageIcon(AssetImage(AppIcons.phoneIcon)),
                controller: phoneController,
              ),
              const SizedBox(height: 10),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, ResetpasswordScreen.routeName);
                  },
                  child: Text(
                    appLocalizations.resetPassword,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                title: appLocalizations.deleteAccount,
                onClick: () async {
                  await DeleteService().deleteProfile(context);
                },
                color: AppColors.red,
                textColor: AppColors.white,
              ),
              const SizedBox(height: 20),
              CustomButton(
                title: appLocalizations.updateAccount,
                onClick: () async {
                  final avatarService = AvatarService(token: widget.token!);

                  await avatarService.updateAvatar(
                    email: emailController.text.trim().isEmpty
                        ? widget.user!.data!.email ?? ""
                        : emailController.text.trim(),
                    avatarId: selectedAvatarId.toString(),
                    phone: phoneController.text,
                    context: context,
                  );
                  setState(() {});
                },
              ),
            ],
          ),
        ]),
        ),
    );
  }

  void showAvatarBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.grey,
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
                              setStateBottomSheet(() {
                                selectedAvatarAsset = avatar['asset'];
                                selectedAvatarId = avatar['id'];
                              });
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.yellow.withOpacity(0.6)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.yellow,
                                width: 3,
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

}
