import 'package:flutter/material.dart';
import 'package:timetable_app/helpers/font_styles.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: bold(20),
      ),
    );
  }
}
