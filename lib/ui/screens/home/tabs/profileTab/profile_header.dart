import 'package:flutter/material.dart';
import 'package:movies/Model/avatar.dart';
import 'package:movies/Model/get_profile.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileHeader extends StatelessWidget {
  final GetUserProfileData userProfile;
  final int wishListCount;
  final int historyCount;
  final AppLocalizations appLocalizations;

  const ProfileHeader({
    Key? key,
    required this.userProfile,
    required this.wishListCount,
    required this.historyCount,
    required this.appLocalizations,
  }) : super(key: key);

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
