import 'package:flutter/material.dart';
import 'package:timetable_app/helpers/extensions.dart';
import 'package:timetable_app/utils/app_colors.dart';

import '../helpers/font_styles.dart';

ThemeData lightTheme({Color color = const Color.fromRGBO(171, 7, 27, 1)}) =>
    ThemeData(
      fontFamily: 'Quicksand',
      primaryColor: color,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: color,
        titleTextStyle: bold(20).copyWith(color: color),
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      secondaryHeaderColor: AppColors.secondary,
      brightness: Brightness.light,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: color,
      ),
      cardColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.red,
          shape: RoundedRectangleBorder(borderRadius: 30.border),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.red,
        ),
      ),
    );
