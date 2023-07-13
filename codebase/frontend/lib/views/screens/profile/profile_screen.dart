import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timetable_app/helpers/extensions.dart';
import 'package:timetable_app/helpers/font_styles.dart';
import 'package:timetable_app/utils/app_colors.dart';
import 'package:timetable_app/utils/navigation.dart';
import 'package:timetable_app/utils/user_formatter.dart';
import 'package:timetable_app/views/screens/profile/timetable_screen.dart';

import '../../../controllers/user_controller.dart';
import '../../../utils/images.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool scheduledNotif = true;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (userController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Image.asset(Images.biggerProfilePicture)),
                    15.h,
                    Text(
                      userFullname(userController.user!),
                      style: bold(30),
                    ),
                    15.h,
                    Text(
                      userController.user!.programme,
                      style: regular(20),
                    ),
                    Text(
                      'Year ${userController.user!.year}',
                      style: regular(20),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                height: 330,
                color: AppColors.secondary,
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        toScreen(context, const TimetableScreen());
                      },
                      leading: const Icon(Icons.calendar_month_rounded),
                      title: Text(
                        'View Timetable',
                        style: medium(18),
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 1.5,
                    ),
                    SwitchListTile.adaptive(
                        title: Text('Schedule Notification', style: medium(18)),
                        value: scheduledNotif,
                        activeColor: AppColors.red,
                        onChanged: (val) {
                          setState(() {
                            scheduledNotif = val;
                          });
                        }),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
