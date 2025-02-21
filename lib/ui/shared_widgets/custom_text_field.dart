import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatelessWidget {

  final TextEditingController controller;
  final String hint;
  final IconData? iconData;
  final int minLines;
  final bool obscureText;
  final String? error;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;

  CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.iconData,
    this.error,
    this.obscureText =false,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.minLines = 1,
  });

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        TextFormField(
          validator: validator,
          style: Theme.of(context).textTheme.bodyLarge,
          cursorColor: Theme.of(context).primaryColor,
          obscureText: obscureText,
          controller: controller,
          minLines: minLines,
          maxLines: minLines > 1 ? minLines : 1,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            hintMaxLines: minLines,
            hintText: hint,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: error != null
                      ? AppColors.red
                      : AppColors.gray),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: error != null ? AppColors.red : AppColors.gray),
              borderRadius: BorderRadius.circular(16),
            ),
            errorText: error,
          ),
        ),
        Positioned(
          right: 8, // Padding from the right
          top: 8, // Padding from the top
          child: suffixIcon ?? Container(),
        ),
      ],
    );
  }
}
