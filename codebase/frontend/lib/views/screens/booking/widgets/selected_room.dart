import 'package:flutter/material.dart';
import 'package:timetable_app/helpers/extensions.dart';
import 'package:timetable_app/helpers/font_styles.dart';
import 'package:timetable_app/utils/app_colors.dart';

class SelectedRoom extends StatelessWidget {
  final String room;
  const SelectedRoom({
    super.key,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 122,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: 16.border,
        color: AppColors.red,
      ),
      child: Text(
        room,
        style: bold(24).copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
