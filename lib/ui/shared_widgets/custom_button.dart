import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Function onClick;
  final String title;
  final Color color;

  const CustomButton({super.key, required this.title, required this.onClick,this.color=AppColors.yellow});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(backgroundColor: color),
        onPressed: () async {
          onClick();
        },
        child: Text(title));
  }
}
