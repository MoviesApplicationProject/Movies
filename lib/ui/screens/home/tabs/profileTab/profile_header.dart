import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies/API/auth/logout_service.dart';
import 'package:movies/Model/avatar.dart';
import 'package:movies/Model/get_profile.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/screens/home/tabs/profileTab/profile_update.dart';
import 'package:movies/ui/shared_widgets/custom_button.dart';

class ProfileHeader extends StatelessWidget {
  final GetUserProfileData userProfile;
  final int wishListCount;
  final int historyCount;
  final AppLocalizations appLocalizations;
  final bool isLoading;
  final String? token;
  final Function(String) fetchUserProfile;

  const ProfileHeader({
    super.key,
    required this.userProfile,
    required this.wishListCount,
    required this.historyCount,
    required this.appLocalizations,
    required this.isLoading,
    required this.token,
    required this.fetchUserProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      Avatar.getAvatarById(userProfile.data!.avaterId ?? 0),
                      height: 118,
                      width: 118,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: customWidget(
                    context,
                    wishListCount,
                    appLocalizations.wishList,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: customWidget(
                    context,
                    historyCount,
                    appLocalizations.history,
                  ),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.all(15),
                child: Row(children: [
                  Text(userProfile.data!.name ?? 'N/A',
                      style: Theme.of(context).textTheme.headlineMedium),
                ])),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomButton(
                    onClick: () {
                      if (token != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProfileUpdate(token: token, user: userProfile),
                          ),
                        ).then((value) {
                          if (value == true && token != null) {
                            fetchUserProfile(token!);
                          }
                        });
                      } else {
                      }
                    },
                    title: appLocalizations.editProfile,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    title: appLocalizations.exit,
                    onClick: () {
                      LogoutService().logoutUser(context);
                    },
                    color: AppColors.red,
                    textColor: AppColors.white,
                    icon: ImageIcon(AssetImage(AppIcons.exit)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget customWidget(BuildContext context, int counter, String text) {
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
