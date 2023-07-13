import 'package:flutter/material.dart';
import 'package:timetable_app/helpers/font_styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? filled;
  final Color? fillColor;
  final String? Function(String?)? validator;
  final BorderSide? borderSide;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final bool obscureText;
  final TextInputType? textInputType;
  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.fillColor,
    this.filled,
    this.borderSide,
    this.labelStyle,
    this.obscureText = false,
    this.textInputType,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscuringCharacter: '*',
      keyboardType: textInputType,
      style: semiBold(16),
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        labelStyle: labelStyle,
        hintStyle: hintStyle,
        fillColor: fillColor,
        filled: filled,
        suffixIcon: suffixIcon,
        errorStyle: regular(14),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: borderSide ?? BorderSide.none,
        ),
      ),
    );
  }
}
