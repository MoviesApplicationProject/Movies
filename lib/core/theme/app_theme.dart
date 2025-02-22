import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData generalTheme = ThemeData(
      fontFamily: 'Roboto',
    scaffoldBackgroundColor: AppColors.black,
    dividerColor:  AppColors.yellow,
    primaryColor: AppColors.yellow,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.black,
      foregroundColor: AppColors.yellow,
      centerTitle: true,
      elevation: 0,
      actionsIconTheme: IconThemeData(
        color: AppColors.yellow,
      ),
      titleTextStyle: TextStyle(
        color: AppColors.yellow,
        fontSize: 16,
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          color: AppColors.white, fontSize: 20, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(
          color: AppColors.white, fontSize: 16, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(
          color: AppColors.white, fontSize: 14, fontWeight: FontWeight.w500),
      bodySmall: TextStyle(
          color: AppColors.white, fontSize: 16, fontWeight: FontWeight.normal),
      labelLarge: TextStyle(
          color: AppColors.white, fontSize: 24, fontWeight: FontWeight.bold),
      labelMedium: TextStyle(
          color: AppColors.white, fontSize: 20, fontWeight: FontWeight.normal),
      labelSmall: TextStyle(
          color: AppColors.yellow, fontSize: 16, fontWeight: FontWeight.bold),
  ),
    dividerTheme: const DividerThemeData(
      color: AppColors.yellow,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.yellow,
        foregroundColor: AppColors.black,
        padding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.gray,
      iconColor: AppColors.white,
      contentPadding:
      const EdgeInsets.all(15),
      errorStyle: const TextStyle(color: AppColors.red),
      filled: true,
      prefixIconColor: AppColors.white,
      suffixIconColor: AppColors.white,
      hintStyle: TextStyle(
        color: AppColors.white,
    )
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            foregroundColor: AppColors.yellow,
            textStyle: const TextStyle(
                color: AppColors.yellow,
                fontWeight: FontWeight.bold,
                fontSize: 16))
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.gray,
      selectedItemColor: AppColors.yellow,
      unselectedItemColor: AppColors.white,
    ),
  iconTheme: IconThemeData(
    color: AppColors.white,
  ),
  );

}