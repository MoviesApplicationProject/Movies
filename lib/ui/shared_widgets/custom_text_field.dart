import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final IconData? iconData;
  final int minLines;
  final bool obscureText;
  final String? error;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? prefix;
  final String? Function(String?)? validator;
  final Function(String)? onChange;


  const CustomTextField({
    super.key,
    this.controller,
    required this.hint,
    this.iconData,
    this.error,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.onChange,
    this.minLines = 1,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      style: Theme.of(context).textTheme.bodyMedium,
      cursorColor: Theme.of(context).primaryColor,
      obscureText: obscureText,
      controller: controller,
      minLines: minLines,
      maxLines: obscureText ? 1 : minLines > 1 ? minLines : 1,
      onChanged: onChange,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintMaxLines: minLines,
        hintText: hint,
        errorText: error,
        prefix: prefix,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: error != null ? AppColors.red : AppColors.grey,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: error != null ? AppColors.red : Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.red,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.red,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
