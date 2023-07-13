import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timetable_app/controllers/auth_controller.dart';
import 'package:timetable_app/data/models/body/login_body.dart';
import 'package:timetable_app/helpers/extensions.dart';
import 'package:timetable_app/helpers/font_styles.dart';
import 'package:timetable_app/utils/app_colors.dart';
import 'package:timetable_app/utils/navigation.dart';
import 'package:timetable_app/views/base/custom_button.dart';
import 'package:timetable_app/views/base/custom_snackbar.dart';
import 'package:timetable_app/views/base/custom_textfield.dart';
import 'package:timetable_app/views/screens/dashboard/dashboard.dart';

import '../../../utils/images.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController refId = TextEditingController();
  TextEditingController password = TextEditingController();
  bool obscurePassword = true;
  GlobalKey<FormState> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: Get.height,
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 190,
                    width: 204,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Image.asset(
                          Images.logo,
                          height: 191,
                          width: 204,
                        ).image,
                      ),
                    ),
                  ),
                ),
                50.h,
                Form(
                  key: key,
                  child: Flexible(
                    child:
                        GetBuilder<AuthController>(builder: (authController) {
                      return SizedBox(
                        width: double.maxFinite,
                        child: Card(
                          margin: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 115,
                                  height: 79,
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'LOGIN\n',
                                          style: TextStyle(
                                            letterSpacing: 0.01,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.red,
                                            fontSize: 36,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'to get started',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 17,
                                            letterSpacing: 0.01,
                                            height: 1.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                20.h,
                                CustomTextField(
                                  controller: refId,
                                  hintText: 'Reference ID',
                                  fillColor: AppColors.secondary,
                                  filled: true,
                                  hintStyle: hintStyle,
                                  textInputType: TextInputType.number,
                                  prefixIcon: const Icon(
                                    Icons.numbers,
                                  ),
                                  validator: (st) {
                                    if (st!.isEmpty) {
                                      return 'Required';
                                    }
                                    if (error.contains("ID")) {
                                      return error;
                                    }
                                    return null;
                                  },
                                ),
                                20.h,
                                CustomTextField(
                                  controller: password,
                                  hintText: 'Password',
                                  obscureText: obscurePassword,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      obscurePassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      size: 25,
                                    ),
                                    onPressed: () => setState(() {
                                      obscurePassword = !obscurePassword;
                                    }),
                                  ),
                                  fillColor: AppColors.secondary,
                                  filled: true,
                                  hintStyle: hintStyle,
                                  prefixIcon: const Icon(Icons.key),
                                  validator: (st) {
                                    if (st!.isEmpty) {
                                      return 'Required';
                                    }
                                    if (error.contains("Password")) {
                                      return error;
                                    }
                                    return null;
                                  },
                                ),
                                50.h,
                                Center(
                                  child: authController.isLogging
                                      ? const CircularProgressIndicator()
                                      : SizedBox(
                                          height: 50,
                                          width: 200,
                                          child: CustomButton(
                                            label: 'Login',
                                            onPressed: () {
                                              setState(() {
                                                error = "";
                                              });
                                              if (key.currentState!
                                                  .validate()) {
                                                login(authController);
                                              }
                                            },
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle hintStyle = regular(20).copyWith(
    fontStyle: FontStyle.italic,
  );

  String error = "";

  Future<void> login(AuthController authController) async {
    LoginBody body = LoginBody(
        reference: int.parse(refId.text.trim()),
        password: password.text.trim());
    await authController.login(body).then((status) async {
      if (status.isSuccess) {
        showCustomSnackBar(status.message, isError: !status.isSuccess);
        replaceScreen(context, const Dashboard());
      } else {
        setState(() {
          error = status.message;
        });
        key.currentState!.validate();
      }
    });
  }
}
