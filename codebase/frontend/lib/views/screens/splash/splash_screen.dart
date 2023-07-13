import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timetable_app/utils/images.dart';
import 'package:timetable_app/views/screens/auth/login.dart';
import 'package:timetable_app/views/screens/dashboard/dashboard.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../../utils/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    if (Get.find<AuthController>().loggedIn()) {
      Timer(const Duration(seconds: 1), () async {
        Get.find<UserController>().getUserInfo().then((value) {
          replaceScreen(context, const Dashboard());
        });
      });
    } else {
      Timer(const Duration(seconds: 1), () async {
        replaceScreen(context, const LoginScreen());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Center(
        child: Image.asset(Images.logo),
      ),
    );
  }
}
