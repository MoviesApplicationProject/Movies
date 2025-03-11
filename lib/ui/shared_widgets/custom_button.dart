import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Function onClick;
  final String title;
  final Color? color;
  final Color? textColor;
  final Widget? icon;

  const CustomButton(
      {super.key,
        required this.title,
        required this.onClick,
        this.color = AppColors.yellow,
      this.textColor = AppColors.black,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () async {
        onClick();
      },
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(textColor),
        backgroundColor: WidgetStateProperty.all(color),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(title),
          if (icon != null) ...[
            icon!,
          ],
        ],
      ),
    );
  }
}
