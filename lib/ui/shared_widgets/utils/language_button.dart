import 'package:flutter/material.dart';
import 'package:movies/core/providers/locale_provider.dart';
import 'package:movies/core/providers/theme_provider.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LanguageButton extends StatelessWidget {
  LanguageButton({super.key});

  late ThemeProvider themeProvider;


  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return InkWell(
      onTap: () {
        localeProvider.locale = localeProvider.locale == 'en'
            ?  'ar'
            :  'en';
      },
      child:  Container(
        alignment: Alignment.center,
        width: 35,
        height: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.yellow),
        child: Text(
          localeProvider.locale.toUpperCase(),
          style:  TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold),
        ),
      ),

    );
  }
}
