import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:timetable_app/helpers/get_di.dart' as di;
import 'package:timetable_app/theme/app_theme.dart';
import 'package:timetable_app/utils/app_colors.dart';
import 'package:timetable_app/views/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.red,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Class Finder',
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      home: const SafeArea(
        child: SplashScreen(),
      ),
    );
  }
}
