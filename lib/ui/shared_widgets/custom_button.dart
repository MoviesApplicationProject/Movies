import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Function onClick;
  final String title;
  final Color? color;
  final Color? textColor;

  const CustomButton(
      {super.key,
      required this.title,
      required this.onClick,
      this.color = AppColors.yellow,
      this.textColor = AppColors.black});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: () async {
          onClick();
        },
      child: Text(title),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(textColor),
        backgroundColor: MaterialStateProperty.all(color),
      ),
    );
  }
}
