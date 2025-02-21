import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Function onClick;
  final String title;

  const CustomButton({super.key, required this.title, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: () async {
          onClick();
        },
        child: Text(title));
  }
}
